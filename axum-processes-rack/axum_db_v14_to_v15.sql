BEGIN;

-- Do conversion of global functions to buss/console function
CREATE OR REPLACE FUNCTION convert_global_to_console(console_func integer, console_seq integer, global_func integer) RETURNS integer AS $$
DECLARE
BEGIN
  UPDATE predefined_node_config
   SET func.type = 3, func.seq = console_seq, func.func = console_func 
   WHERE (func).type = 4 AND (func).func = global_func;
  
  UPDATE node_config
   SET func.type = 3, func.seq = console_seq, func.func = console_func 
   WHERE (func).type = 4 AND (func).func = global_func;

  RETURN NULL;
END
$$ LANGUAGE plpgsql;

-- BUSS RESET 
UPDATE predefined_node_config
 SET func.type = 1, func.seq = (func).func-8, func.func=12 
 WHERE (func).type = 4 AND (func).func>=8 AND (func).func<=23;

UPDATE node_config
 SET func.type = 1, func.seq = (func).func-8, func.func=12 
 WHERE (func).type = 4 AND (func).func>=8 AND (func).func<=23;

-- CONTROL MODE ACTIVE (console 0)
SELECT convert_global_to_console(0, (func).func-533, (func).func)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 533 AND (func).func <537;

-- CONTROL MODE SOURCE (console 1) 
SELECT convert_global_to_console(1, 0, 24);
SELECT convert_global_to_console(1, 1, 89);
SELECT convert_global_to_console(1, 2, 154);
SELECT convert_global_to_console(1, 3, 219);

-- CONTROL MODE MOD PRESET (console 2)
SELECT convert_global_to_console(2, (func).func-377, (func).func)
FROM functions 
WHERE (func).type = 4 AND (func).func >= 377 AND (func).func <381;

-- CONTROL MODE SOURCE GAIN (console 3)
SELECT convert_global_to_console(3, 0, 25);
SELECT convert_global_to_console(3, 1, 90);
SELECT convert_global_to_console(3, 2, 155);
SELECT convert_global_to_console(3, 3, 220);

-- CONTROL MODE PHANTOM (console 4)
SELECT convert_global_to_console(4, 0, 358);
SELECT convert_global_to_console(4, 1, 361);
SELECT convert_global_to_console(4, 2, 364);
SELECT convert_global_to_console(4, 3, 367);

-- CONTROL MODE PAD (console 5)
SELECT convert_global_to_console(5, 0, 359);
SELECT convert_global_to_console(5, 1, 362);
SELECT convert_global_to_console(5, 2, 365);
SELECT convert_global_to_console(5, 3, 368);

-- CONTROL MODE SOURCE GAIN (console 6)
SELECT convert_global_to_console(6, 0, 26);
SELECT convert_global_to_console(6, 1, 91);
SELECT convert_global_to_console(6, 2, 156);
SELECT convert_global_to_console(6, 3, 221);

-- CONTROL MODE PHASE  (console 7)
SELECT convert_global_to_console(7, 0, 27);
SELECT convert_global_to_console(7, 1, 92);
SELECT convert_global_to_console(7, 2, 157);
SELECT convert_global_to_console(7, 3, 222);

-- CONTROL MODE LOW CUT (console 8)
SELECT convert_global_to_console(8, 0, 28);
SELECT convert_global_to_console(8, 1, 93);
SELECT convert_global_to_console(8, 2, 158);
SELECT convert_global_to_console(8, 3, 223);

-- CONTROL MODE INSERT (console 9)
SELECT convert_global_to_console(9, (func).func-485, (func).func)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 485 AND (func).func <489;

-- EQ (console 10-33)
SELECT convert_global_to_console((func).func-19, 0, (func).func), 
       convert_global_to_console((func).func-19, 1, (func).func+65),
       convert_global_to_console((func).func-19, 2, (func).func+130),
       convert_global_to_console((func).func-19, 3, (func).func+195)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 29 AND (func).func <53;

-- CONTROL MODE EQ ON/OFF (console 34)
SELECT convert_global_to_console(34, 0, 357);
SELECT convert_global_to_console(34, 1, 360);
SELECT convert_global_to_console(34, 2, 363);
SELECT convert_global_to_console(34, 3, 366);

-- CONTROL MODE EXP TH (console 35)
SELECT convert_global_to_console(35, (func).func-373, (func).func)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 373 AND (func).func <377;

-- CONTROL MODE AGC TH (console 36)
SELECT convert_global_to_console(36, (func).func-369, (func).func)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 369 AND (func).func <373;

-- CONTROL MODE AGC (console 37)
SELECT convert_global_to_console(37, 0, 53);
SELECT convert_global_to_console(37, 1, 118);
SELECT convert_global_to_console(37, 2, 183);
SELECT convert_global_to_console(37, 3, 248);

-- CONTROL MODE DYN ON/OFF (console 38)
SELECT convert_global_to_console(38, (func).func-489, (func).func)
FROM functions 
WHERE (func).type = 4 AND (func).func >= 489 AND (func).func <493;

-- CONTROL MODE MONO (console 39)
SELECT convert_global_to_console(39, 0, 54);
SELECT convert_global_to_console(39, 1, 119);
SELECT convert_global_to_console(39, 2, 184);
SELECT convert_global_to_console(39, 3, 249);

-- CONTROL MODE PAN (console 40)
SELECT convert_global_to_console(40, 0, 55);
SELECT convert_global_to_console(40, 1, 120);
SELECT convert_global_to_console(40, 2, 185);
SELECT convert_global_to_console(40, 3, 250);

-- CONTROL MODE MOD LEVEL (console 41)
SELECT convert_global_to_console(41, 0, 56);
SELECT convert_global_to_console(41, 1, 121);
SELECT convert_global_to_console(41, 2, 186);
SELECT convert_global_to_console(41, 3, 251);

-- BUSSES (console 42-73)
SELECT convert_global_to_console((func).func-15, 0, (func).func), 
        convert_global_to_console((func).func-15, 1, (func).func+65),
        convert_global_to_console((func).func-15, 2, (func).func+130),
        convert_global_to_console((func).func-15, 3, (func).func+195)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 57 AND (func).func <89;

-- MASTER CONTROL MODE (console 74-89)
SELECT convert_global_to_console((func).func-210, 0, (func).func), 
       convert_global_to_console((func).func-210, 1, (func).func+16),
       convert_global_to_console((func).func-210, 2, (func).func+32),
       convert_global_to_console((func).func-210, 3, (func).func+48)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 284 AND (func).func <300;

-- MASTER CONTROL (console 90)
SELECT convert_global_to_console(90, 0, 348);
SELECT convert_global_to_console(90, 1, 350);
SELECT convert_global_to_console(90, 2, 352);
SELECT convert_global_to_console(90, 3, 354);

-- MASTER CONTROL RESET (console 91)
SELECT convert_global_to_console(91, 0, 349);
SELECT convert_global_to_console(91, 1, 351);
SELECT convert_global_to_console(91, 2, 353);
SELECT convert_global_to_console(91, 3, 355);

-- CONSOLE TO PROGRAMMED DEFAULTS (console 92)
SELECT convert_global_to_console(92, (func).func-381, (func).func)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 381 AND (func).func <385;

-- MASTER & BUSSES (console 93-108)
SELECT convert_global_to_console((func).func-324, 0, (func).func), 
       convert_global_to_console((func).func-324, 1, (func).func+16),
       convert_global_to_console((func).func-324, 2, (func).func+32),
       convert_global_to_console((func).func-324, 3, (func).func+48)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 417 AND (func).func <433;
                  
-- CONSOLE PRESETS (console 109)
SELECT convert_global_to_console(109, (func).func-481, (func).func)
 FROM functions 
 WHERE (func).type = 4 AND (func).func >= 481 AND (func).func <485;

-- MODULE SELECT (console 110)
SELECT convert_global_to_console(110, (func).func-493, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 493 AND (func).func <497;

-- BUSS SELECT (console 111)
SELECT convert_global_to_console(111, (func).func-497, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 497 AND (func).func <501;

-- MONITOR BUSS SELECT (console 112)
SELECT convert_global_to_console(112, (func).func-501, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 501 AND (func).func <505;

-- SOURCE SELECT (console 113)
SELECT convert_global_to_console(113, (func).func-505, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 505 AND (func).func <509;

-- DESTINATION SELECT (console 114)
SELECT convert_global_to_console(114, (func).func-509, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 509 AND (func).func <513;

-- CHIPCARD CHANGE (console 115)
SELECT convert_global_to_console(115, (func).func-513, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 513 AND (func).func <517;

-- CHIPCARD USER (console 116)
SELECT convert_global_to_console(116, (func).func-517, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 517 AND (func).func <521;

-- CHIPCARD PASS (console 117)
SELECT convert_global_to_console(117, (func).func-521, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 521 AND (func).func <525;

-- CHIPCARD WRITE (console 118)
SELECT convert_global_to_console(118, (func).func-541, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 541 AND (func).func <545;

-- UPDATE USER (console 119)
SELECT convert_global_to_console(119, (func).func-525, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 525 AND (func).func <529;

-- UPDATE PASS (console 120)
SELECT convert_global_to_console(120, (func).func-529, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 529 AND (func).func <533;

-- UPDATE USER/PASS (console 121)
SELECT convert_global_to_console(121, (func).func-537, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 537 AND (func).func <541;

-- UPDATE USER LEVEL (console 122)
SELECT convert_global_to_console(122, (func).func-545, (func).func)
 FROM functions
 WHERE (func).type = 4 AND (func).func >= 545 AND (func).func <549;

-- MOVE GLOBAL CONSOLE PRESETS DIRECT AFTER REDLIGHTS
UPDATE predefined_node_config
 SET func.func=(func).func-377 
 WHERE (func).type = 4 AND (func).func>=385 AND (func).func<=416;

UPDATE node_config
 SET func.func = (func).func-377
 WHERE (func).type = 4 AND (func).func>=385 AND (func).func<=416;

-- DROP CONVERTION FUNCTION
DROP FUNCTION convert_global_to_console(console_func integer, console_seq integer, global_func integer);

-- ADD TABLE FOR CONSOLE INFORMATION

CREATE TABLE console_config
(
  number smallint NOT NULL CHECK (number>=1 AND number<=4) PRIMARY KEY,
  name varchar(64),
  location varchar(64),
  contact varchar(64),
  username varchar(32) NOT NULL DEFAULT '',
  password varchar(16) NOT NULL DEFAULT '',
  chipcard_username varchar(32) NOT NULL DEFAULT '',
  chipcard_password varchar(16) NOT NULL DEFAULT '',
  program_end_time varchar(8) NOT NULL DEFAULT '00:00:00',
  program_end_time_enable boolean NOT NULL DEFAULT false
);

INSERT INTO console_config (number) SELECT * FROM generate_series(1, 4);

CREATE OR REPLACE FUNCTION console_config_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('console_config_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('console_config_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER console_config_notify AFTER UPDATE ON console_config FOR EACH ROW EXECUTE PROCEDURE console_config_changed();

CREATE OR REPLACE FUNCTION functions_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('functions_changed', OLD.func::text);
  ELSIF TG_OP = 'UPDATE' THEN
    IF OLD.user_level0 <> NEW.user_level0 AND
       OLD.user_level1 <> NEW.user_level1 AND
       OLD.user_level2 <> NEW.user_level2 AND
       OLD.user_level3 <> NEW.user_level3 AND
       OLD.user_level4 <> NEW.user_level4 AND
       OLD.user_level5 <> NEW.user_level5 THEN 
      INSERT INTO recent_changes (change, arguments) VALUES('functions_changed', NEW.func::text);
    END IF;
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('functions_changed', NEW.func::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER functions_notify AFTER UPDATE ON functions FOR EACH ROW EXECUTE PROCEDURE functions_changed();

-- REMOVE GLOBAL COLOMNs username1-4 and password1-4

ALTER TABLE global_config
  DROP COLUMN username1,
  DROP COLUMN username2,
  DROP COLUMN username3,
  DROP COLUMN username4,
  DROP COLUMN password1,
  DROP COLUMN password2,
  DROP COLUMN password3,
  DROP COLUMN password4;

-- Change constrains on user_level in users table
ALTER TABLE users
  DROP CONSTRAINT users_console1_user_level_check,
  DROP CONSTRAINT users_console2_user_level_check,
  DROP CONSTRAINT users_console3_user_level_check,
  DROP CONSTRAINT users_console4_user_level_check;

UPDATE users SET console1_user_level = 2 WHERE console1_user_level<2;
UPDATE users SET console2_user_level = 2 WHERE console2_user_level<2;
UPDATE users SET console3_user_level = 2 WHERE console3_user_level<2;
UPDATE users SET console4_user_level = 2 WHERE console4_user_level<2;

ALTER TABLE users
  ADD CONSTRAINT users_console1_user_level_check CHECK(console1_user_level>=2 AND console1_user_level<=6),
  ADD CONSTRAINT users_console2_user_level_check CHECK(console2_user_level>=2 AND console2_user_level<=6),
  ADD CONSTRAINT users_console3_user_level_check CHECK(console3_user_level>=2 AND console3_user_level<=6),
  ADD CONSTRAINT users_console4_user_level_check CHECK(console4_user_level>=2 AND console4_user_level<=6);

ALTER TABLE users
  ADD COLUMN console1_preset_load boolean NOT NULL DEFAULT false,
  ADD COLUMN console2_preset_load boolean NOT NULL DEFAULT false,
  ADD COLUMN console3_preset_load boolean NOT NULL DEFAULT false,
  ADD COLUMN console4_preset_load boolean NOT NULL DEFAULT false,
  ADD COLUMN logout_to_idle boolean NOT NULL DEFAULT true,
  ADD COLUMN active boolean NOT NULL DEFAULT true;

-- ADD related destinations in src_config
ALTER TABLE src_config
  ADD COLUMN related_dest integer DEFAULT NULL,
  ADD FOREIGN KEY (related_dest) REFERENCES dest_config (number) ON DELETE SET NULL ON UPDATE CASCADE;

-- Make exclusive smallint to enable the communication option
ALTER TABLE buss_config ALTER COLUMN exclusive DROP DEFAULT;
ALTER TABLE buss_config ALTER COLUMN exclusive TYPE smallint 
  USING CASE 
    WHEN exclusive = false THEN 0
    WHEN exclusive = true THEN 1
  END;
ALTER TABLE buss_config ALTER COLUMN exclusive SET DEFAULT 0;
ALTER TABLE buss_config
  ADD CONSTRAINT buss_config_exclusive_check CHECK (exclusive >= 0 AND exclusive <= 3);

-- INSERT all git-15 functions
TRUNCATE functions;

INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,0)', 'Label', 0, 4, 1, 'Label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,1)', 'Source', 2, 4, 2, 'SRC', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,259)', 'Module preset A', 3, 3, 3, 'A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,260)', 'Module preset B', 3, 3, 4, 'B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,261)', 'Module preset A/B', 3, 3, 5, 'A/B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,2)', 'Module preset 1A', 3, 3, 6, '1A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,3)', 'Module preset 1B', 3, 3, 7, '1B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,183)', 'Module preset 2A', 3, 3, 8, '2A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,184)', 'Module preset 2B', 3, 3, 9, '2B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,207)', 'Module preset 3A', 3, 3, 10, '3A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,208)', 'Module preset 3B', 3, 3, 11, '3B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,209)', 'Module preset 4A', 3, 3, 12, '4A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,210)', 'Module preset 4B', 3, 3, 13, '4B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,4)', 'Source phantom', 3, 3, 14, 'Phantom', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,5)', 'Source pad', 3, 3, 15, 'Pad', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,6)', 'Source gain level', 2, 4, 16, 'SRC gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,6)', 'Source gain level', 1, 1, 17, 'SRC gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,7)', 'Source gain level reset', 3, 0, 18, 'SRC gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,8)', 'Insert on/off', 3, 3, 19, 'Insert', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,193)', 'Phase', 2, 4, 20, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,9)', 'Phase on/off', 3, 3, 21, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,10)', 'Gain level', 0, 1, 22, 'Gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,10)', 'Gain level', 2, 4, 23, 'Gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,11)', 'Gain level reset', 3, 0, 24, 'Gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,12)', 'Low cut frequency', 2, 4, 25, 'LC freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,12)', 'Low cut frequency', 0, 1, 26, 'LC freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,13)', 'Low cut on/off', 3, 3, 27, 'LC', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,14)', 'EQ Band 1 level', 2, 4, 28, 'EQ1 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,14)', 'EQ Band 1 level', 5, 5, 29, 'EQ1 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,15)', 'EQ Band 1 frequency', 2, 4, 30, 'EQ1 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,15)', 'EQ Band 1 frequency', 1, 1, 31, 'EQ1 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,16)', 'EQ Band 1 bandwidth', 2, 4, 32, 'EQ1 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,16)', 'EQ Band 1 bandwidth', 5, 5, 33, 'EQ1 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,17)', 'EQ Band 1 level reset', 3, 0, 34, 'EQ1 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,18)', 'EQ Band 1 frequency reset', 3, 0, 35, 'EQ1 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,19)', 'EQ Band 1 bandwidth reset', 3, 0, 36, 'EQ1 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,20)', 'EQ Band 1 type', 2, 4, 37, 'EQ1 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,20)', 'EQ Band 1 type', 3, 3, 38, 'EQ1 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,21)', 'EQ Band 2 level', 2, 4, 39, 'EQ2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,21)', 'EQ Band 2 level', 5, 5, 40, 'EQ2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,22)', 'EQ Band 2 frequency', 2, 4, 41, 'EQ2 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,22)', 'EQ Band 2 frequency', 1, 1, 42, 'EQ2 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,23)', 'EQ Band 2 bandwidth', 2, 4, 43, 'EQ2 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,23)', 'EQ Band 2 bandwidth', 5, 5, 44, 'EQ2 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,24)', 'EQ Band 2 level reset', 3, 0, 45, 'EQ2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,25)', 'EQ Band 2 frequency reset', 3, 0, 46, 'EQ2 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,26)', 'EQ Band 2 bandwidth reset', 3, 0, 47, 'EQ2 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,27)', 'EQ Band 2 type', 2, 4, 48, 'EQ2 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,27)', 'EQ Band 2 type', 3, 3, 49, 'EQ2 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,28)', 'EQ Band 3 level', 2, 4, 50, 'EQ3 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,28)', 'EQ Band 3 level', 5, 5, 51, 'EQ3 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,29)', 'EQ Band 3 frequency', 2, 4, 52, 'EQ3 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,29)', 'EQ Band 3 frequency', 1, 1, 53, 'EQ3 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,30)', 'EQ Band 3 bandwidth', 2, 4, 54, 'EQ3 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,30)', 'EQ Band 3 bandwidth', 5, 5, 55, 'EQ3 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,31)', 'EQ Band 3 level reset', 3, 0, 56, 'EQ3 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,32)', 'EQ Band 3 frequency reset', 3, 0, 57, 'EQ3 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,33)', 'EQ Band 3 bandwidth reset', 3, 0, 58, 'EQ3 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,34)', 'EQ Band 3 type', 2, 4, 59, 'EQ3 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,34)', 'EQ Band 3 type', 3, 3, 60, 'EQ3 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,35)', 'EQ Band 4 level', 2, 4, 61, 'EQ4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,35)', 'EQ Band 4 level', 5, 5, 62, 'EQ4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,36)', 'EQ Band 4 frequency', 2, 4, 63, 'EQ4 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,36)', 'EQ Band 4 frequency', 1, 1, 64, 'EQ4 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,37)', 'EQ Band 4 bandwidth', 2, 4, 65, 'EQ4 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,37)', 'EQ Band 4 bandwidth', 5, 5, 66, 'EQ4 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,38)', 'EQ Band 4 level reset', 3, 0, 67, 'EQ4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,39)', 'EQ Band 4 frequency reset', 3, 0, 68, 'EQ4 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,40)', 'EQ Band 4 bandwidth reset', 3, 0, 69, 'EQ4 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,41)', 'EQ Band 4 type', 2, 4, 70, 'EQ4 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,41)', 'EQ Band 4 type', 3, 3, 71, 'EQ4 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,42)', 'EQ Band 5 level', 2, 4, 72, 'EQ5 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,42)', 'EQ Band 5 level', 5, 5, 73, 'EQ5 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,43)', 'EQ Band 5 frequency', 2, 4, 74, 'EQ5 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,43)', 'EQ Band 5 frequency', 1, 1, 75, 'EQ5 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,44)', 'EQ Band 5 bandwidth', 2, 4, 76, 'EQ5 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,44)', 'EQ Band 5 bandwidth', 5, 5, 77, 'EQ5 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,45)', 'EQ Band 5 level reset', 3, 0, 78, 'EQ5 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,46)', 'EQ Band 5 frequency reset', 3, 0, 79, 'EQ5 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,47)', 'EQ Band 5 bandwidth reset', 3, 0, 80, 'EQ5 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,48)', 'EQ Band 5 type', 2, 4, 81, 'EQ5 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,48)', 'EQ Band 5 type', 3, 3, 82, 'EQ5 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,49)', 'EQ Band 6 level', 2, 4, 83, 'EQ6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,49)', 'EQ Band 6 level', 5, 5, 84, 'EQ6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,50)', 'EQ Band 6 frequency', 2, 4, 85, 'EQ6 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,50)', 'EQ Band 6 frequency', 1, 1, 86, 'EQ6 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,51)', 'EQ Band 6 bandwidth', 2, 4, 87, 'EQ6 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,51)', 'EQ Band 6 bandwidth', 5, 5, 88, 'EQ6 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,52)', 'EQ Band 6 level reset', 3, 0, 89, 'EQ6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,53)', 'EQ Band 6 frequency reset', 3, 0, 90, 'EQ6 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,54)', 'EQ Band 6 bandwidth reset', 3, 0, 91, 'EQ6 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,55)', 'EQ Band 6 type', 2, 4, 92, 'EQ6 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,55)', 'EQ Band 6 type', 3, 3, 93, 'EQ6 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,56)', 'EQ on/off', 3, 3, 94, 'EQ', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,202)', 'Downward expander threshold', 2, 4, 95, 'D-exp Th', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,202)', 'Downward expander threshold', 1, 1, 96, 'D-exp Th', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,201)', 'AGC threshold', 1, 1, 97, 'AGC Th', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,201)', 'AGC threshold', 2, 4, 98, 'AGC Th', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,59)', 'AGC ratio', 1, 1, 99, 'AGC ratio', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,59)', 'AGC ratio', 2, 4, 100, 'AGC ratio', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,60)', 'Dynamics on/off', 3, 3, 101, 'Dyn', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,194)', 'Mono', 2, 4, 102, 'Mono', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,61)', 'Mono on/off', 3, 3, 103, 'Mono', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,62)', 'Pan', 1, 1, 104, 'Pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,62)', 'Pan', 2, 4, 105, 'Pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,63)', 'Pan reset', 3, 0, 106, 'Pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,64)', 'Module level', 2, 4, 107, 'Level', false, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,64)', 'Module level', 1, 1, 108, 'Level', false, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,64)', 'Module level', 5, 5, 109, 'Level', false, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,65)', 'Module on', 3, 3, 110, 'On', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,66)', 'Module off', 3, 3, 111, 'Off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,67)', 'Module on/off', 3, 3, 112, 'On', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,195)', 'Fader and on active', 3, 3, 113, 'active', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,196)', 'Fader and on inactive', 3, 3, 114, 'inactive', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,197)', 'Fader and on active/inactive', 3, 3, 115, 'active', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,198)', 'Fader on', 3, 3, 116, 'Fader on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,199)', 'Fader off', 3, 3, 117, 'Fader off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,200)', 'Fader on/off', 3, 3, 118, 'Fader on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,68)', 'Buss 1/2 level', 1, 1, 119, 'Buss1/2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,68)', 'Buss 1/2 level', 2, 4, 120, 'Buss1/2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,69)', 'Buss 1/2 level reset', 3, 0, 121, 'Buss1/2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,227)', 'Buss 1/2 on', 3, 3, 122, 'Buss1/2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,243)', 'Buss 1/2 off', 3, 3, 123, 'Buss1/2 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,70)', 'Buss 1/2 on/off', 3, 3, 124, 'Buss1/2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,71)', 'Buss 1/2 pre', 3, 3, 125, 'Buss1/2 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,72)', 'Buss 1/2 balance', 2, 4, 126, 'Buss1/2 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,72)', 'Buss 1/2 balance', 1, 1, 127, 'Buss1/2 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,73)', 'Buss 1/2 balance reset', 3, 0, 128, 'Buss1/2 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,74)', 'Buss 3/4 level', 2, 4, 129, 'Buss3/4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,74)', 'Buss 3/4 level', 1, 1, 130, 'Buss3/4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,75)', 'Buss 3/4 level reset', 3, 0, 131, 'Buss3/4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,228)', 'Buss 3/4 on', 3, 3, 132, 'Buss3/4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,244)', 'Buss 3/4 off', 3, 3, 133, 'Buss3/4 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,76)', 'Buss 3/4 on/off', 3, 3, 134, 'Buss3/4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,77)', 'Buss 3/4 pre', 3, 3, 135, 'Buss3/4 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,78)', 'Buss 3/4 balance', 1, 1, 136, 'Buss3/4 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,78)', 'Buss 3/4 balance', 2, 4, 137, 'Buss3/4 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,79)', 'Buss 3/4 balance reset', 3, 0, 138, 'Buss3/4 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,80)', 'Buss 5/6 level', 1, 1, 139, 'Buss5/6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,80)', 'Buss 5/6 level', 2, 4, 140, 'Buss5/6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,81)', 'Buss 5/6 level reset', 3, 0, 141, 'Buss5/6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,229)', 'Buss 5/6 on', 3, 3, 142, 'Buss5/6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,245)', 'Buss 5/6 off', 3, 3, 143, 'Buss5/6 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,82)', 'Buss 5/6 on/off', 3, 3, 144, 'Buss5/6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,83)', 'Buss 5/6 pre', 3, 3, 145, 'Buss5/6 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,84)', 'Buss 5/6 balance', 2, 4, 146, 'Buss5/6 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,84)', 'Buss 5/6 balance', 1, 1, 147, 'Buss5/6 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,85)', 'Buss 5/6 balance reset', 3, 0, 148, 'Buss5/6 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,86)', 'Buss 7/8 level', 2, 4, 149, 'Buss7/8 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,86)', 'Buss 7/8 level', 1, 1, 150, 'Buss7/8 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,87)', 'Buss 7/8 level reset', 3, 0, 151, 'Buss7/8 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,230)', 'Buss 7/8 on', 3, 3, 152, 'Buss7/8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,246)', 'Buss 7/8 off', 3, 3, 153, 'Buss7/8 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,88)', 'Buss 7/8 on/off', 3, 3, 154, 'Buss7/8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,89)', 'Buss 7/8 pre', 3, 3, 155, 'Buss7/8 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,90)', 'Buss 7/8 balance', 1, 1, 156, 'Buss7/8 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,90)', 'Buss 7/8 balance', 2, 4, 157, 'Buss7/8 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,91)', 'Buss 7/8 balance reset', 3, 0, 158, 'Buss7/8 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,92)', 'Buss 9/10 level', 1, 1, 159, 'Buss9/10 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,92)', 'Buss 9/10 level', 2, 4, 160, 'Buss9/10 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,93)', 'Buss 9/10 level reset', 3, 0, 161, 'Buss9/10 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,231)', 'Buss 9/10 on', 3, 3, 162, 'Buss9/10 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,247)', 'Buss 9/10 off', 3, 3, 163, 'Buss9/10 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,94)', 'Buss 9/10 on/off', 3, 3, 164, 'Buss9/10 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,95)', 'Buss 9/10 pre', 3, 3, 165, 'Buss9/10 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,96)', 'Buss 9/10 balance', 2, 4, 166, 'Buss9/10 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,96)', 'Buss 9/10 balance', 1, 1, 167, 'Buss9/10 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,97)', 'Buss 9/10 balance reset', 3, 0, 168, 'Buss9/10 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,98)', 'Buss 11/12 level', 1, 1, 169, 'Buss11/12 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,98)', 'Buss 11/12 level', 2, 4, 170, 'Buss11/12 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,99)', 'Buss 11/12 level reset', 3, 0, 171, 'Buss11/12 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,232)', 'Buss 11/12 on', 3, 3, 172, 'Buss11/12 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,248)', 'Buss 11/12 off', 3, 3, 173, 'Buss11/12 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,100)', 'Buss 11/12 on/off', 3, 3, 174, 'Buss11/12 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,101)', 'Buss 11/12 pre', 3, 3, 175, 'Buss11/12 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,102)', 'Buss 11/12 balance', 1, 1, 176, 'Buss11/12 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,102)', 'Buss 11/12 balance', 2, 4, 177, 'Buss11/12 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,103)', 'Buss 11/12 balance reset', 3, 0, 178, 'Buss11/12 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,104)', 'Buss 13/14 level', 2, 4, 179, 'Buss13/14 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,104)', 'Buss 13/14 level', 1, 1, 180, 'Buss13/14 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,105)', 'Buss 13/14 level reset', 3, 0, 181, 'Buss13/14 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,233)', 'Buss 13/14 on', 3, 3, 182, 'Buss13/14 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,249)', 'Buss 13/14 off', 3, 3, 183, 'Buss13/14 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,106)', 'Buss 13/14 on/off', 3, 3, 184, 'Buss13/14 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,107)', 'Buss 13/14 pre', 3, 3, 185, 'Buss13/14 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,108)', 'Buss 13/14 balance', 2, 4, 186, 'Buss13/14 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,108)', 'Buss 13/14 balance', 1, 1, 187, 'Buss13/14 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,109)', 'Buss 13/14 balance reset', 3, 0, 188, 'Buss13/14 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,110)', 'Buss 15/16 level', 1, 1, 189, 'Buss15/16 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,110)', 'Buss 15/16 level', 2, 4, 190, 'Buss15/16 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,111)', 'Buss 15/16 level reset', 3, 0, 191, 'Buss15/16 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,234)', 'Buss 15/16 on', 3, 3, 192, 'Buss15/16 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,250)', 'Buss 15/16 off', 3, 3, 193, 'Buss15/16 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,112)', 'Buss 15/16 on/off', 3, 3, 194, 'Buss15/16 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,113)', 'Buss 15/16 pre', 3, 3, 195, 'Buss15/16 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,114)', 'Buss 15/16 balance', 2, 4, 196, 'Buss15/16 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,114)', 'Buss 15/16 balance', 1, 1, 197, 'Buss15/16 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,115)', 'Buss 15/16 balance reset', 3, 0, 198, 'Buss15/16 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,116)', 'Buss 17/18 level', 2, 4, 199, 'Buss17/18 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,116)', 'Buss 17/18 level', 1, 1, 200, 'Buss17/18 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,117)', 'Buss 17/18 level reset', 3, 0, 201, 'Buss17/18 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,235)', 'Buss 17/18 on', 3, 3, 202, 'Buss17/18 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,251)', 'Buss 17/18 off', 3, 3, 203, 'Buss17/18 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,118)', 'Buss 17/18 on/off', 3, 3, 204, 'Buss17/18 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,119)', 'Buss 17/18 pre', 3, 3, 205, 'Buss17/18 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,120)', 'Buss 17/18 balance', 2, 4, 206, 'Buss17/18 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,120)', 'Buss 17/18 balance', 1, 1, 207, 'Buss17/18 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,121)', 'Buss 17/18 balance reset', 3, 0, 208, 'Buss17/18 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,122)', 'Buss 19/20 level', 2, 4, 209, 'Buss19/20 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,122)', 'Buss 19/20 level', 1, 1, 210, 'Buss19/20 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,123)', 'Buss 19/20 level reset', 3, 0, 211, 'Buss19/20 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,236)', 'Buss 19/20 on', 3, 3, 212, 'Buss19/20 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,252)', 'Buss 19/20 off', 3, 3, 213, 'Buss19/20 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,124)', 'Buss 19/20 on/off', 3, 3, 214, 'Buss19/20 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,125)', 'Buss 19/20 pre', 3, 3, 215, 'Buss19/20 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,126)', 'Buss 19/20 balance', 1, 1, 216, 'Buss19/20 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,126)', 'Buss 19/20 balance', 2, 4, 217, 'Buss19/20 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,127)', 'Buss 19/20 balance reset', 3, 0, 218, 'Buss19/20 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,128)', 'Buss 21/22 level', 2, 4, 219, 'Buss21/22 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,128)', 'Buss 21/22 level', 1, 1, 220, 'Buss21/22 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,129)', 'Buss 21/22 level reset', 3, 0, 221, 'Buss21/22 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,237)', 'Buss 21/22 on', 3, 3, 222, 'Buss21/22 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,253)', 'Buss 21/22 off', 3, 3, 223, 'Buss21/22 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,130)', 'Buss 21/22 on/off', 3, 3, 224, 'Buss21/22 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,131)', 'Buss 21/22 pre', 3, 3, 225, 'Buss21/22 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,132)', 'Buss 21/22 balance', 1, 1, 226, 'Buss21/22 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,132)', 'Buss 21/22 balance', 2, 4, 227, 'Buss21/22 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,133)', 'Buss 21/22 balance reset', 3, 0, 228, 'Buss21/22 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,134)', 'Buss 23/24 level', 1, 1, 229, 'Buss23/24 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,134)', 'Buss 23/24 level', 2, 4, 230, 'Buss23/24 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,135)', 'Buss 23/24 level reset', 3, 0, 231, 'Buss23/24 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,238)', 'Buss 23/24 on', 3, 3, 232, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,254)', 'Buss 23/24 off', 3, 3, 233, 'Buss23/24 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,136)', 'Buss 23/24 on/off', 3, 3, 234, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,137)', 'Buss 23/24 pre', 3, 3, 235, 'Buss23/24 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,138)', 'Buss 23/24 balance', 1, 1, 236, 'Buss23/24 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,138)', 'Buss 23/24 balance', 2, 4, 237, 'Buss23/24 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,139)', 'Buss 23/24 balance reset', 3, 0, 238, 'Buss23/24 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,140)', 'Buss 25/26 level', 1, 1, 239, 'Buss25/26 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,140)', 'Buss 25/26 level', 2, 4, 240, 'Buss25/26 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,141)', 'Buss 25/26 level reset', 3, 0, 241, 'Buss25/6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,239)', 'Buss 25/26 on', 3, 3, 242, 'Buss25/26 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,255)', 'Buss 25/26 off', 3, 3, 243, 'Buss25/26 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,142)', 'Buss 25/26 on/off', 3, 3, 244, 'Buss25/26 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,143)', 'Buss 25/26 pre', 3, 3, 245, 'Buss25/26 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,144)', 'Buss 25/26 balance', 2, 4, 246, 'Buss25/26 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,144)', 'Buss 25/26 balance', 1, 1, 247, 'Buss25/26 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,145)', 'Buss 25/26 balance reset', 3, 0, 248, 'Buss25/26 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,146)', 'Buss 27/28 level', 1, 1, 249, 'Buss27/28 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,146)', 'Buss 27/28 level', 2, 4, 250, 'Buss27/28 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,147)', 'Buss 27/28 level reset', 3, 0, 251, 'Buss27/28 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,240)', 'Buss 27/28 on', 3, 3, 252, 'Buss27/28 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,256)', 'Buss 27/28 off', 3, 3, 253, 'Buss27/28 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,148)', 'Buss 27/28 on/off', 3, 3, 254, 'Buss27/28 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,149)', 'Buss 27/28 pre', 3, 3, 255, 'Buss27/28 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,150)', 'Buss 27/28 balance', 2, 4, 256, 'Buss27/28 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,150)', 'Buss 27/28 balance', 1, 1, 257, 'Buss27/28 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,151)', 'Buss 27/28 balance reset', 3, 0, 258, 'Buss27/28 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,152)', 'Buss 29/30 level', 2, 4, 259, 'Buss29/30 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,152)', 'Buss 29/30 level', 1, 1, 260, 'Buss29/30 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,153)', 'Buss 29/30 level reset', 3, 0, 261, 'Buss29/30 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,241)', 'Buss 29/30 on', 3, 3, 262, 'Buss29/30 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,257)', 'Buss 29/30 off', 3, 3, 263, 'Buss29/30 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,154)', 'Buss 29/30 on/off', 3, 3, 264, 'Buss29/30 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,155)', 'Buss 29/30 pre', 3, 3, 265, 'Buss29/30 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,156)', 'Buss 29/30 balance', 2, 4, 266, 'Buss29/30 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,156)', 'Buss 29/30 balance', 1, 1, 267, 'Buss29/30 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,157)', 'Buss 29/30 balance reset', 3, 0, 268, 'Buss29/30 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,158)', 'Buss 31/32 level', 2, 4, 269, 'Buss31/32 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,158)', 'Buss 31/32 level', 1, 1, 270, 'Buss31/32 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,159)', 'Buss 31/32 level reset', 3, 0, 271, 'Buss31/32 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,242)', 'Buss 31/32 on', 3, 3, 272, 'Buss31/32 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,258)', 'Buss 31/32 off', 3, 3, 273, 'Buss31/32 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,160)', 'Buss 31/32 on/off', 3, 3, 274, 'Buss31/32 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,161)', 'Buss 31/32 pre', 3, 3, 275, 'Buss31/32 pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,162)', 'Buss 31/32 balance', 1, 1, 276, 'Buss31/32 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,162)', 'Buss 31/32 balance', 2, 4, 277, 'Buss31/32 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,163)', 'Buss 31/32 balance reset', 3, 0, 278, 'Buss31/32 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,164)', 'Source start', 3, 3, 279, 'Start', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,165)', 'Source stop', 3, 3, 280, 'Stop', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,166)', 'Source start/stop', 3, 3, 281, 'Start', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,167)', 'Cough on/off', 3, 3, 282, 'Cough', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,168)', 'Source alert', 3, 3, 283, 'Alert', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,204)', 'Control', 2, 4, 284, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,205)', 'Control label', 0, 4, 285, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,206)', 'Control reset', 3, 0, 286, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,169)', 'Control 1', 2, 4, 287, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,170)', 'Control 1 label', 0, 4, 288, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,171)', 'Control 1 reset', 3, 0, 289, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,172)', 'Control 2', 2, 4, 290, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,173)', 'Control 2 label', 0, 4, 291, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,174)', 'Control 2 reset', 3, 0, 292, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,175)', 'Control 3', 2, 4, 293, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,176)', 'Control 3 label', 0, 4, 294, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,177)', 'Control 3 reset', 3, 0, 295, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,178)', 'Control 4', 2, 4, 296, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,179)', 'Control 4 label', 0, 4, 297, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,180)', 'Control 4 reset', 3, 0, 298, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,181)', 'Peak', 0, 3, 299, 'Peak', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,182)', 'Signal', 0, 3, 300, 'Signal', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,203)', 'Processing preset', 2, 4, 301, 'Proc preset', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,185)', 'Routing preset 1A', 3, 0, 302, 'Routing 1A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,186)', 'Routing preset 1B', 3, 0, 303, 'Routing 1B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,187)', 'Routing preset 2A', 3, 0, 304, 'Routing 2A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,188)', 'Routing preset 2B', 3, 0, 305, 'Routing 2B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,189)', 'Routing preset 3A', 3, 0, 306, 'Routing 3A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,190)', 'Routing preset 3B', 3, 0, 307, 'Routing 3B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,191)', 'Routing preset 4A', 3, 0, 308, 'Routing 4A', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,192)', 'Routing preset 4B', 3, 0, 309, 'Routing 4B', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,211)', 'Talkback 1 to related destination', 3, 3, 310, 'TB1 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,212)', 'Talkback 2 to related destination', 3, 3, 311, 'TB2 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,213)', 'Talkback 3 to related destination', 3, 3, 312, 'TB3 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,214)', 'Talkback 4 to related destination', 3, 3, 313, 'TB4 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,215)', 'Talkback 5 to related destination', 3, 3, 314, 'TB5 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,216)', 'Talkback 6 to related destination', 3, 3, 315, 'TB6 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,217)', 'Talkback 7 to related destination', 3, 3, 316, 'TB7 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,218)', 'Talkback 8 to related destination', 3, 3, 317, 'TB8 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,219)', 'Talkback 9 to related destination', 3, 3, 318, 'TB9 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,220)', 'Talkback 10 to related destination', 3, 3, 319, 'TB10 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,221)', 'Talkback 11 to related destination', 3, 3, 320, 'TB11 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,222)', 'Talkback 12 to related destination', 3, 3, 321, 'TB12 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,223)', 'Talkback 13 to related destination', 3, 3, 322, 'TB13 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,224)', 'Talkback 14 to related destination', 3, 3, 323, 'TB14 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,225)', 'Talkback 15 to related destination', 3, 3, 324, 'TB15 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,226)', 'Talkback 16 to related destination', 3, 3, 325, 'TB16 dest', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,262)', 'Select 1', 3, 3, 326, 'Select 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,263)', 'Select 2', 3, 3, 327, 'Select 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,264)', 'Select 3', 3, 3, 328, 'Select 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,265)', 'Select 4', 3, 3, 329, 'Select 4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,269)', 'Console', 0, 1, 330, 'Console', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,266)', 'Audio level left', 0, 5, 331, 'Left', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,267)', 'Audio level right', 0, 5, 332, 'Right', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(0,,268)', 'Audio phase', 0, 5, 333, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,0)', 'Buss master level', 0, 5, 334, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,0)', 'Buss master level', 2, 4, 335, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,0)', 'Buss master level', 1, 1, 336, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,1)', 'Buss master level reset', 3, 0, 337, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,2)', 'Buss master on/off', 3, 3, 338, 'On', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,3)', 'Buss master pre', 3, 3, 339, 'Pre', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,4)', 'Label', 0, 4, 340, 'Label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,5)', 'Audio level left', 0, 5, 341, 'Left', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,6)', 'Audio level right', 0, 5, 342, 'Right', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,11)', 'Audio phase', 0, 5, 343, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,7)', 'Select 1', 3, 3, 344, 'Select 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,8)', 'Select 2', 3, 3, 345, 'Select 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,9)', 'Select 3', 3, 3, 346, 'Select 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,10)', 'Select 4', 3, 3, 347, 'Select 4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(1,,12)', 'Reset', 3, 3, 348, 'Reset', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,49)', 'Buss 1/2 on', 3, 3, 349, 'Buss1/2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,73)', 'Buss 1/2 off', 3, 3, 350, 'Buss1/2 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,0)', 'Buss 1/2 on/off', 3, 3, 351, 'Buss1/2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,50)', 'Buss 3/4 on', 3, 3, 352, 'Buss3/4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,74)', 'Buss 3/4 off', 3, 3, 353, 'Buss3/4 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,1)', 'Buss 3/4 on/off', 3, 3, 354, 'Buss3/4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,51)', 'Buss 5/6 on', 3, 3, 355, 'Buss5/6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,75)', 'Buss 5/6 off', 3, 3, 356, 'Buss5/6 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,2)', 'Buss 5/6 on/off', 3, 3, 357, 'Buss5/6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,52)', 'Buss 7/8 on', 3, 3, 358, 'Buss7/8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,76)', 'Buss 7/8 off', 3, 3, 359, 'Buss7/8 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,3)', 'Buss 7/8 on/off', 3, 3, 360, 'Buss7/8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,53)', 'Buss 9/10 on', 3, 3, 361, 'Buss9/10 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,77)', 'Buss 9/10 off', 3, 3, 362, 'Buss9/10 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,4)', 'Buss 9/10 on/off', 3, 3, 363, 'Buss9/10 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,54)', 'Buss 11/12 on', 3, 3, 364, 'Buss11/12 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,78)', 'Buss 11/12 off', 3, 3, 365, 'Buss11/12 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,5)', 'Buss 11/12 on/off', 3, 3, 366, 'Buss11/12 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,55)', 'Buss 13/14 on', 3, 3, 367, 'Buss13/14 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,79)', 'Buss 13/14 off', 3, 3, 368, 'Buss13/14 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,6)', 'Buss 13/14 on/off', 3, 3, 369, 'Buss13/14 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,56)', 'Buss 15/16 on', 3, 3, 370, 'Buss15/16 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,80)', 'Buss 15/16 off', 3, 3, 371, 'Buss15/16 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,7)', 'Buss 15/16 on/off', 3, 3, 372, 'Buss15/16 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,57)', 'Buss 17/18 on', 3, 3, 373, 'Buss17/18 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,81)', 'Buss 17/18 off', 3, 3, 374, 'Buss17/18 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,8)', 'Buss 17/18 on/off', 3, 3, 375, 'Buss17/18 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,58)', 'Buss 19/20 on', 3, 3, 376, 'Buss19/20 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,82)', 'Buss 19/20 off', 3, 3, 377, 'Buss19/20 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,9)', 'Buss 19/20 on/off', 3, 3, 378, 'Buss19/20 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,59)', 'Buss 21/22 on', 3, 3, 379, 'Buss21/22 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,83)', 'Buss 21/22 off', 3, 3, 380, 'Buss21/22 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,10)', 'Buss 21/22 on/off', 3, 3, 381, 'Buss21/22 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,60)', 'Buss 23/24 on', 3, 3, 382, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,84)', 'Buss 23/24 off', 3, 3, 383, 'Buss23/24 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,11)', 'Buss 23/24 on/off', 3, 3, 384, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,61)', 'Buss 25/26 on', 3, 3, 385, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,85)', 'Buss 25/26 off', 3, 3, 386, 'Buss23/24 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,12)', 'Buss 25/26 on/off', 3, 3, 387, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,62)', 'Buss 27/28 on', 3, 3, 388, 'Buss27/28 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,86)', 'Buss 27/28 off', 3, 3, 389, 'Buss27/28 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,13)', 'Buss 27/28 on/off', 3, 3, 390, 'Buss27/28 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,63)', 'Buss 29/30 on', 3, 3, 391, 'Buss29/30 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,87)', 'Buss 29/30 off', 3, 3, 392, 'Buss29/30 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,14)', 'Buss 29/30 on/off', 3, 3, 393, 'Buss29/30 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,64)', 'Buss 31/32 on', 3, 3, 394, 'Buss31/32 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,88)', 'Buss 31/32 off', 3, 3, 395, 'Buss31/32 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,15)', 'Buss 31/32 on/off', 3, 3, 396, 'Buss31/32 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,65)', 'Ext 1 on', 3, 3, 397, 'Ext1 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,89)', 'Ext 1 off', 3, 3, 398, 'Ext1 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,16)', 'Ext 1 on/off', 3, 3, 399, 'Ext1 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,66)', 'Ext 2 on', 3, 3, 400, 'Ext2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,90)', 'Ext 2 off', 3, 3, 401, 'Ext2 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,17)', 'Ext 2 on/off', 3, 3, 402, 'Ext2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,67)', 'Ext 3 on', 3, 3, 403, 'Ext3 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,91)', 'Ext 3 off', 3, 3, 404, 'Ext3 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,18)', 'Ext 3 on/off', 3, 3, 405, 'Ext3 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,68)', 'Ext 4 on', 3, 3, 406, 'Ext4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,92)', 'Ext 4 off', 3, 3, 407, 'Ext4 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,19)', 'Ext 4 on/off', 3, 3, 408, 'Ext4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,69)', 'Ext 5 on', 3, 3, 409, 'Ext5 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,93)', 'Ext 5 off', 3, 3, 410, 'Ext5 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,20)', 'Ext 5 on/off', 3, 3, 411, 'Ext5 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,70)', 'Ext 6 on', 3, 3, 412, 'Ext6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,94)', 'Ext 6 off', 3, 3, 413, 'Ext6 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,21)', 'Ext 6 on/off', 3, 3, 414, 'Ext6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,71)', 'Ext 7 on', 3, 3, 415, 'Ext7 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,95)', 'Ext 7 off', 3, 3, 416, 'Ext7 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,22)', 'Ext 7 on/off', 3, 3, 417, 'Ext7 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,72)', 'Ext 8 on', 3, 3, 418, 'Ext8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,96)', 'Ext 8 off', 3, 3, 419, 'Ext8 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,23)', 'Ext 8 on/off', 3, 3, 420, 'Ext8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,24)', 'Mute', 3, 3, 421, 'Mute', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,25)', 'Dim', 3, 3, 422, 'Dim', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,26)', 'Phones level', 2, 4, 423, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,26)', 'Phones level', 0, 5, 424, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,26)', 'Phones level', 1, 1, 425, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,27)', 'Mono', 3, 3, 426, 'Mono', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,28)', 'Phase', 3, 3, 427, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,29)', 'Speaker level', 0, 5, 428, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,29)', 'Speaker level', 2, 4, 429, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,29)', 'Speaker level', 1, 1, 430, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,30)', 'Talkback 1', 3, 3, 431, 'TB1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,31)', 'Talkback 2', 3, 3, 432, 'TB2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,32)', 'Talkback 3', 3, 3, 433, 'TB3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,33)', 'Talkback 4', 3, 3, 434, 'TB4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,34)', 'Talkback 5', 3, 3, 435, 'TB5', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,35)', 'Talkback 6', 3, 3, 436, 'TB6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,36)', 'Talkback 7', 3, 3, 437, 'TB7', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,37)', 'Talkback 8', 3, 3, 438, 'TB8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,38)', 'Talkback 9', 3, 3, 439, 'TB9', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,39)', 'Talkback 10', 3, 3, 440, 'TB10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,40)', 'Talkback 11', 3, 3, 441, 'TB11', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,41)', 'Talkback 12', 3, 3, 442, 'TB12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,42)', 'Talkback 13', 3, 3, 443, 'TB13', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,43)', 'Talkback 14', 3, 3, 444, 'TB14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,44)', 'Talkback 15', 3, 3, 445, 'TB15', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,45)', 'Talkback 16', 3, 3, 446, 'TB16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,46)', 'Audio level left', 0, 5, 447, 'Left', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,47)', 'Audio level right', 0, 5, 448, 'Right', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,101)', 'Audio phase', 0, 5, 449, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,48)', 'Label', 0, 4, 450, 'Label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,97)', 'Select 1', 3, 3, 451, 'Select 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,98)', 'Select 2', 3, 3, 452, 'Select 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,99)', 'Select 3', 3, 3, 453, 'Select 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(2,,100)', 'Select 4', 3, 3, 454, 'Select 4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,0)', 'Control mode active', 0, 3, 455, 'Control', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,1)', 'Control mode source', 3, 3, 456, 'SRC', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,2)', 'Control mode processing preset', 3, 3, 457, 'proc preset', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,3)', 'Control mode source gain', 3, 3, 458, 'SRC gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,4)', 'Control mode source phantom', 3, 3, 459, 'Phantom', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,5)', 'Control mode source pad', 3, 3, 460, 'Pad', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,6)', 'Control mode gain', 3, 3, 461, 'Gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,7)', 'Control mode phase', 3, 3, 462, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,8)', 'Control mode low cut', 3, 3, 463, 'LC', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,9)', 'Control mode Insert on/off', 3, 3, 464, 'Insert', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,10)', 'Control mode EQ band 1 level', 3, 3, 465, 'EQ1 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,11)', 'Control mode EQ band 1 frequency', 3, 3, 466, 'EQ1 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,12)', 'Control mode EQ band 1 bandwidth', 3, 3, 467, 'EQ1 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,13)', 'Control mode EQ band 1 type', 3, 3, 468, 'EQ1 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,14)', 'Control mode EQ band 2 level', 3, 3, 469, 'EQ2 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,15)', 'Control mode EQ band 2 frequency', 3, 3, 470, 'EQ2 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,16)', 'Control mode EQ band 2 bandwidth', 3, 3, 471, 'EQ2 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,17)', 'Control mode EQ band 2 type', 3, 3, 472, 'EQ2 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,18)', 'Control mode EQ band 3 level', 3, 3, 473, 'EQ3 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,19)', 'Control mode EQ band 3 frequency', 3, 3, 474, 'EQ3 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,20)', 'Control mode EQ band 3 bandwidth', 3, 3, 475, 'EQ3 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,21)', 'Control mode EQ band 3 type', 3, 3, 476, 'EQ3type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,22)', 'Control mode EQ band 4 level', 3, 3, 477, 'EQ4 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,23)', 'Control mode EQ band 4 frequency', 3, 3, 478, 'EQ4 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,24)', 'Control mode EQ band 4 bandwidth', 3, 3, 479, 'EQ4 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,25)', 'Control mode EQ band 4 type', 3, 3, 480, 'EQ4 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,26)', 'Control mode EQ band 5 level', 3, 3, 481, 'EQ5 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,27)', 'Control mode EQ band 5 frequency', 3, 3, 482, 'EQ5 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,28)', 'Control mode EQ band 5 bandwidth', 3, 3, 483, 'EQ5 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,29)', 'Control mode EQ band 5 type', 3, 3, 484, 'EQ5 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,30)', 'Control mode EQ band 6 level', 3, 3, 485, 'EQ6 level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,31)', 'Control mode EQ band 6 frequency', 3, 3, 486, 'EQ6 freq', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,32)', 'Control mode EQ band 6 bandwidth', 3, 3, 487, 'EQ6 Q', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,33)', 'Control mode EQ band 6 type', 3, 3, 488, 'EQ6 type', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,34)', 'Control mode EQ on/off', 3, 3, 489, 'EQ', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,35)', 'Control mode downward expander threshold', 3, 3, 490, 'D-exp Th', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,36)', 'Control mode AGC threshold', 3, 3, 491, 'AGC Th', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,37)', 'Control mode AGC ratio', 3, 3, 492, 'AGC ratio', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,38)', 'Control mode Dynamics on/off', 3, 3, 493, 'Dyn', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,39)', 'Control mode mono', 3, 3, 494, 'Mono', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,40)', 'Control mode pan', 3, 3, 495, 'Pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,41)', 'Control mode module level', 3, 3, 496, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,42)', 'Control mode buss 1/2', 3, 3, 497, 'Buss1/2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,43)', 'Control mode buss 1/2 balance', 3, 3, 498, 'Buss1/2 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,44)', 'Control mode buss 3/4', 3, 3, 499, 'Buss3/4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,45)', 'Control mode buss 3/4 balance', 3, 3, 500, 'Buss3/4 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,46)', 'Control mode buss 5/6', 3, 3, 501, 'Buss5/6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,47)', 'Control mode buss 5/6 balance', 3, 3, 502, 'Buss5/6 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,48)', 'Control mode buss 7/8', 3, 3, 503, 'Buss7/8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,49)', 'Control mode buss 7/8 balance', 3, 3, 504, 'Buss7/8 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,50)', 'Control mode buss 9/10', 3, 3, 505, 'Buss9/10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,51)', 'Control mode buss 9/10 balance', 3, 3, 506, 'Buss9/10 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,52)', 'Control mode buss 11/12', 3, 3, 507, 'Buss11/12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,53)', 'Control mode buss 11/12 balance', 3, 3, 508, 'Buss11/12 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,54)', 'Control mode buss 13/14', 3, 3, 509, 'Buss13/14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,55)', 'Control mode buss 13/14 balance', 3, 3, 510, 'Buss13/14 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,56)', 'Control mode buss 15/16', 3, 3, 511, 'Buss15/16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,57)', 'Control mode buss 15/16 balance', 3, 3, 512, 'Buss15/16 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,58)', 'Control mode buss 17/18', 3, 3, 513, 'Buss17/18', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,59)', 'Control mode buss 17/18 balance', 3, 3, 514, 'Buss17/18 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,60)', 'Control mode buss 19/20', 3, 3, 515, 'Buss19/20', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,61)', 'Control mode buss 19/20 balance', 3, 3, 516, 'Buss19/20 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,62)', 'Control mode buss 21/22', 3, 3, 517, 'Buss21/22', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,63)', 'Control mode buss 21/22 balance', 3, 3, 518, 'Buss21/22 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,64)', 'Control mode buss 23/24', 3, 3, 519, 'Buss23/24', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,65)', 'Control mode buss 23/24 balance', 3, 3, 520, 'Buss23/24 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,66)', 'Control mode buss 25/26', 3, 3, 521, 'Buss25/26', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,67)', 'Control mode buss 25/26 balance', 3, 3, 522, 'Buss25/26 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,68)', 'Control mode buss 27/28', 3, 3, 523, 'Buss27/28', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,69)', 'Control mode buss 27/28 balance', 3, 3, 524, 'Buss27/28 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,70)', 'Control mode buss 29/30', 3, 3, 525, 'Buss29/30', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,71)', 'Control mode buss 29/30 balance', 3, 3, 526, 'Buss29/30 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,72)', 'Control mode buss 31/32', 3, 3, 527, 'Buss31/32', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,73)', 'Control mode buss 31/32 balance', 3, 3, 528, 'Buss31/32 pan', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,74)', 'Master control mode buss 1/2', 3, 3, 529, 'Buss1/2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,75)', 'Master control mode buss 3/4', 3, 3, 530, 'Buss3/4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,76)', 'Master control mode buss 5/6', 3, 3, 531, 'Buss5/6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,77)', 'Master control mode buss 7/8', 3, 3, 532, 'Buss7/8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,78)', 'Master control mode buss 9/10', 3, 3, 533, 'Buss9/10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,79)', 'Master control mode buss 11/12', 3, 3, 534, 'Buss11/12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,80)', 'Master control mode buss 13/14', 3, 3, 535, 'Buss13/14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,81)', 'Master control mode buss 15/16', 3, 3, 536, 'Buss15/16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,82)', 'Master control mode buss 17/18', 3, 3, 537, 'Buss17/18', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,83)', 'Master control mode buss 19/20', 3, 3, 538, 'Buss19/20', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,84)', 'Master control mode buss 21/22', 3, 3, 539, 'Buss21/22', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,85)', 'Master control mode buss 23/24', 3, 3, 540, 'Buss23/24', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,86)', 'Master control mode buss 25/26', 3, 3, 541, 'Buss25/26', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,87)', 'Master control mode buss 27/28', 3, 3, 542, 'Buss27/28', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,88)', 'Master control mode buss 29/30', 3, 3, 543, 'Buss29/30', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,89)', 'Master control mode buss 31/32', 3, 3, 544, 'Buss31/32', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,90)', 'Master control', 2, 6, 545, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,90)', 'Master control', 1, 1, 546, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,91)', 'Master control reset', 3, 0, 547, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,92)', 'Reset console to programmed defaults', 3, 3, 548, 'Panic', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,93)', 'Master & control mode buss 1/2', 3, 3, 549, 'Buss1/2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,94)', 'Master & control mode buss 3/4', 3, 3, 550, 'Buss3/4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,95)', 'Master & control mode buss 5/6', 3, 3, 551, 'Buss5/6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,96)', 'Master & control mode buss 7/8', 3, 3, 552, 'Buss7/8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,97)', 'Master & control mode buss 9/10', 3, 3, 553, 'Buss9/10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,98)', 'Master & control mode buss 11/12', 3, 3, 554, 'Buss11/12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,99)', 'Master & control mode buss 13/14', 3, 3, 555, 'Buss13/14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,100)', 'Master & control mode buss 15/16', 3, 3, 556, 'Buss15/16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,101)', 'Master & control mode buss 17/18', 3, 3, 557, 'Buss17/18', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,102)', 'Master & control mode buss 19/20', 3, 3, 558, 'Buss19/20', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,103)', 'Master & control mode buss 21/22', 3, 3, 559, 'Buss21/22', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,104)', 'Master & control mode buss 23/24', 3, 3, 560, 'Buss23/24', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,105)', 'Master & control mode buss 25/26', 3, 3, 561, 'Buss25/26', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,106)', 'Master & control mode buss 27/28', 3, 3, 562, 'Buss27/28', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,107)', 'Master & control mode buss 29/30', 3, 3, 563, 'Buss29/30', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,108)', 'Master & control mode buss 31/32', 3, 3, 564, 'Buss31/32', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,109)', 'Console preset label', 0, 4, 565, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,110)', 'Module select', 2, 4, 566, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,110)', 'Module select', 1, 1, 567, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,130)', 'Selected module active', 0, 3, 568, 'No label', false, false, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,111)', 'Buss select', 2, 4, 569, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,111)', 'Buss select', 1, 1, 570, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,131)', 'Selected buss active', 0, 3, 571, 'No label', false, false, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,112)', 'Monitor buss select', 2, 4, 572, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,112)', 'Monitor buss select', 1, 1, 573, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,132)', 'Selected monitor buss active', 0, 3, 574, 'No label', false, false, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,113)', 'Source select', 1, 1, 575, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,113)', 'Source select', 2, 4, 576, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,133)', 'Selected source active', 0, 3, 577, 'No label', false, false, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,114)', 'Destination select', 1, 1, 578, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,114)', 'Destination select', 2, 4, 579, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,134)', 'Selected destination active', 0, 3, 580, 'No label', false, false, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,115)', 'Console chipcard change', 3, 0, 581, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,116)', 'Console chipcard username', 4, 4, 582, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,117)', 'Console chipcard password', 4, 4, 583, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,118)', 'Console write chipcard user/pass', 4, 4, 584, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,119)', 'Console username/password', 4, 4, 585, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,120)', 'Console username', 4, 4, 586, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,121)', 'Console password', 4, 4, 587, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,122)', 'Console user level', 0, 4, 588, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,122)', 'Console user level', 3, 3, 589, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,123)', 'Second dot count up/down', 3, 3, 590, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,123)', 'Second dot count up/down', 1, 0, 591, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,124)', 'Program end time enable', 3, 3, 592, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,124)', 'Program end time enable', 1, 0, 593, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,125)', 'Program end time', 4, 4, 594, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,129)', 'Program end time hours', 1, 1, 595, 'No label', false, false, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,126)', 'Program end time minutes', 1, 1, 596, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,127)', 'Program end time seconds', 1, 1, 597, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(3,,128)', 'Count down timer', 5, 5, 598, 'No label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,0)', 'Redlight 1', 3, 3, 599, 'OnAir 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,1)', 'Redlight 2', 3, 3, 600, 'OnAir 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,2)', 'Redlight 3', 3, 3, 601, 'OnAir 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,3)', 'Redlight 4', 3, 3, 602, 'OnAir 4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,4)', 'Redlight 5', 3, 3, 603, 'OnAir 5', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,5)', 'Redlight 6', 3, 3, 604, 'OnAir 6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,6)', 'Redlight 7', 3, 3, 605, 'OnAir 7', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,7)', 'Redlight 8', 3, 3, 606, 'OnAir 8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,8)', 'Console preset 1', 3, 3, 607, 'Preset 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,9)', 'Console preset 2', 3, 3, 608, 'Preset 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,10)', 'Console preset 3', 3, 3, 609, 'Preset 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,11)', 'Console preset 4', 3, 3, 610, 'Preset 4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,12)', 'Console preset 5', 3, 3, 611, 'Preset 5', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,13)', 'Console preset 6', 3, 3, 612, 'Preset 6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,14)', 'Console preset 7', 3, 3, 613, 'Preset 7', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,15)', 'Console preset 8', 3, 3, 614, 'Preset 8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,16)', 'Console preset 9', 3, 3, 615, 'Preset 9', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,17)', 'Console preset 10', 3, 3, 616, 'Preset 10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,18)', 'Console preset 11', 3, 3, 617, 'Preset 11', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,19)', 'Console preset 12', 3, 3, 618, 'Preset 12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,20)', 'Console preset 13', 3, 3, 619, 'Preset 13', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,21)', 'Console preset 14', 3, 3, 620, 'Preset 14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,22)', 'Console preset 15', 3, 3, 621, 'Preset 15', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,23)', 'Console preset 16', 3, 3, 622, 'Preset 16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,24)', 'Console preset 17', 3, 3, 623, 'Preset 17', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,25)', 'Console preset 18', 3, 3, 624, 'Preset 18', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,26)', 'Console preset 19', 3, 3, 625, 'Preset 19', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,27)', 'Console preset 20', 3, 3, 626, 'Preset 20', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,28)', 'Console preset 21', 3, 3, 627, 'Preset 21', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,29)', 'Console preset 22', 3, 3, 628, 'Preset 22', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,30)', 'Console preset 23', 3, 3, 629, 'Preset 23', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,31)', 'Console preset 24', 3, 3, 630, 'Preset 24', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,32)', 'Console preset 25', 3, 3, 631, 'Preset 25', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,33)', 'Console preset 26', 3, 3, 632, 'Preset 26', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,34)', 'Console preset 27', 3, 3, 633, 'Preset 27', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,35)', 'Console preset 28', 3, 3, 634, 'Preset 28', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,36)', 'Console preset 29', 3, 3, 635, 'Preset 29', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,37)', 'Console preset 30', 3, 3, 636, 'Preset 30', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,38)', 'Console preset 31', 3, 3, 637, 'Preset 31', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(4,,39)', 'Console preset 32', 3, 3, 638, 'Preset 32', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,69)', 'Label', 0, 4, 639, 'Label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,0)', 'Module on', 3, 3, 640, 'Module on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,1)', 'Module off', 3, 3, 641, 'Module off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,2)', 'Module on/off', 3, 3, 642, 'Module on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,3)', 'Module fader on', 3, 3, 643, 'Fader on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,4)', 'Module fader off', 3, 3, 644, 'Fader off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,5)', 'Module fader on/off', 3, 3, 645, 'Fader on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,6)', 'Module fader and on active', 3, 3, 646, 'Module active', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,7)', 'Module fader and on inactive', 3, 3, 647, 'Module inactive', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,64)', 'Module fader and on active/inactive', 3, 3, 648, 'Module active', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,8)', 'Module buss 1/2 on', 3, 3, 649, 'Buss1/2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,9)', 'Module buss 1/2 off', 3, 3, 650, 'Buss1/2 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,10)', 'Module buss 1/2 on/off', 3, 3, 651, 'Buss1/2 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,11)', 'Module buss 3/4 on', 3, 3, 652, 'Buss3/4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,12)', 'Module buss 3/4 off', 3, 3, 653, 'Buss3/4 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,13)', 'Module buss 3/4 on/off', 3, 3, 654, 'Buss3/4 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,14)', 'Module buss 5/6 on', 3, 3, 655, 'Buss5/6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,15)', 'Module buss 5/6 off', 3, 3, 656, 'Buss5/6 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,16)', 'Module buss 5/6 on/off', 3, 3, 657, 'Buss5/6 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,17)', 'Module buss 7/8 on', 3, 3, 658, 'Buss7/8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,18)', 'Module buss 7/8 off', 3, 3, 659, 'Buss7/8 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,19)', 'Module buss 7/8 on/off', 3, 3, 660, 'Buss7/8 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,20)', 'Module buss 9/10 on', 3, 3, 661, 'Buss9/10 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,21)', 'Module buss 9/10 off', 3, 3, 662, 'Buss9/10 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,22)', 'Module buss 9/10 on/off', 3, 3, 663, 'Buss9/10 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,23)', 'Module buss 11/12 on', 3, 3, 664, 'Buss11/12 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,24)', 'Module buss 11/12 off', 3, 3, 665, 'Buss11/12 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,25)', 'Module buss 11/12 on/off', 3, 3, 666, 'Buss11/12 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,26)', 'Module buss 13/14 on', 3, 3, 667, 'Buss13/14 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,27)', 'Module buss 13/14 off', 3, 3, 668, 'Buss13/14 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,28)', 'Module buss 13/14 on/off', 3, 3, 669, 'Buss13/14 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,29)', 'Module buss 15/16 on', 3, 3, 670, 'Buss15/16 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,30)', 'Module buss 15/16 off', 3, 3, 671, 'Buss15/16 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,31)', 'Module buss 15/16 on/off', 3, 3, 672, 'Buss15/16 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,32)', 'Module buss 17/18 on', 3, 3, 673, 'Buss17/18 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,33)', 'Module buss 17/18 off', 3, 3, 674, 'Buss17/18 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,34)', 'Module buss 17/18 on/off', 3, 3, 675, 'Buss17/18 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,35)', 'Module buss 19/20 on', 3, 3, 676, 'Buss19/20 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,36)', 'Module buss 19/20 off', 3, 3, 677, 'Buss19/20 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,37)', 'Module buss 19/20 on/off', 3, 3, 678, 'Buss19/20 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,38)', 'Module buss 21/22 on', 3, 3, 679, 'Buss21/22 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,39)', 'Module buss 21/22 off', 3, 3, 680, 'Buss21/22 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,40)', 'Module buss 21/22 on/off', 3, 3, 681, 'Buss21/22 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,41)', 'Module buss 23/24 on', 3, 3, 682, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,42)', 'Module buss 23/24 off', 3, 3, 683, 'Buss23/24 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,43)', 'Module buss 23/24 on/off', 3, 3, 684, 'Buss23/24 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,44)', 'Module buss 25/26 on', 3, 3, 685, 'Buss25/26 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,45)', 'Module buss 25/26 off', 3, 3, 686, 'Buss25/26 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,46)', 'Module buss 25/26 on/off', 3, 3, 687, 'Buss25/26 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,47)', 'Module buss 27/28 on', 3, 3, 688, 'Buss27/28 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,48)', 'Module buss 27/28 off', 3, 3, 689, 'Buss27/28 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,49)', 'Module buss 27/28 on/off', 3, 3, 690, 'Buss27/28 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,50)', 'Module buss 29/30 on', 3, 3, 691, 'Buss29/30 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,51)', 'Module buss 29/30 off', 3, 3, 692, 'Buss29/30 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,52)', 'Module buss 29/30 on/off', 3, 3, 693, 'Buss29/30 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,53)', 'Module buss 31/32 on', 3, 3, 694, 'Buss31/32 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,54)', 'Module buss 31/32 off', 3, 3, 695, 'Buss31/32 off', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,55)', 'Module buss 31/32 on/off', 3, 3, 696, 'Buss31/32 on', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,56)', 'Module cough on/off', 3, 3, 697, 'Cough', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,70)', 'Cough & Comm technician', 3, 3, 698, 'Cough & Tech', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,71)', 'Cough & Comm producer', 3, 3, 699, 'Cough & Prod', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,57)', 'Start', 3, 3, 700, 'Start', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,58)', 'Stop', 3, 3, 701, 'Stop', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,59)', 'Start/stop', 3, 3, 702, 'Start', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,60)', 'Phantom', 3, 3, 703, 'Phantom', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,61)', 'Pad', 3, 3, 704, 'Pad', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,62)', 'Input gain', 2, 5, 705, 'SRC gain', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,63)', 'Alert', 3, 3, 706, 'Alert', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,65)', 'Select 1', 3, 3, 707, 'Select 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,66)', 'Select 2', 3, 3, 708, 'Select 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,67)', 'Select 3', 3, 3, 709, 'Select 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(5,,68)', 'Select 4', 3, 3, 710, 'Select 4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,0)', 'Label', 0, 4, 711, 'Label', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,1)', 'Source', 2, 4, 712, 'SRC', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,2)', 'Monitor speaker level', 0, 4, 713, 'Spk level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,2)', 'Monitor speaker level', 0, 1, 714, 'Spk level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,2)', 'Monitor speaker level', 0, 5, 715, 'Spk level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,3)', 'Monitor phones level', 0, 5, 716, 'Phones level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,3)', 'Monitor phones level', 0, 4, 717, 'Phones level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,3)', 'Monitor phones level', 0, 1, 718, 'Phones level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,4)', 'Level', 2, 4, 719, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,4)', 'Level', 1, 1, 720, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,4)', 'Level', 0, 5, 721, 'Level', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,5)', 'Mute', 3, 3, 722, 'Mute', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,6)', 'Mute & Monitor mute', 0, 3, 723, 'Mute', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,7)', 'Dim', 3, 3, 724, 'Dim', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,8)', 'Dim & Monitor dim', 0, 3, 725, 'Dim', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,9)', 'Mono', 3, 3, 726, 'Mono', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,10)', 'Mono & Monitor mono', 0, 3, 727, 'Mono', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,11)', 'Phase', 3, 3, 728, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,12)', 'Phase & Monitor phase', 0, 3, 729, 'Phase', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,13)', 'Talkback 1', 3, 3, 730, 'TB1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,14)', 'Talkback 1 & Monitor talkback 1', 0, 3, 731, 'TB1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,15)', 'Talkback 2', 3, 3, 732, 'TB2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,16)', 'Talkback 2 & Monitor talkback 2', 0, 3, 733, 'TB2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,17)', 'Talkback 3', 3, 3, 734, 'TB3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,18)', 'Talkback 3 & Monitor talkback 3', 0, 3, 735, 'TB3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,19)', 'Talkback 4', 3, 3, 736, 'TB4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,20)', 'Talkback 4 & Monitor talkback 4', 0, 3, 737, 'TB4', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,21)', 'Talkback 5', 3, 3, 738, 'TB5', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,22)', 'Talkback 5 & Monitor talkback 5', 0, 3, 739, 'TB5', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,23)', 'Talkback 6', 3, 3, 740, 'TB6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,24)', 'Talkback 6 & Monitor talkback 6', 0, 3, 741, 'TB6', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,25)', 'Talkback 7', 3, 3, 742, 'TB7', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,26)', 'Talkback 7 & Monitor talkback 7', 0, 3, 743, 'TB7', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,27)', 'Talkback 8', 3, 3, 744, 'TB8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,28)', 'Talkback 8 & Monitor talkback 8', 0, 3, 745, 'TB8', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,29)', 'Talkback 9', 3, 3, 746, 'TB9', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,30)', 'Talkback 9 & Monitor talkback 9', 0, 3, 747, 'TB9', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,31)', 'Talkback 10', 3, 3, 748, 'TB10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,32)', 'Talkback 10 & Monitor talkback 10', 0, 3, 749, 'TB10', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,33)', 'Talkback 11', 3, 3, 750, 'TB11', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,34)', 'Talkback 11 & Monitor talkback 11', 0, 3, 751, 'TB11', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,35)', 'Talkback 12', 3, 3, 752, 'TB12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,36)', 'Talkback 12 & Monitor talkback 12', 0, 3, 753, 'TB12', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,37)', 'Talkback 13', 3, 3, 754, 'TB13', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,38)', 'Talkback 13 & Monitor talkback 13', 0, 3, 755, 'TB13', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,39)', 'Talkback 14', 3, 3, 756, 'TB14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,40)', 'Talkback 14 & Monitor talkback 14', 0, 3, 757, 'TB14', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,41)', 'Talkback 15', 3, 3, 758, 'TB15', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,42)', 'Talkback 15 & Monitor talkback 15', 0, 3, 759, 'TB15', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,43)', 'Talkback 16', 3, 3, 760, 'TB16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,44)', 'Talkback 16 & Monitor talkback 16', 0, 3, 761, 'TB16', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,45)', 'Routing', 2, 4, 762, 'Routing', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,46)', 'Select 1', 3, 3, 763, 'Select 1', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,47)', 'Select 2', 3, 3, 764, 'Select 2', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,48)', 'Select 3', 3, 3, 765, 'Select 3', true, true, true, true, true, true);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos, label, user_level0, user_level1, user_level2, user_level3, user_level4, user_level5) VALUES ('(6,,49)', 'Select 4', 3, 3, 766, 'Select 4', true, true, true, true, true, true);

COMMIT;
