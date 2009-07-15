# Distributed under the terms of the GNU General Public License

#                                                            #
# /sbin/splash-functions-arch.sh                             #
#                                                            #
# ArchLinux specific splash functions for fbsplash           #
#                                                            #
# Author: Kurt J. Bosch <kujub [at] quantentunnel [dot] de>  #
# Based on the work of:                                      #
#         Greg Helton <gt [at] fallendusk [dot] org>         #
#         Michal Januszewski <spock [at] gentoo [dot] org>   #
# and others.                                                #
#                                                            #

####
####  Extra ArchLinux specific event functions beside splash()
####

# args: sysinit|boot|shutdown
#
# Initialize ArchLinux specific variables and the tmpfs to be ready to run
# splash rc_init and any theme hooks
#
# ### WORKAROUND ### fbcondecor restart: errors about missing silent icons
#                  # with theme using symlinks created by hook script
#                ### All this is done even when verbose mode is required.
#                
splash_pre_init() {
	export SPLASH_MESSAGE
	export SPLASH_MSGLOG_BUSY
	export SPLASH_MSGLOG_DONE
	export SPLASH_MSGLOG_FAIL
	export SPLASH_VERBOSE_ON_ERRORS
	export splash_step=0
	export splash_steps=1
	export splash_runlevel_msg="${SPLASH_BOOT_MESSAGE}"
	# prepare the tmpfs even on shutdown
	# to avoid writing temporary crap to the root FS
	splash_cache_prep || return
	if [ ${1} = boot ]; then
		read -r splash_step  < "${spl_cachedir}"/var_steps_sysinit
		read -r splash_steps < "${spl_cachedir}"/var_steps
		return
	fi
	rm -f "${spl_cachedir}"/step\ *
	rm -f "${spl_cachedir}"/done_*
	rm -f "${spl_cachedir}"/fail_*
	: > "${spl_cachedir}/stat_log"
	splash_steps=0
	if [ "${1}" = shutdown ]; then
		# list daemons and count steps
		splash_steps=$( splash_svclist_init stop )
		if [ "${RUNLEVEL}" = 6 ]
		then	splash_runlevel_msg="${SPLASH_REBOOT_MESSAGE}"
		else	splash_runlevel_msg="${SPLASH_SHUTDOWN_MESSAGE}"
		fi
	fi
	# find stat_busy message texts in rc.${1}
	# strip any ':' and variable parts behind
	# replace all '/' by '_'
	local stat_re='^([^#]*[[:space:]]+)?(stat_busy|status)[[:space:]]+"([^":]+)(:[^"]*)?"([[:space:]].*|$)'
	local msgs_file="${spl_cachedir}/busy_msgs_${1}"
	grep -E "${stat_re}" "/etc/rc.${1}" | \
	sed -r -e "s,${stat_re},\3," -e "s,/,_,g" > "${msgs_file}"
	# count steps and write step numbers to files for lookup
	exec 3<"${msgs_file}"
	local msg
	while read -r -u 3 msg ; do
		(( splash_steps++ ))
		echo ${splash_steps} >"${spl_cachedir}/rc_step ${msg}"
	done
	exec 3<&-
	if [ "${1}" = sysinit ]; then
		# save count for rc.multi (calling this with 'boot')
		echo ${splash_steps} > "${spl_cachedir}/var_steps_sysinit"
		# list daemons and count steps
		local count
		splash_fbsplash_missing=0
		count=$( splash_svclist_init start ) || splash_fbsplash_missing=1
		splash_steps=$(( splash_steps + count ))
		echo ${splash_steps} > "${spl_cachedir}/var_steps"
	fi
}

#
# prepare devices needed to start the splash daemon
splash_devs_prep() {
	# get configuration from /proc/cmdline
	splash_setup force
	[ "${SPLASH_MODE_REQ}" = silent ] || return 0
	# if possible use udev
	if /bin/pidof -o %PPID /sbin/udevd >/dev/null; then
		splash_real_stat_busy "Loading UDev uevents for starting Fbsplash early "
		udevstart="$(/bin/date +%s%0N)"
		/sbin/udevadm trigger --subsystem-match=tty \
			--subsystem-match=graphics --subsystem-match=input
		/sbin/udevadm settle
		splash_real_stat_done
		udevend="$(/bin/date +%s%0N)"
		printhl "   UDev uevent processing time: $((($udevend-$udevstart)/1000000))ms"
	else
### TODO ### - Is there a way to get the keyboard event dev ?
		splash_real_stat_busy "Creating device nodes for starting Fbsplash early "
		/bin/mkdir /dev/fb
		/bin/mknod -m 660 /dev/fb/0 c 29 0
		/bin/chgrp video /dev/fb/0
		/bin/ln -s fb/0 /dev/fb0
		/bin/mkdir /dev/vc
		for i in 0 1 ${SPLASH_TTY} ; do
			/bin/mknod -m 620 /dev/vc/$i c 4 $i
			/bin/chgrp tty /dev/vc/$i
			/bin/ln -s vc/$i /dev/tty$i
		done
		/bin/mknod -m 666 /dev/tty c 5 0
		/bin/chgrp tty /dev/tty
		splash_real_stat_done
	fi
}

# This is for rc.{sysinit,shutdown}
splash_rc_busy() {
	# strip any ':' and parts behind it (variable)
	local msg=${splash_busy_msg%%:*}
	# replace all '/' by '_'
	local file="${spl_cachedir}/rc_step ${msg/\//_}"
	# lookup step number
	if [ -e "${file}" ]; then
		local step
		read -r step < "${file}"
		[ "${step}" -gt "${splash_step}" ] && splash_step=${step}
	fi
	splash_stat_busy
}

# This is for daemon scripts and also continues splash_rc_busy
splash_stat_busy() {
	(
		splash_set_eval_vars
		splash_eval_log "${SPLASH_MSGLOG_BUSY}"
		[ -n "${SPLASH_MESSAGE}" ] && splash_comm_send \
			"set message $( splash_get_boot_message )"
	)
	# doing the repaint neccessary for the messages
	# only on stat_busy and on exit_silent to be faster
	splash_comm_send repaint
}

# args: start|stop
# This is for rc.{sysinit,shutdown}
splash_rc_fail() {
	splash_update_progress
	splash_stat_fail ${1}
}

# args: start|stop
# This is for daemon scripts and also continues splash_rc_fail
splash_stat_fail() {
	[ "${SPLASH_VERBOSE_ON_ERRORS}" = yes ] && splash critical
	# notification about overall failure
	splash_svc_update fbsplash-dummy svc_${1}_failed
	# update splash log
	( splash_set_eval_vars; splash_eval_log "${SPLASH_MSGLOG_FAIL}" )
	# save status
	splash_have_cache || return 0
	touch "${spl_cachedir}/fail_${splash_script}"
	touch "${spl_cachedir}/fail_fbsplash-dummy"
}

# This is for rc.{sysinit,shutdown}
splash_rc_done() {
	splash_update_progress
	splash_stat_done
}

# This is for daemon scripts and also continues splash_rc_done
splash_stat_done() {
	( splash_set_eval_vars; splash_eval_log "${SPLASH_MSGLOG_DONE}" )
}

# args:  start|stop <daemon>
#
# Increment step count and notify the daemon
# We count daemons instead of stat_busys because there can be many of them
# contained in one single daemon script. (nfs-server)
#
# For backgrounded daemons this should be called from within a subshell,
# since we don't count them.
#
splash_pre_daemon() {
	# don't count any second tries from rc.shutdown
	if [ ${1} = start ]; then
		(( splash_step++ ))
	elif ! [ -e "${spl_cachedir}/done_${2}" -o \
	         -e "${spl_cachedir}/fail_${2}" ]; then
		(( splash_step++ ))
	fi
	splash svc_${1} "${2}"
}

# args: start|stop <daemon>
#
# Notify the daemon about success or failure
# This also updates progress and runs any theme hooks.
#
splash_post_daemon() {
	local done=started ; [ ${1} = start ] || done=stopped
	if [ -e "${spl_cachedir}/fail_${2}" ]; then
		splash svc_${1}_failed "${2}"
	else
		splash svc_${done} "${2}"
		# save status
		splash_have_cache && touch "${spl_cachedir}/done_${2}"
	fi
}

splash_restart() {
	# don't restart if we're already kicked to VC 1
	[ "${SPLASH_MODE_REQ}" = silent -a \
	  "$( fgconsole )" = "${SPLASH_TTY}" ] || return 0
	splash_have_daemon && return
	splash rc_init shutdown
}

####
####  Hook-functions overriding those from splash-functions.sh
####

# args: <internal_runlevel> <runlevel>
#
# This function is called when an 'rc_init' event takes place,
# i.e. when the runlevel is changed.
#
splash_init() {
	[ "${SPLASH_MODE_REQ}" = silent ] || return 0
	local was_silent=1 ; [ "$( fgconsole )" = "${SPLASH_TTY}" ] || was_silent=0
	case "${1}" in
		sysinit )
			splash_real_stat_busy "Starting Fbsplash Daemon"
			if [ ${splash_fbsplash_missing} = 1 ]; then
				stat_append " - 'fbsplash' not in DAEMONS or backgrounded !"
				splash_real_stat_fail
				return 1
			fi
		;;
		shutdown ) : ;; # may already have pending stat_busy on console (restart)
		*	 ) return 0 ;;
	esac
	(
		splash_set_eval_vars
		# initial progress in case of restart
		splash_set_progress
		export PROGRESS
		splash_start
	)
	local action
	if [ "${1}" = sysinit ]; then
		if splash_have_daemon
		then	splash_real_stat_done
		else	splash_real_stat_fail
		fi
		### WORKAROUND ### splash going black because of setfont
		CONSOLEFONT=""
		action=start
	else # shutdown
		### WORKAROUND ### icons not painted
		[ ${was_silent} = 0 ] && [[ "${SPLASH_EFFECTS}" == *fadein* ]] && sleep 3
		action=stop
	fi
	splash_have_daemon || return
	# replay any early stuff we missed on sysinit or in case of restart on shutdown
	splash_update_progress
	splash_stat_replay ${action}
	splash_comm_send repaint
}

# args: <svc>
#
# This function is called whenever the progress variable should be
# updated.  It should recalculate the progress and send it to the
# splash daemon.
splash_update_progress() {
	local PROGRESS
	splash_set_progress
	splash_comm_send "progress ${PROGRESS}"
	splash_comm_send paint
}

# args: <runlevel>|kill
#
# This function is called when an 'rc_exit' event takes place.
#
splash_exit() {
	if ! splash_have_daemon ; then
# ### WORKAROUND ### fbcondecor restart: errors about missing silent icons
#                  # with theme using symlinks created by hook script
		 ### disabled: # splash_cache_cleanup
		return 0
	fi
	if [[ "${1}" == [06] ]]; then
		# overall success notification
		[ -e "${spl_cachedir}/fail_fbsplash-dummy" ] ||
			splash_svc_update fbsplash-dummy svc_stopped
		# final message
		splash_comm_send "set message $(
			splash_echo "${splash_runlevel_msg}"
		)"
		splash_comm_send repaint
	elif [ "${1}" != kill ]; then
		# force progress to 100%
		splash_step=${splash_steps}
		splash_update_progress
		# overall success notification
		[ -e "${spl_cachedir}/fail_fbsplash-dummy" ] ||
			splash_svc_update fbsplash-dummy svc_started
		# booted message
		splash_comm_send "set message $( 
			splash_set_eval_vars
			BUSY_MSG=""
			RUNLEVEL_MSG="${splash_runlevel_msg}"
			SCRIPT=""
			eval msg=\"${SPLASH_MESSAGE_BOOTED}\"
			splash_echo "${msg}"
		)"
		splash_comm_send repaint
	fi
	splash_real_stat_busy "Stopping Fbsplash Daemon"
	if [ "${1}" != kill ]; then
		# send exit command
		if [[ "${1}" == [06] || "${SPLASH_STAY_SILENT}" = yes ]]
		then	splash_comm_send "exit staysilent"
		else	splash_comm_send "exit"
		fi
		# give the daemon some time for painting
		local -i i timeout=2
		[[ "${SPLASH_EFFECTS}" == *fadeout* ]] && timeout+=5
		for (( i=0; i<timeout*10; i++ )) ; do
			splash_have_daemon || break
			sleep 0.1
		done
	fi
	# be sure to get rid of the daemon
	killall -q -w -9 "${spl_daemon##*/}"
# ### WORKAROUND ### fbcondecor restart: errors about missing silent icons
#                  # with theme using symlinks created by hook script
	### disabled: # splash_cache_cleanup
	if splash_have_daemon
	then	splash_real_stat_fail
	else	splash_real_stat_done
	fi
# ### WORKAROUND ### splash going black
	if [[ "${1}" != [06] && "${1}" != kill && -n "$CONSOLEFONT" ]]; then
		splash_set_consolefont
	fi
}

####
####  Additional functions overriding those from splash-functions.sh
####

#
# don't do multiple mounts
# print nice stat messages to the console
splash_cache_prep() {
	splash_have_cache && return
	splash_real_stat_busy "Mounting Fbsplash Cache Filesystem"
	# Mount an in-RAM filesystem at spl_cachedir
	mount -ns -t "${spl_cachetype}" cachedir "${spl_cachedir}" \
		-o rw,mode=0644,size="${spl_cachesize}"k
	local retval=$?
	if [ ${retval} -ne 0 ]; then
		splash_real_stat_fail
		splash_verbose
		return "${retval}"
	fi
	splash_real_stat_done
}

if [ -n "${SPLASH_MESSAGE}" ]; then

	# This is called when the splash daemon is started and when the
	# message needs to be updated.
	#
	# provide messages in a more informative way
	splash_get_boot_message() {
		local msg
		eval msg=\"${SPLASH_MESSAGE}\"
		splash_echo "${msg}"
	}
fi

# args: <svc> <action>
#
# This is called on svc_started or svc_stopped events.
#
# don't write upply generic log messages here.
splash_svc() {
	if [ "${2}" = start ]; then
		splash_svc_update "${1}" svc_started
		if [ "${1}" = "gpm" ]; then
			splash_comm_send "set gpm"
			splash_comm_send repaint
		fi
	else
		splash_svc_update "${1}" svc_stopped
	fi
	splash_update_progress "${1}"
}

# args: <svc> <action>
#
# This is called on svc_start_failed or svc_stopp_failed events.
#
# don't write upply generic log messages here.
splash_svc_fail() {
	if [ "${SPLASH_VERBOSE_ON_ERRORS}" = yes ]; then
		splash_verbose
		return 1
	fi
	splash_svc_update "${1}" svc_${2}_failed
	splash_update_progress "${1}"
}

####
####  Misc. functions - also useful for theme hook scripts
####

# args: <type>
#
# Counterpart to splash_svclist_get found in splash-functions.sh
# 
# This is also usefull for the rc_init-pre theme hook to get an updated
# daemons list whenever the splash daemon is restarted.
#
# type  - meaning
# -----------------
# start - bootup
# stop  - shutdown
#
# create the services/daemons list
# echo the daemons count
# at bootup: return 1 if fbsplash is missing in DAEMONS
splash_svclist_init() {
	splash_have_cache || return 2
	local retval=0
	local count=0
	local daemon
	if [ ${1} = start ]; then
		retval=1
		for daemon in "${DAEMONS[@]}"; do
			[ "$daemon" = "${daemon#!}" -a \
			  "$daemon" = "${daemon#@}" ] || continue
			(( count++ ))
			echo $daemon
			if [ "$daemon" = fbsplash ]; then
				retval=0
				break
			fi
		done
	else
		for daemon in $(/bin/ls -1t /var/run/daemons); do
			(( count++ ))
			echo $daemon
		done
	fi > "${spl_cachedir}"/svcs_${1}
	echo ${count}
	return ${retval}
}

splash_have_daemon() {
	[ -n "$( pidof "${spl_daemon##*/}" )" ]
}

splash_have_cache() {
	# don't try to use /proc here !
	[ "$( stat -f -c%T "${spl_cachedir}" )" = "${spl_cachetype}" -a \
		-w "${spl_cachedir}" ]
}

export -f splash_svclist_init
export -f splash_have_daemon
export -f splash_have_cache

####
####  Internal functions
####

# set variables needed for eval SPLASH_MESSAGE and SPLASH_MSGLOG_*
splash_set_eval_vars() {
	BUSY_MSG="${splash_busy_msg}"
	SCRIPT="${splash_script}"
	STEP="${splash_step}"
	STEPS="${splash_steps}"
	PROGRESS=\$progress # the splash daemon knows this
	RUNLEVEL_MSG="${splash_runlevel_msg}"
}

# calculate and set PROGRESS
splash_set_progress() {
	PROGRESS=65535 # 100%
	[ "${splash_step}" -lt "${splash_steps}" ] && \
		PROGRESS=$(( PROGRESS * ${splash_step} / ${splash_steps} ))
}

# arg: <splash_msglog>
#
# add a line to the message log
splash_eval_log() {
	[ -z "${1}" ] && return
	local msg
	eval msg=\"${1}\"
	splash_comm_send "log ${msg}"
	# save log lines for defered start or restart
	splash_have_cache && echo "${msg}" >> "${spl_cachedir}/stat_log"
}

# arg: start|stop
#
# Replay daemon/theme status
#
# The theme hooks are not called again here by now.
#
splash_stat_replay()
(
	done=started
	[ ${1} = start ] || done=stopped
	# notification about overall job started
	splash svc_${action} fbsplash-dummy
	cd "${spl_cachedir}"
	# replay daemons done
	for file in done_* ; do
		splash_svc_update ${file#done_} svc_${done}
	done
	# replay daemons failed
	for file in fail_* ; do
		splash_svc_update ${file#fail_} svc_${1}_failed
	done
	# replay log messages
	while read -r line ; do
		splash_comm_send "log ${line}"
	done < stat_log
)

####
####  Workaround functions
####


# args: <msg>
#
# ### WORKAROUND ### # blank message string killing the splash daemon
#
splash_echo() {
	if [ -z "${1%% }" ]
	then	echo $'\302\240' # UTF-8 no-break space
	else	echo "${1}"
	fi
}

# ### WORKAROUND ### # setfonts destroying the splash
#
# This code was copied from /etc/rc.sysinit from initscripts 2009.03.
#
# defere this stuff to the point where the splash daemon finished
splash_set_consolefont() {
if [ -n "$CONSOLEFONT" ]; then
	stat_busy "Loading Console Font: $CONSOLEFONT"
	#CONSOLEMAP in UTF-8 shouldn't be used
	if [ -n "$CONSOLEMAP" ] && echo "$LOCALE" | /bin/grep -qi utf ; then
		CONSOLEMAP=""
	fi
	for i in $(/usr/bin/seq 0 63); do
		if [ -n "$CONSOLEMAP" ]; then
			/usr/bin/setfont -m $CONSOLEMAP $CONSOLEFONT -C /dev/vc/${i} >/dev/null 2>&1
		else
			/usr/bin/setfont $CONSOLEFONT -C /dev/vc/${i} >/dev/null 2>&1
		fi
	done
	if [ $? -ne 0 ]; then
		stat_fail
	else
		for i in $(/usr/bin/seq 0 63); do
			printf "\e(K" > /dev/vc/${i}
		done
		# the $CONSOLE check helps us avoid this when running scripts from cron
		echo 'if [ "$CONSOLE" = "" -a "$TERM" = "linux" -a -t 1 ]; then printf "\e(K"; fi' >>/etc/profile.d/locale.sh
		stat_done
	fi
fi
}

# EOF #
