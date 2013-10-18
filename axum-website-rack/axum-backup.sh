#!/bin/bash
echo -e "HTTP/1.0 200 OK\r"
echo -e "Content-Type: application/octet-stream\r"
echo -e "Content-Disposition: attachment; filename=\"axum_rack_backup_$( date '+%F_%H-%M-%S').raw\""
echo -e "Content-Length: $( fdisk /dev/sda -l | grep 'Disk /dev/sda' | awk '{ print $5 }')\r"
echo -e "Connection: close\r"
echo -e "\r"
dd if=/dev/sda 2> /dev/null


