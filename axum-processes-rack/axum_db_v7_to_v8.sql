BEGIN;

ALTER TABLE module_config
  ADD COLUMN console smallint NOT NULL DEFAULT 1 CHECK(console>=1 AND console<=4),
  ADD COLUMN source_e smallint NOT NULL DEFAULT 0,
  ADD COLUMN source_f smallint NOT NULL DEFAULT 0,
  ADD COLUMN source_g smallint NOT NULL DEFAULT 0,
  ADD COLUMN source_h smallint NOT NULL DEFAULT 0,
  ADD COLUMN source_a_preset smallint,
  ADD COLUMN source_b_preset smallint,
  ADD COLUMN source_c_preset smallint,
  ADD COLUMN source_d_preset smallint,
  ADD COLUMN source_e_preset smallint,
  ADD COLUMN source_f_preset smallint,
  ADD COLUMN source_g_preset smallint,
  ADD COLUMN source_h_preset smallint,
  ADD COLUMN overrule_active boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_1_2_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_3_4_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_5_6_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_7_8_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_9_10_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_11_12_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_13_14_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_15_16_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_17_18_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_19_20_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_21_22_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_23_24_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_25_26_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_27_28_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_29_30_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN buss_31_32_use_preset boolean[8] NOT NULL DEFAULT ARRAY[TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  ADD COLUMN d_exp_threshold float NOT NULL DEFAULT -30 CHECK(d_exp_threshold>=-50 AND d_exp_threshold<=0),
  ADD COLUMN agc_threshold float NOT NULL DEFAULT -20 CHECK(agc_threshold>=-30 AND agc_threshold<=0),
  ADD COLUMN mod_pan smallint NOT NULL DEFAULT 512 CHECK(mod_pan>=0 AND mod_pan<=1023);

ALTER TABLE module_config
  RENAME COLUMN dyn_amount TO agc_amount;

UPDATE module_config SET gain=-20 WHERE gain<-20;
UPDATE module_config SET gain=20 WHERE gain>20;
UPDATE module_config SET agc_amount=0 WHERE agc_amount<0;
UPDATE module_config SET agc_amount=100 WHERE agc_amount>100;
UPDATE module_config SET mod_level=-140 WHERE mod_level<-140;
UPDATE module_config SET mod_level=10 WHERE mod_level>10;

ALTER TABLE module_config
  ADD CHECK(gain>=-20 AND gain<=20),
  ADD CHECK(agc_amount>=0 AND agc_amount<=100),
  ADD CHECK(mod_level>=-140 AND mod_level<=10);

ALTER TABLE src_config
  ADD COLUMN default_src_preset smallint DEFAULT NULL CHECK(default_src_preset>=1 AND default_src_preset<=1280);

CREATE TABLE src_preset (
  pos smallint NOT NULL DEFAULT 9999,
  number smallint NOT NULL CHECK (number>=1 AND number<=1280) PRIMARY KEY,
  label varchar(32) NOT NULL DEFAULT 'preset',
  use_gain_preset boolean NOT NULL DEFAULT FALSE,
  gain float NOT NULL DEFAULT 0 CHECK(gain>=-20 AND gain<=20),
  use_lc_preset boolean NOT NULL DEFAULT FALSE,
  lc_on_off boolean NOT NULL DEFAULT FALSE,
  lc_frequency smallint NOT NULL DEFAULT 80 CHECK(lc_frequency>=40 AND lc_frequency<=12000),
  use_insert_preset boolean NOT NULL DEFAULT FALSE,
  insert_on_off boolean NOT NULL DEFAULT FALSE,
  use_phase_preset boolean NOT NULL DEFAULT FALSE,
  phase_on_off boolean NOT NULL DEFAULT FALSE,
  phase smallint NOT NULL DEFAULT 3 CHECK(phase>=0 AND phase<=3),
  use_mono_preset boolean NOT NULL DEFAULT FALSE,
  mono_on_off boolean NOT NULL DEFAULT FALSE,
  mono smallint NOT NULL DEFAULT 3 CHECK(mono>=0 AND mono<=3),
  use_eq_preset boolean NOT NULL DEFAULT FALSE,
  eq_on_off boolean NOT NULL DEFAULT FALSE,
  eq_band_1_range smallint NOT NULL DEFAULT 18 CHECK(eq_band_1_range>=0 AND eq_band_1_range<=18),
  eq_band_1_level smallint NOT NULL DEFAULT 0 CHECK(eq_band_1_level>=-eq_band_1_range AND eq_band_1_level<=eq_band_1_range),
  eq_band_1_freq smallint NOT NULL DEFAULT 7000 CHECK(eq_band_1_freq>=10 AND eq_band_1_freq<=20000),
  eq_band_1_bw float NOT NULL DEFAULT 1 CHECK(eq_band_1_bw>=0.1 AND eq_band_1_bw<=10),
  eq_band_1_slope float NOT NULL DEFAULT 1 CHECK(eq_band_1_slope>=0.1 AND eq_band_1_slope<=10),
  eq_band_1_type smallint NOT NULL DEFAULT 4 CHECK(eq_band_1_type>=0 AND eq_band_1_type<=7),
  eq_band_2_range smallint NOT NULL DEFAULT 18 CHECK(eq_band_2_range>=0 AND eq_band_2_range<=18),
  eq_band_2_level smallint NOT NULL DEFAULT 0 CHECK(eq_band_2_level>=-eq_band_2_range AND eq_band_2_level<=eq_band_2_range),
  eq_band_2_freq smallint NOT NULL DEFAULT 2000 CHECK(eq_band_2_freq>=10 AND eq_band_2_freq<=20000),
  eq_band_2_bw float NOT NULL DEFAULT 3 CHECK(eq_band_2_bw>=0.1 AND eq_band_2_bw<=10),
  eq_band_2_slope float NOT NULL DEFAULT 1 CHECK(eq_band_2_slope>=0.1 AND eq_band_2_slope<=10),
  eq_band_2_type smallint NOT NULL DEFAULT 3 CHECK(eq_band_2_type>=0 AND eq_band_2_type<=7),
  eq_band_3_range smallint NOT NULL DEFAULT 18 CHECK(eq_band_3_range>=0 AND eq_band_3_range<=18),
  eq_band_3_level smallint NOT NULL DEFAULT 0 CHECK(eq_band_3_level>=-eq_band_3_range AND eq_band_3_level<=eq_band_3_range),
  eq_band_3_freq smallint NOT NULL DEFAULT 300 CHECK(eq_band_3_freq>=10 AND eq_band_3_freq<=20000),
  eq_band_3_bw float NOT NULL DEFAULT 1 CHECK(eq_band_3_bw>=0.1 AND eq_band_3_bw<=10),
  eq_band_3_slope float NOT NULL DEFAULT 1 CHECK(eq_band_3_slope>=0.1 AND eq_band_3_slope<=10),
  eq_band_3_type smallint NOT NULL DEFAULT 2 CHECK(eq_band_3_type>=0 AND eq_band_3_type<=7),
  eq_band_4_range smallint NOT NULL DEFAULT 18 CHECK(eq_band_4_range>=0 AND eq_band_4_range<=18),
  eq_band_4_level smallint NOT NULL DEFAULT 0 CHECK(eq_band_4_level>=-eq_band_4_range AND eq_band_4_level<=eq_band_4_range),
  eq_band_4_freq smallint NOT NULL DEFAULT 120 CHECK(eq_band_4_freq>=10 AND eq_band_4_freq<=20000),
  eq_band_4_bw float NOT NULL DEFAULT 1 CHECK(eq_band_4_bw>=0.1 AND eq_band_4_bw<=10),
  eq_band_4_slope float NOT NULL DEFAULT 1 CHECK(eq_band_4_slope>=0.1 AND eq_band_4_slope<=10),
  eq_band_4_type smallint NOT NULL DEFAULT 0 CHECK(eq_band_4_type>=0 AND eq_band_4_type<=7),
  eq_band_5_range smallint NOT NULL DEFAULT 18 CHECK(eq_band_5_range>=0 AND eq_band_5_range<=18),
  eq_band_5_level smallint NOT NULL DEFAULT 0 CHECK(eq_band_5_level>=-eq_band_5_range AND eq_band_5_level<=eq_band_5_range),
  eq_band_5_freq smallint NOT NULL DEFAULT 12000 CHECK(eq_band_5_freq>=10 AND eq_band_5_freq<=20000),
  eq_band_5_bw float NOT NULL DEFAULT 1 CHECK(eq_band_5_bw>=0.1 AND eq_band_5_bw<=10),
  eq_band_5_slope float NOT NULL DEFAULT 1 CHECK(eq_band_5_slope>=0.1 AND eq_band_5_slope<=10),
  eq_band_5_type smallint NOT NULL DEFAULT 0 CHECK(eq_band_5_type>=0 AND eq_band_5_type<=7),
  eq_band_6_range smallint NOT NULL DEFAULT 18 CHECK(eq_band_6_range>=0 AND eq_band_6_range<=18),
  eq_band_6_level smallint NOT NULL DEFAULT 0 CHECK(eq_band_6_level>=-eq_band_6_range AND eq_band_6_level<=eq_band_6_range),
  eq_band_6_freq smallint NOT NULL DEFAULT 120 CHECK(eq_band_6_freq>=10 AND eq_band_6_freq<=20000),
  eq_band_6_bw float NOT NULL DEFAULT 1 CHECK(eq_band_6_bw>=0.1 AND eq_band_6_bw<=10),
  eq_band_6_slope float NOT NULL DEFAULT 1 CHECK(eq_band_6_slope>=0.1 AND eq_band_6_slope<=10),
  eq_band_6_type smallint NOT NULL DEFAULT 0 CHECK(eq_band_6_type>=0 AND eq_band_6_type<=7),
  use_dyn_preset boolean NOT NULL DEFAULT FALSE,
  dyn_on_off boolean NOT NULL DEFAULT FALSE,
  d_exp_threshold float NOT NULL DEFAULT -30 CHECK(d_exp_threshold>=-50 AND d_exp_threshold<=0),
  agc_amount smallint NOT NULL DEFAULT 0 CHECK(agc_amount>=0 AND agc_amount<=100),
  agc_threshold float NOT NULL DEFAULT -20 CHECK(agc_threshold>=-30 AND agc_threshold<0),
  use_mod_preset boolean NOT NULL DEFAULT FALSE,
  mod_pan smallint NOT NULL DEFAULT 512 CHECK(mod_pan>=0 AND mod_pan<=1023),
  mod_on_off boolean NOT NULL DEFAULT FALSE,
  mod_lvl float NOT NULL DEFAULT -140 CHECK(mod_lvl>=-140 AND mod_lvl<=10),
  routing_preset smallint NOT NULL DEFAULT 1 CHECK(routing_preset>=1 AND routing_preset<=8)
);

UPDATE src_config SET gain=-20 WHERE gain<-20;
UPDATE src_config SET gain=20 WHERE gain>20;
UPDATE src_config SET dyn_amount=0 WHERE dyn_amount<0;
UPDATE src_config SET dyn_amount=100 WHERE dyn_amount>100;
UPDATE src_config SET mod_lvl=-140 WHERE mod_lvl<-140;
UPDATE src_config SET mod_lvl=10 WHERE mod_lvl>10;

INSERT INTO src_preset (  number,
                          label,
                          use_gain_preset,
                          gain,
                          use_lc_preset,
                          lc_on_off,
                          lc_frequency,
                          use_insert_preset,
                          insert_on_off,
                          use_phase_preset,
                          phase_on_off,
                          phase,
                          use_mono_preset,
                          mono_on_off,
                          mono,
                          use_eq_preset,
                          eq_on_off,
                          eq_band_1_range,
                          eq_band_1_level,
                          eq_band_1_freq,
                          eq_band_1_bw,
                          eq_band_1_slope,
                          eq_band_1_type,
                          eq_band_2_range,
                          eq_band_2_level,
                          eq_band_2_freq,
                          eq_band_2_bw,
                          eq_band_2_slope,
                          eq_band_2_type,
                          eq_band_3_range,
                          eq_band_3_level,
                          eq_band_3_freq,
                          eq_band_3_bw,
                          eq_band_3_slope,
                          eq_band_3_type,
                          eq_band_4_range,
                          eq_band_4_level,
                          eq_band_4_freq,
                          eq_band_4_bw,
                          eq_band_4_slope,
                          eq_band_4_type,
                          eq_band_5_range,
                          eq_band_5_level,
                          eq_band_5_freq,
                          eq_band_5_bw,
                          eq_band_5_slope,
                          eq_band_5_type,
                          eq_band_6_range,
                          eq_band_6_level,
                          eq_band_6_freq,
                          eq_band_6_bw,
                          eq_band_6_slope,
                          eq_band_6_type,
                          use_dyn_preset,
                          dyn_on_off,
                          agc_amount,
                          use_mod_preset,
                          mod_on_off,
                          mod_lvl,
                          routing_preset) (SELECT number,
                                                  label,
                                                  use_gain_preset,
                                                  gain,
                                                  use_lc_preset,
                                                  lc_on_off,
                                                  lc_frequency,
                                                  use_insert_preset,
                                                  insert_on_off,
                                                  use_phase_preset,
                                                  phase_on_off,
                                                  phase,
                                                  use_mono_preset,
                                                  mono_on_off,
                                                  mono,
                                                  use_eq_preset,
                                                  eq_on_off,
                                                  eq_band_1_range,
                                                  eq_band_1_level,
                                                  eq_band_1_freq,
                                                  eq_band_1_bw,
                                                  eq_band_1_slope,
                                                  eq_band_1_type,
                                                  eq_band_2_range,
                                                  eq_band_2_level,
                                                  eq_band_2_freq,
                                                  eq_band_2_bw,
                                                  eq_band_2_slope,
                                                  eq_band_2_type,
                                                  eq_band_3_range,
                                                  eq_band_3_level,
                                                  eq_band_3_freq,
                                                  eq_band_3_bw,
                                                  eq_band_3_slope,
                                                  eq_band_3_type,
                                                  eq_band_4_range,
                                                  eq_band_4_level,
                                                  eq_band_4_freq,
                                                  eq_band_4_bw,
                                                  eq_band_4_slope,
                                                  eq_band_4_type,
                                                  eq_band_5_range,
                                                  eq_band_5_level,
                                                  eq_band_5_freq,
                                                  eq_band_5_bw,
                                                  eq_band_5_slope,
                                                  eq_band_5_type,
                                                  eq_band_6_range,
                                                  eq_band_6_level,
                                                  eq_band_6_freq,
                                                  eq_band_6_bw,
                                                  eq_band_6_slope,
                                                  eq_band_6_type,
                                                  use_dyn_preset,
                                                  dyn_on_off,
                                                  dyn_amount,
                                                  use_mod_preset,
                                                  mod_on_off,
                                                  mod_lvl,
                                                  routing_preset FROM src_config);

ALTER TABLE src_config
  DROP COLUMN use_gain_preset,
  DROP COLUMN gain,
  DROP COLUMN use_lc_preset,
  DROP COLUMN lc_on_off,
  DROP COLUMN lc_frequency,
  DROP COLUMN use_insert_preset,
  DROP COLUMN insert_on_off,
  DROP COLUMN insert_source,
  DROP COLUMN use_phase_preset,
  DROP COLUMN phase_on_off,
  DROP COLUMN phase,
  DROP COLUMN use_mono_preset,
  DROP COLUMN mono_on_off,
  DROP COLUMN mono,
  DROP COLUMN use_eq_preset,
  DROP COLUMN eq_on_off,
  DROP COLUMN eq_band_1_range,
  DROP COLUMN eq_band_1_level,
  DROP COLUMN eq_band_1_freq,
  DROP COLUMN eq_band_1_bw,
  DROP COLUMN eq_band_1_slope,
  DROP COLUMN eq_band_1_type,
  DROP COLUMN eq_band_2_range,
  DROP COLUMN eq_band_2_level,
  DROP COLUMN eq_band_2_freq,
  DROP COLUMN eq_band_2_bw,
  DROP COLUMN eq_band_2_slope,
  DROP COLUMN eq_band_2_type,
  DROP COLUMN eq_band_3_range,
  DROP COLUMN eq_band_3_level,
  DROP COLUMN eq_band_3_freq,
  DROP COLUMN eq_band_3_bw,
  DROP COLUMN eq_band_3_slope,
  DROP COLUMN eq_band_3_type,
  DROP COLUMN eq_band_4_range,
  DROP COLUMN eq_band_4_level,
  DROP COLUMN eq_band_4_freq,
  DROP COLUMN eq_band_4_bw,
  DROP COLUMN eq_band_4_slope,
  DROP COLUMN eq_band_4_type,
  DROP COLUMN eq_band_5_range,
  DROP COLUMN eq_band_5_level,
  DROP COLUMN eq_band_5_freq,
  DROP COLUMN eq_band_5_bw,
  DROP COLUMN eq_band_5_slope,
  DROP COLUMN eq_band_5_type,
  DROP COLUMN eq_band_6_range,
  DROP COLUMN eq_band_6_level,
  DROP COLUMN eq_band_6_freq,
  DROP COLUMN eq_band_6_bw,
  DROP COLUMN eq_band_6_slope,
  DROP COLUMN eq_band_6_type,
  DROP COLUMN use_dyn_preset,
  DROP COLUMN dyn_on_off,
  DROP COLUMN dyn_amount,
  DROP COLUMN use_mod_preset,
  DROP COLUMN mod_on_off,
  DROP COLUMN mod_lvl,
  DROP COLUMN use_routing_preset,
  DROP COLUMN routing_preset;

ALTER TABLE module_config ADD FOREIGN KEY (source_a_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_b_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_c_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_d_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_e_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_f_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_g_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE module_config ADD FOREIGN KEY (source_h_preset) REFERENCES src_preset (number) ON DELETE SET NULL;
ALTER TABLE src_config ADD FOREIGN KEY (default_src_preset) REFERENCES src_preset (number) ON DELETE SET DEFAULT;

UPDATE module_config SET source_a_preset = source_a-288 WHERE source_a>288;
UPDATE module_config SET source_b_preset = source_b-288 WHERE source_b>288;
UPDATE module_config SET source_c_preset = source_c-288 WHERE source_c>288;
UPDATE module_config SET source_d_preset = source_d-288 WHERE source_d>288;

CREATE OR REPLACE FUNCTION src_preset_renumber() RETURNS integer AS $$
DECLARE
  _record RECORD;
  cnt_pos smallint;
BEGIN
  cnt_pos := 1;
  FOR _record IN ( SELECT number FROM src_preset ORDER BY pos )
  LOOP
    UPDATE src_preset SET pos = cnt_pos WHERE number = _record.number;
    cnt_pos := cnt_pos + 1;
  END LOOP;
  RETURN cnt_pos;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION src_preset_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('src_preset_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('src_preset_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER src_preset_notify AFTER INSERT OR DELETE OR UPDATE ON src_preset FOR EACH ROW EXECUTE PROCEDURE src_preset_changed();

TRUNCATE TABLE functions;

INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,0)', 'Label', 0, 4, 1);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,1)', 'Source', 2, 4, 2);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,2)', 'Module preset A', 3, 3, 3);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,3)', 'Module preset B', 3, 3, 4);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,183)', 'Module preset C', 3, 3, 5);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,184)', 'Module preset D', 3, 3, 6);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,207)', 'Module preset E', 3, 3, 7);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,208)', 'Module preset F', 3, 3, 8);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,209)', 'Module preset G', 3, 3, 9);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,210)', 'Module preset H', 3, 3, 10);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,4)', 'Source phantom', 3, 3, 11);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,5)', 'Source pad', 3, 3, 12);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,6)', 'Source gain level', 2, 4, 13);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,7)', 'Source gain level reset', 3, 0, 14);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,8)', 'Insert on/off', 3, 3, 15);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,193)', 'Phase', 2, 4, 16);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,9)', 'Phase on/off', 3, 3, 17);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,10)', 'Gain level', 0, 1, 18);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,10)', 'Gain level', 2, 4, 19);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,11)', 'Gain level reset', 3, 0, 20);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,12)', 'Low cut frequency', 2, 4, 21);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,13)', 'Low cut on/off', 3, 3, 22);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,14)', 'EQ Band 1 level', 2, 4, 23);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,15)', 'EQ Band 1 frequency', 2, 4, 24);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,16)', 'EQ Band 1 bandwidth', 2, 4, 25);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,17)', 'EQ Band 1 level reset', 3, 0, 26);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,18)', 'EQ Band 1 frequency reset', 3, 0, 27);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,19)', 'EQ Band 1 bandwidth reset', 3, 0, 28);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,20)', 'EQ Band 1 type', 2, 4, 29);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,21)', 'EQ Band 2 level', 2, 4, 30);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,22)', 'EQ Band 2 frequency', 2, 4, 31);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,23)', 'EQ Band 2 bandwidth', 2, 4, 32);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,24)', 'EQ Band 2 level reset', 3, 0, 33);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,25)', 'EQ Band 2 frequency reset', 3, 0, 34);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,26)', 'EQ Band 2 bandwidth reset', 3, 0, 35);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,27)', 'EQ Band 2 type', 2, 4, 36);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,28)', 'EQ Band 3 level', 2, 4, 37);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,29)', 'EQ Band 3 frequency', 2, 4, 38);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,30)', 'EQ Band 3 bandwidth', 2, 4, 39);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,31)', 'EQ Band 3 level reset', 3, 0, 40);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,32)', 'EQ Band 3 frequency reset', 3, 0, 41);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,33)', 'EQ Band 3 bandwidth reset', 3, 0, 42);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,34)', 'EQ Band 3 type', 2, 4, 43);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,35)', 'EQ Band 4 level', 2, 4, 44);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,36)', 'EQ Band 4 frequency', 2, 4, 45);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,37)', 'EQ Band 4 bandwidth', 2, 4, 46);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,38)', 'EQ Band 4 level reset', 3, 0, 47);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,39)', 'EQ Band 4 frequency reset', 3, 0, 48);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,40)', 'EQ Band 4 bandwidth reset', 3, 0, 49);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,41)', 'EQ Band 4 type', 2, 4, 50);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,42)', 'EQ Band 5 level', 2, 4, 51);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,43)', 'EQ Band 5 frequency', 2, 4, 52);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,44)', 'EQ Band 5 bandwidth', 2, 4, 53);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,45)', 'EQ Band 5 level reset', 3, 0, 54);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,46)', 'EQ Band 5 frequency reset', 3, 0, 55);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,47)', 'EQ Band 5 bandwidth reset', 3, 0, 56);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,48)', 'EQ Band 5 type', 2, 4, 57);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,49)', 'EQ Band 6 level', 2, 4, 58);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,50)', 'EQ Band 6 frequency', 2, 4, 59);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,51)', 'EQ Band 6 bandwidth', 2, 4, 60);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,52)', 'EQ Band 6 level reset', 3, 0, 61);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,53)', 'EQ Band 6 frequency reset', 3, 0, 62);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,54)', 'EQ Band 6 bandwidth reset', 3, 0, 63);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,55)', 'EQ Band 6 type', 2, 4, 64);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,56)', 'EQ on/off', 3, 3, 65);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,202)', 'Downward expander threshold', 2, 4, 66);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,201)', 'AGC threshold', 2, 4, 67);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,59)', 'AGC ratio', 2, 4, 68);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,60)', 'Dynamics on/off', 3, 3, 69);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,194)', 'Mono', 2, 4, 70);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,61)', 'Mono on/off', 3, 3, 71);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,62)', 'Pan', 2, 4, 72);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,63)', 'Pan reset', 3, 0, 73);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,64)', 'Module level', 2, 4, 74);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,64)', 'Module level', 1, 1, 75);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,64)', 'Module level', 5, 5, 76);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,65)', 'Module on', 3, 3, 77);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,66)', 'Module off', 3, 3, 78);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,67)', 'Module on/off', 3, 3, 79);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,195)', 'Fader and on active', 3, 3, 80);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,196)', 'Fader and on inactive', 3, 3, 81);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,197)', 'Fader and on active/inactive', 3, 3, 82);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,198)', 'Fader on', 3, 3, 83);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,199)', 'Fader off', 3, 3, 84);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,200)', 'Fader on/off', 3, 3, 85);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,68)', 'Buss 1/2 level', 1, 1, 86);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,68)', 'Buss 1/2 level', 2, 4, 87);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,69)', 'Buss 1/2 level reset', 3, 0, 88);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,70)', 'Buss 1/2 on/off', 3, 3, 89);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,71)', 'Buss 1/2 pre', 3, 3, 90);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,72)', 'Buss 1/2 balance', 2, 4, 91);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,72)', 'Buss 1/2 balance', 1, 1, 92);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,73)', 'Buss 1/2 balance reset', 3, 0, 93);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,74)', 'Buss 3/4 level', 2, 4, 94);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,74)', 'Buss 3/4 level', 1, 1, 95);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,75)', 'Buss 3/4 level reset', 3, 0, 96);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,76)', 'Buss 3/4 on/off', 3, 3, 97);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,77)', 'Buss 3/4 pre', 3, 3, 98);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,78)', 'Buss 3/4 balance', 1, 1, 99);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,78)', 'Buss 3/4 balance', 2, 4, 100);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,79)', 'Buss 3/4 balance reset', 3, 0, 101);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,80)', 'Buss 5/6 level', 1, 1, 102);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,80)', 'Buss 5/6 level', 2, 4, 103);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,81)', 'Buss 5/6 level reset', 3, 0, 104);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,82)', 'Buss 5/6 on/off', 3, 3, 105);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,83)', 'Buss 5/6 pre', 3, 3, 106);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,84)', 'Buss 5/6 balance', 2, 4, 107);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,84)', 'Buss 5/6 balance', 1, 1, 108);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,85)', 'Buss 5/6 balance reset', 3, 0, 109);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,86)', 'Buss 7/8 level', 2, 4, 110);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,86)', 'Buss 7/8 level', 1, 1, 111);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,87)', 'Buss 7/8 level reset', 3, 0, 112);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,88)', 'Buss 7/8 on/off', 3, 3, 113);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,89)', 'Buss 7/8 pre', 3, 3, 114);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,90)', 'Buss 7/8 balance', 1, 1, 115);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,90)', 'Buss 7/8 balance', 2, 4, 116);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,91)', 'Buss 7/8 balance reset', 3, 0, 117);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,92)', 'Buss 9/10 level', 1, 1, 118);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,92)', 'Buss 9/10 level', 2, 4, 119);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,93)', 'Buss 9/10 level reset', 3, 0, 120);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,94)', 'Buss 9/10 on/off', 3, 3, 121);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,95)', 'Buss 9/10 pre', 3, 3, 122);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,96)', 'Buss 9/10 balance', 2, 4, 123);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,96)', 'Buss 9/10 balance', 1, 1, 124);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,97)', 'Buss 9/10 balance reset', 3, 0, 125);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,98)', 'Buss 11/12 level', 1, 1, 126);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,98)', 'Buss 11/12 level', 2, 4, 127);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,99)', 'Buss 11/12 level reset', 3, 0, 128);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,100)', 'Buss 11/12 on/off', 3, 3, 129);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,101)', 'Buss 11/12 pre', 3, 3, 130);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,102)', 'Buss 11/12 balance', 1, 1, 131);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,102)', 'Buss 11/12 balance', 2, 4, 132);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,103)', 'Buss 11/12 balance reset', 3, 0, 133);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,104)', 'Buss 13/14 level', 2, 4, 134);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,104)', 'Buss 13/14 level', 1, 1, 135);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,105)', 'Buss 13/14 level reset', 3, 0, 136);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,106)', 'Buss 13/14 on/off', 3, 3, 137);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,107)', 'Buss 13/14 pre', 3, 3, 138);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,108)', 'Buss 13/14 balance', 2, 4, 139);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,108)', 'Buss 13/14 balance', 1, 1, 140);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,109)', 'Buss 13/14 balance reset', 3, 0, 141);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,110)', 'Buss 15/16 level', 1, 1, 142);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,110)', 'Buss 15/16 level', 2, 4, 143);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,111)', 'Buss 15/16 level reset', 3, 0, 144);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,112)', 'Buss 15/16 on/off', 3, 3, 145);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,113)', 'Buss 15/16 pre', 3, 3, 146);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,114)', 'Buss 15/16 balance', 2, 4, 147);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,114)', 'Buss 15/16 balance', 1, 1, 148);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,115)', 'Buss 15/16 balance reset', 3, 0, 149);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,116)', 'Buss 17/18 level', 2, 4, 150);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,116)', 'Buss 17/18 level', 1, 1, 151);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,117)', 'Buss 17/18 level reset', 3, 0, 152);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,118)', 'Buss 17/18 on/off', 3, 3, 153);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,119)', 'Buss 17/18 pre', 3, 3, 154);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,120)', 'Buss 17/18 balance', 2, 4, 155);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,120)', 'Buss 17/18 balance', 1, 1, 156);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,121)', 'Buss 17/18 balance reset', 3, 0, 157);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,122)', 'Buss 19/20 level', 2, 4, 158);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,122)', 'Buss 19/20 level', 1, 1, 159);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,123)', 'Buss 19/20 level reset', 3, 0, 160);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,124)', 'Buss 19/20 on/off', 3, 3, 161);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,125)', 'Buss 19/20 pre', 3, 3, 162);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,126)', 'Buss 19/20 balance', 1, 1, 163);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,126)', 'Buss 19/20 balance', 2, 4, 164);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,127)', 'Buss 19/20 balance reset', 3, 0, 165);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,128)', 'Buss 21/22 level', 2, 4, 166);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,128)', 'Buss 21/22 level', 1, 1, 167);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,129)', 'Buss 21/22 level reset', 3, 0, 168);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,130)', 'Buss 21/22 on/off', 3, 3, 169);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,131)', 'Buss 21/22 pre', 3, 3, 170);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,132)', 'Buss 21/22 balance', 1, 1, 171);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,132)', 'Buss 21/22 balance', 2, 4, 172);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,133)', 'Buss 21/22 balance reset', 3, 0, 173);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,134)', 'Buss 23/24 level', 1, 1, 174);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,134)', 'Buss 23/24 level', 2, 4, 175);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,135)', 'Buss 23/24 level reset', 3, 0, 176);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,136)', 'Buss 23/24 on/off', 3, 3, 177);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,137)', 'Buss 23/24 pre', 3, 3, 178);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,138)', 'Buss 23/24 balance', 1, 1, 179);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,138)', 'Buss 23/24 balance', 2, 4, 180);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,139)', 'Buss 23/24 balance reset', 3, 0, 181);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,140)', 'Buss 25/26 level', 1, 1, 182);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,140)', 'Buss 25/26 level', 2, 4, 183);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,141)', 'Buss 25/26 level reset', 3, 0, 184);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,142)', 'Buss 25/26 on/off', 3, 3, 185);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,143)', 'Buss 25/26 pre', 3, 3, 186);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,144)', 'Buss 25/26 balance', 2, 4, 187);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,144)', 'Buss 25/26 balance', 1, 1, 188);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,145)', 'Buss 25/26 balance reset', 3, 0, 189);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,146)', 'Buss 27/28 level', 1, 1, 190);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,146)', 'Buss 27/28 level', 2, 4, 191);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,147)', 'Buss 27/28 level reset', 3, 0, 192);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,148)', 'Buss 27/28 on/off', 3, 3, 193);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,149)', 'Buss 27/28 pre', 3, 3, 194);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,150)', 'Buss 27/28 balance', 2, 4, 195);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,150)', 'Buss 27/28 balance', 1, 1, 196);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,151)', 'Buss 27/28 balance reset', 3, 0, 197);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,152)', 'Buss 29/30 level', 2, 4, 198);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,152)', 'Buss 29/30 level', 1, 1, 199);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,153)', 'Buss 29/30 level reset', 3, 0, 200);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,154)', 'Buss 29/30 on/off', 3, 3, 201);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,155)', 'Buss 29/30 pre', 3, 3, 202);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,156)', 'Buss 29/30 balance', 2, 4, 203);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,156)', 'Buss 29/30 balance', 1, 1, 204);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,157)', 'Buss 29/30 balance reset', 3, 0, 205);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,158)', 'Buss 31/32 level', 2, 4, 206);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,158)', 'Buss 31/32 level', 1, 1, 207);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,159)', 'Buss 31/32 level reset', 3, 0, 208);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,160)', 'Buss 31/32 on/off', 3, 3, 209);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,161)', 'Buss 31/32 pre', 3, 3, 210);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,162)', 'Buss 31/32 balance', 1, 1, 211);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,162)', 'Buss 31/32 balance', 2, 4, 212);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,163)', 'Buss 31/32 balance reset', 3, 0, 213);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,164)', 'Source start', 3, 3, 214);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,165)', 'Source stop', 3, 3, 215);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,166)', 'Source start/stop', 3, 3, 216);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,167)', 'Cough on/off', 3, 3, 217);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,168)', 'Source alert', 3, 3, 218);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,204)', 'Control', 2, 4, 219);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,205)', 'Control label', 0, 4, 220);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,206)', 'Control reset', 3, 0, 221);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,169)', 'Control 1', 2, 4, 222);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,170)', 'Control 1 label', 0, 4, 223);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,171)', 'Control 1 reset', 3, 0, 224);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,172)', 'Control 2', 2, 4, 225);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,173)', 'Control 2 label', 0, 4, 226);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,174)', 'Control 2 reset', 3, 0, 227);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,175)', 'Control 3', 2, 4, 228);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,176)', 'Control 3 label', 0, 4, 229);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,177)', 'Control 3 reset', 3, 0, 230);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,178)', 'Control 4', 2, 4, 231);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,179)', 'Control 4 label', 0, 4, 232);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,180)', 'Control 4 reset', 3, 0, 233);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,181)', 'Peak', 0, 3, 234);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,182)', 'Signal', 0, 3, 235);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,203)', 'Processing preset', 2, 4, 236);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,185)', 'Routing preset 1', 3, 0, 237);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,186)', 'Routing preset 2', 3, 0, 238);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,187)', 'Routing preset 3', 3, 0, 239);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,188)', 'Routing preset 4', 3, 0, 240);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,189)', 'Routing preset 5', 3, 0, 241);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,190)', 'Routing preset 6', 3, 0, 242);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,191)', 'Routing preset 7', 3, 0, 243);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,192)', 'Routing preset 8', 3, 0, 244);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,211)', 'Talkback 1 to N-1', 3, 3, 245);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,212)', 'Talkback 2 to N-1', 3, 3, 246);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,213)', 'Talkback 3 to N-1', 3, 3, 247);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,214)', 'Talkback 4 to N-1', 3, 3, 248);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,215)', 'Talkback 5 to N-1', 3, 3, 249);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,216)', 'Talkback 6 to N-1', 3, 3, 250);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,217)', 'Talkback 7 to N-1', 3, 3, 251);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,218)', 'Talkback 8 to N-1', 3, 3, 252);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,219)', 'Talkback 9 to N-1', 3, 3, 253);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,220)', 'Talkback 10 to N-1', 3, 3, 254);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,221)', 'Talkback 11 to N-1', 3, 3, 255);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,222)', 'Talkback 12 to N-1', 3, 3, 256);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,223)', 'Talkback 13 to N-1', 3, 3, 257);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,224)', 'Talkback 14 to N-1', 3, 3, 258);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,225)', 'Talkback 15 to N-1', 3, 3, 259);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(0,,226)', 'Talkback 16 to N-1', 3, 3, 260);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,0)', 'Buss master level', 0, 5, 261);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,0)', 'Buss master level', 2, 4, 262);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,0)', 'Buss master level', 1, 1, 263);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,1)', 'Buss master level reset', 3, 0, 264);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,2)', 'Buss master on/off', 3, 3, 265);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,3)', 'Buss master pre', 3, 3, 266);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,4)', 'Label', 0, 4, 267);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,5)', 'Audio level left', 0, 5, 268);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(1,,6)', 'Audio level right', 0, 5, 269);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,0)', 'Buss 1/2 on/off', 3, 3, 270);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,1)', 'Buss 3/4 on/off', 3, 3, 271);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,2)', 'Buss 5/6 on/off', 3, 3, 272);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,3)', 'Buss 7/8 on/off', 3, 3, 273);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,4)', 'Buss 9/10 on/off', 3, 3, 274);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,5)', 'Buss 11/12 on/off', 3, 3, 275);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,6)', 'Buss 13/14 on/off', 3, 3, 276);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,7)', 'Buss 15/16 on/off', 3, 3, 277);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,8)', 'Buss 17/18 on/off', 3, 3, 278);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,9)', 'Buss 19/20 on/off', 3, 3, 279);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,10)', 'Buss 21/22 on/off', 3, 3, 280);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,11)', 'Buss 23/24 on/off', 3, 3, 281);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,12)', 'Buss 25/26 on/off', 3, 3, 282);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,13)', 'Buss 27/28 on/off', 3, 3, 283);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,14)', 'Buss 29/30 on/off', 3, 3, 284);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,15)', 'Buss 31/32 on/off', 3, 3, 285);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,16)', 'Ext 1 on/off', 3, 3, 286);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,17)', 'Ext 2 on/off', 3, 3, 287);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,18)', 'Ext 3 on/off', 3, 3, 288);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,19)', 'Ext 4 on/off', 3, 3, 289);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,20)', 'Ext 5 on/off', 3, 3, 290);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,21)', 'Ext 6 on/off', 3, 3, 291);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,22)', 'Ext 7 on/off', 3, 3, 292);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,23)', 'Ext 8 on/off', 3, 3, 293);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,24)', 'Mute', 3, 3, 294);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,25)', 'Dim', 3, 3, 295);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,26)', 'Phones level', 2, 4, 296);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,26)', 'Phones level', 0, 5, 297);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,26)', 'Phones level', 1, 1, 298);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,27)', 'Mono', 3, 3, 299);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,28)', 'Phase', 3, 3, 300);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,29)', 'Speaker level', 0, 5, 301);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,29)', 'Speaker level', 2, 4, 302);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,29)', 'Speaker level', 1, 1, 303);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,30)', 'Talkback 1', 3, 3, 304);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,31)', 'Talkback 2', 3, 3, 305);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,32)', 'Talkback 3', 3, 3, 306);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,33)', 'Talkback 4', 3, 3, 307);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,34)', 'Talkback 5', 3, 3, 308);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,35)', 'Talkback 6', 3, 3, 309);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,36)', 'Talkback 7', 3, 3, 310);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,37)', 'Talkback 8', 3, 3, 311);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,38)', 'Talkback 9', 3, 3, 312);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,39)', 'Talkback 10', 3, 3, 313);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,40)', 'Talkback 11', 3, 3, 314);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,41)', 'Talkback 12', 3, 3, 315);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,42)', 'Talkback 13', 3, 3, 316);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,43)', 'Talkback 14', 3, 3, 317);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,44)', 'Talkback 15', 3, 3, 318);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,45)', 'Talkback 16', 3, 3, 319);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,46)', 'Audio level left', 0, 5, 320);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,47)', 'Audio level right', 0, 5, 321);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(2,,48)', 'Label', 0, 4, 322);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,0)', 'Redlight 1', 3, 3, 323);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,1)', 'Redlight 2', 3, 3, 324);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,2)', 'Redlight 3', 3, 3, 325);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,3)', 'Redlight 4', 3, 3, 326);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,4)', 'Redlight 5', 3, 3, 327);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,5)', 'Redlight 6', 3, 3, 328);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,6)', 'Redlight 7', 3, 3, 329);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,7)', 'Redlight 8', 3, 3, 330);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,8)', 'Buss 1/2 reset', 3, 3, 331);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,9)', 'Buss 3/4 reset', 3, 3, 332);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,10)', 'Buss 5/6 reset', 3, 3, 333);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,11)', 'Buss 7/8 reset', 3, 3, 334);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,12)', 'Buss 9/10 reset', 3, 3, 335);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,13)', 'Buss 11/12 reset', 3, 3, 336);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,14)', 'Buss 13/14 reset', 3, 3, 337);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,15)', 'Buss 15/16 reset', 3, 3, 338);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,16)', 'Buss 17/18 reset', 3, 3, 339);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,17)', 'Buss 19/20 reset', 3, 3, 340);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,18)', 'Buss 21/22 reset', 3, 3, 341);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,19)', 'Buss 23/24 reset', 3, 3, 342);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,20)', 'Buss 25/26 reset', 3, 3, 343);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,21)', 'Buss 27/28 reset', 3, 3, 344);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,22)', 'Buss 29/30 reset', 3, 3, 345);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,23)', 'Buss 31/32 reset', 3, 3, 346);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,24)', 'Control 1 mode source', 3, 3, 347);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,377)', 'Control 1 mode processing preset', 3, 3, 348);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,25)', 'Control 1 mode source gain', 3, 3, 349);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,358)', 'Control 1 mode source phantom', 3, 3, 350);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,359)', 'Control 1 mode source pad', 3, 3, 351);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,26)', 'Control 1 mode gain', 3, 3, 352);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,27)', 'Control 1 mode phase', 3, 3, 353);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,28)', 'Control 1 mode low cut', 3, 3, 354);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,29)', 'Control 1 mode EQ band 1 level', 3, 3, 355);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,30)', 'Control 1 mode EQ band 1 frequency', 3, 3, 356);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,31)', 'Control 1 mode EQ band 1 bandwidth', 3, 3, 357);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,32)', 'Control 1 mode EQ band 1 type', 3, 3, 358);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,33)', 'Control 1 mode EQ band 2 level', 3, 3, 359);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,34)', 'Control 1 mode EQ band 2 frequency', 3, 3, 360);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,35)', 'Control 1 mode EQ band 2 bandwidth', 3, 3, 361);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,36)', 'Control 1 mode EQ band 2 type', 3, 3, 362);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,37)', 'Control 1 mode EQ band 3 level', 3, 3, 363);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,38)', 'Control 1 mode EQ band 3 frequency', 3, 3, 364);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,39)', 'Control 1 mode EQ band 3 bandwidth', 3, 3, 365);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,40)', 'Control 1 mode EQ band 3 type', 3, 3, 366);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,41)', 'Control 1 mode EQ band 4 level', 3, 3, 367);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,42)', 'Control 1 mode EQ band 4 frequency', 3, 3, 368);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,43)', 'Control 1 mode EQ band 4 bandwidth', 3, 3, 369);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,44)', 'Control 1 mode EQ band 4 type', 3, 3, 370);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,45)', 'Control 1 mode EQ band 5 level', 3, 3, 371);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,46)', 'Control 1 mode EQ band 5 frequency', 3, 3, 372);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,47)', 'Control 1 mode EQ band 5 bandwidth', 3, 3, 373);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,48)', 'Control 1 mode EQ band 5 type', 3, 3, 374);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,49)', 'Control 1 mode EQ band 6 level', 3, 3, 375);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,50)', 'Control 1 mode EQ band 6 frequency', 3, 3, 376);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,51)', 'Control 1 mode EQ band 6 bandwidth', 3, 3, 377);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,52)', 'Control 1 mode EQ band 6 type', 3, 3, 378);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,357)', 'Control 1 mode EQ on/off', 3, 3, 379);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,373)', 'Control 1 mode downward expander threshold', 3, 3, 380);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,369)', 'Control 1 mode AGC threshold', 3, 3, 381);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,53)', 'Control 1 mode AGC ratio', 3, 3, 382);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,54)', 'Control 1 mode mono', 3, 3, 383);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,55)', 'Control 1 mode pan', 3, 3, 384);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,56)', 'Control 1 mode module level', 3, 3, 385);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,57)', 'Control 1 mode buss 1/2', 3, 3, 386);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,58)', 'Control 1 mode buss 1/2 balance', 3, 3, 387);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,59)', 'Control 1 mode buss 3/4', 3, 3, 388);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,60)', 'Control 1 mode buss 3/4 balance', 3, 3, 389);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,61)', 'Control 1 mode buss 5/6', 3, 3, 390);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,62)', 'Control 1 mode buss 5/6 balance', 3, 3, 391);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,63)', 'Control 1 mode buss 7/8', 3, 3, 392);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,64)', 'Control 1 mode buss 7/8 balance', 3, 3, 393);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,65)', 'Control 1 mode buss 9/10', 3, 3, 394);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,66)', 'Control 1 mode buss 9/10 balance', 3, 3, 395);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,67)', 'Control 1 mode buss 11/12', 3, 3, 396);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,68)', 'Control 1 mode buss 11/12 balance', 3, 3, 397);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,69)', 'Control 1 mode buss 13/14', 3, 3, 398);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,70)', 'Control 1 mode buss 13/14 balance', 3, 3, 399);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,71)', 'Control 1 mode buss 15/16', 3, 3, 400);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,72)', 'Control 1 mode buss 15/16 balance', 3, 3, 401);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,73)', 'Control 1 mode buss 17/18', 3, 3, 402);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,74)', 'Control 1 mode buss 17/18 balance', 3, 3, 403);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,75)', 'Control 1 mode buss 19/20', 3, 3, 404);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,76)', 'Control 1 mode buss 19/20 balance', 3, 3, 405);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,77)', 'Control 1 mode buss 21/22', 3, 3, 406);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,78)', 'Control 1 mode buss 21/22 balance', 3, 3, 407);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,79)', 'Control 1 mode buss 23/24', 3, 3, 408);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,80)', 'Control 1 mode buss 23/24 balance', 3, 3, 409);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,81)', 'Control 1 mode buss 25/26', 3, 3, 410);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,82)', 'Control 1 mode buss 25/26 balance', 3, 3, 411);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,83)', 'Control 1 mode buss 27/28', 3, 3, 412);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,84)', 'Control 1 mode buss 27/28 balance', 3, 3, 413);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,85)', 'Control 1 mode buss 29/30', 3, 3, 414);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,86)', 'Control 1 mode buss 29/30 balance', 3, 3, 415);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,87)', 'Control 1 mode buss 31/32', 3, 3, 416);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,88)', 'Control 1 mode buss 31/32 balance', 3, 3, 417);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,89)', 'Control 2 mode source', 3, 3, 418);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,378)', 'Control 2 mode processing preset', 3, 3, 419);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,90)', 'Control 2 mode source gain', 3, 3, 420);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,361)', 'Control 2 mode source phantom', 3, 3, 421);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,362)', 'Control 2 mode source pad', 3, 3, 422);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,91)', 'Control 2 mode gain', 3, 3, 423);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,92)', 'Control 2 mode phase', 3, 3, 424);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,93)', 'Control 2 mode low cut', 3, 3, 425);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,94)', 'Control 2 mode EQ band 1 level', 3, 3, 426);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,95)', 'Control 2 mode EQ band 1 frequency', 3, 3, 427);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,96)', 'Control 2 mode EQ band 1 bandwidth', 3, 3, 428);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,97)', 'Control 2 mode EQ band 1 type', 3, 3, 429);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,98)', 'Control 2 mode EQ band 2 level', 3, 3, 430);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,99)', 'Control 2 mode EQ band 2 frequency', 3, 3, 431);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,100)', 'Control 2 mode EQ band 2 bandwidth', 3, 3, 432);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,101)', 'Control 2 mode EQ band 2 type', 3, 3, 433);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,102)', 'Control 2 mode EQ band 3 level', 3, 3, 434);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,103)', 'Control 2 mode EQ band 3 frequency', 3, 3, 435);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,104)', 'Control 2 mode EQ band 3 bandwidth', 3, 3, 436);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,105)', 'Control 2 mode EQ band 3 type', 3, 3, 437);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,106)', 'Control 2 mode EQ band 4 level', 3, 3, 438);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,107)', 'Control 2 mode EQ band 4 frequency', 3, 3, 439);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,108)', 'Control 2 mode EQ band 4 bandwidth', 3, 3, 440);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,109)', 'Control 2 mode EQ band 4 type', 3, 3, 441);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,110)', 'Control 2 mode EQ band 5 level', 3, 3, 442);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,111)', 'Control 2 mode EQ band 5 frequency', 3, 3, 443);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,112)', 'Control 2 mode EQ band 5 bandwidth', 3, 3, 444);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,113)', 'Control 2 mode EQ band 5 type', 3, 3, 445);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,114)', 'Control 2 mode EQ band 6 level', 3, 3, 446);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,115)', 'Control 2 mode EQ band 6 frequency', 3, 3, 447);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,116)', 'Control 2 mode EQ band 6 bandwidth', 3, 3, 448);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,117)', 'Control 2 mode EQ band 6 type', 3, 3, 449);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,360)', 'Control 2 mode EQ on/off', 3, 3, 450);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,374)', 'Control 2 mode downward expander threshold', 3, 3, 451);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,370)', 'Control 2 mode AGC threshold', 3, 3, 452);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,118)', 'Control 2 mode AGC ratio', 3, 3, 453);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,119)', 'Control 2 mode mono', 3, 3, 454);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,120)', 'Control 2 mode pan', 3, 3, 455);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,121)', 'Control 2 mode module level', 3, 3, 456);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,122)', 'Control 2 mode buss 1/2', 3, 3, 457);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,123)', 'Control 2 mode buss 1/2 balance', 3, 3, 458);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,124)', 'Control 2 mode buss 3/4', 3, 3, 459);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,125)', 'Control 2 mode buss 3/4 balance', 3, 3, 460);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,126)', 'Control 2 mode buss 5/6', 3, 3, 461);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,127)', 'Control 2 mode buss 5/6 balance', 3, 3, 462);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,128)', 'Control 2 mode buss 7/8', 3, 3, 463);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,129)', 'Control 2 mode buss 7/8 balance', 3, 3, 464);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,130)', 'Control 2 mode buss 9/10', 3, 3, 465);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,131)', 'Control 2 mode buss 9/10 balance', 3, 3, 466);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,132)', 'Control 2 mode buss 11/12', 3, 3, 467);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,133)', 'Control 2 mode buss 11/12 balance', 3, 3, 468);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,134)', 'Control 2 mode buss 13/14', 3, 3, 469);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,135)', 'Control 2 mode buss 13/14 balance', 3, 3, 470);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,136)', 'Control 2 mode buss 15/16', 3, 3, 471);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,137)', 'Control 2 mode buss 15/16 balance', 3, 3, 472);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,138)', 'Control 2 mode buss 17/18', 3, 3, 473);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,139)', 'Control 2 mode buss 17/18 balance', 3, 3, 474);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,140)', 'Control 2 mode buss 19/20', 3, 3, 475);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,141)', 'Control 2 mode buss 19/20 balance', 3, 3, 476);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,142)', 'Control 2 mode buss 21/22', 3, 3, 477);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,143)', 'Control 2 mode buss 21/22 balance', 3, 3, 478);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,144)', 'Control 2 mode buss 23/24', 3, 3, 479);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,145)', 'Control 2 mode buss 23/24 balance', 3, 3, 480);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,146)', 'Control 2 mode buss 25/26', 3, 3, 481);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,147)', 'Control 2 mode buss 25/26 balance', 3, 3, 482);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,148)', 'Control 2 mode buss 27/28', 3, 3, 483);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,149)', 'Control 2 mode buss 27/28 balance', 3, 3, 484);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,150)', 'Control 2 mode buss 29/30', 3, 3, 485);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,151)', 'Control 2 mode buss 29/30 balance', 3, 3, 486);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,152)', 'Control 2 mode buss 31/32', 3, 3, 487);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,153)', 'Control 2 mode buss 31/32 balance', 3, 3, 488);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,154)', 'Control 3 mode source', 3, 3, 489);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,379)', 'Control 3 mode processing preset', 3, 3, 490);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,155)', 'Control 3 mode source gain', 3, 3, 491);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,364)', 'Control 3 mode source phantom', 3, 3, 492);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,365)', 'Control 3 mode source pad', 3, 3, 493);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,156)', 'Control 3 mode gain', 3, 3, 494);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,157)', 'Control 3 mode phase', 3, 3, 495);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,158)', 'Control 3 mode low cut', 3, 3, 496);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,159)', 'Control 3 mode EQ band 1 level', 3, 3, 497);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,160)', 'Control 3 mode EQ band 1 frequency', 3, 3, 498);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,161)', 'Control 3 mode EQ band 1 bandwidth', 3, 3, 499);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,162)', 'Control 3 mode EQ band 1 type', 3, 3, 500);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,163)', 'Control 3 mode EQ band 2 level', 3, 3, 501);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,164)', 'Control 3 mode EQ band 2 frequency', 3, 3, 502);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,165)', 'Control 3 mode EQ band 2 bandwidth', 3, 3, 503);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,166)', 'Control 3 mode EQ band 2 type', 3, 3, 504);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,167)', 'Control 3 mode EQ band 3 level', 3, 3, 505);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,168)', 'Control 3 mode EQ band 3 frequency', 3, 3, 506);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,169)', 'Control 3 mode EQ band 3 bandwidth', 3, 3, 507);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,170)', 'Control 3 mode EQ band 3 type', 3, 3, 508);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,171)', 'Control 3 mode EQ band 4 level', 3, 3, 509);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,172)', 'Control 3 mode EQ band 4 frequency', 3, 3, 510);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,173)', 'Control 3 mode EQ band 4 bandwidth', 3, 3, 511);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,174)', 'Control 3 mode EQ band 4 type', 3, 3, 512);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,175)', 'Control 3 mode EQ band 5 level', 3, 3, 513);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,176)', 'Control 3 mode EQ band 5 frequency', 3, 3, 514);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,177)', 'Control 3 mode EQ band 5 bandwidth', 3, 3, 515);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,178)', 'Control 3 mode EQ band 5 type', 3, 3, 516);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,179)', 'Control 3 mode EQ band 6 level', 3, 3, 517);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,180)', 'Control 3 mode EQ band 6 frequency', 3, 3, 518);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,181)', 'Control 3 mode EQ band 6 bandwidth', 3, 3, 519);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,182)', 'Control 3 mode EQ band 6 type', 3, 3, 520);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,363)', 'Control 3 mode EQ on/off', 3, 3, 521);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,375)', 'Control 3 mode downward expander threshold', 3, 3, 522);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,371)', 'Control 3 mode AGC threshold', 3, 3, 523);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,183)', 'Control 3 mode AGC ratio', 3, 3, 524);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,184)', 'Control 3 mode mono', 3, 3, 525);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,185)', 'Control 3 mode pan', 3, 3, 526);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,186)', 'Control 3 mode module level', 3, 3, 527);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,187)', 'Control 3 mode buss 1/2', 3, 3, 528);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,188)', 'Control 3 mode buss 1/2 balance', 3, 3, 529);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,189)', 'Control 3 mode buss 3/4', 3, 3, 530);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,190)', 'Control 3 mode buss 3/4 balance', 3, 3, 531);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,191)', 'Control 3 mode buss 5/6', 3, 3, 532);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,192)', 'Control 3 mode buss 5/6 balance', 3, 3, 533);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,193)', 'Control 3 mode buss 7/8', 3, 3, 534);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,194)', 'Control 3 mode buss 7/8 balance', 3, 3, 535);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,195)', 'Control 3 mode buss 9/10', 3, 3, 536);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,196)', 'Control 3 mode buss 9/10 balance', 3, 3, 537);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,197)', 'Control 3 mode buss 11/12', 3, 3, 538);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,198)', 'Control 3 mode buss 11/12 balance', 3, 3, 539);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,199)', 'Control 3 mode buss 13/14', 3, 3, 540);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,200)', 'Control 3 mode buss 13/14 balance', 3, 3, 541);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,201)', 'Control 3 mode buss 15/16', 3, 3, 542);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,202)', 'Control 3 mode buss 15/16 balance', 3, 3, 543);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,203)', 'Control 3 mode buss 17/18', 3, 3, 544);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,204)', 'Control 3 mode buss 17/18 balance', 3, 3, 545);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,205)', 'Control 3 mode buss 19/20', 3, 3, 546);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,206)', 'Control 3 mode buss 19/20 balance', 3, 3, 547);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,207)', 'Control 3 mode buss 21/22', 3, 3, 548);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,208)', 'Control 3 mode buss 21/22 balance', 3, 3, 549);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,209)', 'Control 3 mode buss 23/24', 3, 3, 550);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,210)', 'Control 3 mode buss 23/24 balance', 3, 3, 551);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,211)', 'Control 3 mode buss 25/26', 3, 3, 552);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,212)', 'Control 3 mode buss 25/26 balance', 3, 3, 553);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,213)', 'Control 3 mode buss 27/28', 3, 3, 554);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,214)', 'Control 3 mode buss 27/28 balance', 3, 3, 555);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,215)', 'Control 3 mode buss 29/30', 3, 3, 556);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,216)', 'Control 3 mode buss 29/30 balance', 3, 3, 557);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,217)', 'Control 3 mode buss 31/32', 3, 3, 558);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,218)', 'Control 3 mode buss 31/32 balance', 3, 3, 559);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,219)', 'Control 4 mode source', 3, 3, 560);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,380)', 'Control 4 mode processing preset', 3, 3, 561);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,220)', 'Control 4 mode source gain', 3, 3, 562);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,367)', 'Control 4 mode source phantom', 3, 3, 563);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,368)', 'Control 4 mode source pad', 3, 3, 564);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,221)', 'Control 4 mode gain', 3, 3, 565);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,222)', 'Control 4 mode phase', 3, 3, 566);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,223)', 'Control 4 mode low cut', 3, 3, 567);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,224)', 'Control 4 mode EQ band 1 level', 3, 3, 568);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,225)', 'Control 4 mode EQ band 1 frequency', 3, 3, 569);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,226)', 'Control 4 mode EQ band 1 bandwidth', 3, 3, 570);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,227)', 'Control 4 mode EQ band 1 type', 3, 3, 571);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,228)', 'Control 4 mode EQ band 2 level', 3, 3, 572);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,229)', 'Control 4 mode EQ band 2 frequency', 3, 3, 573);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,230)', 'Control 4 mode EQ band 2 bandwidth', 3, 3, 574);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,231)', 'Control 4 mode EQ band 2 type', 3, 3, 575);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,232)', 'Control 4 mode EQ band 3 level', 3, 3, 576);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,233)', 'Control 4 mode EQ band 3 frequency', 3, 3, 577);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,234)', 'Control 4 mode EQ band 3 bandwidth', 3, 3, 578);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,235)', 'Control 4 mode EQ band 3 type', 3, 3, 579);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,236)', 'Control 4 mode EQ band 4 level', 3, 3, 580);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,237)', 'Control 4 mode EQ band 4 frequency', 3, 3, 581);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,238)', 'Control 4 mode EQ band 4 bandwidth', 3, 3, 582);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,239)', 'Control 4 mode EQ band 4 type', 3, 3, 583);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,240)', 'Control 4 mode EQ band 5 level', 3, 3, 584);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,241)', 'Control 4 mode EQ band 5 frequency', 3, 3, 585);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,242)', 'Control 4 mode EQ band 5 bandwidth', 3, 3, 586);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,243)', 'Control 4 mode EQ band 5 type', 3, 3, 587);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,244)', 'Control 4 mode EQ band 6 level', 3, 3, 588);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,245)', 'Control 4 mode EQ band 6 frequency', 3, 3, 589);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,246)', 'Control 4 mode EQ band 6 bandwidth', 3, 3, 590);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,247)', 'Control 4 mode EQ band 6 type', 3, 3, 591);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,366)', 'Control 4 mode EQ on/off', 3, 3, 592);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,376)', 'Control 4 mode downward expander threshold', 3, 3, 593);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,372)', 'Control 4 mode AGC threshold', 3, 3, 594);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,248)', 'Control 4 mode AGC ratio', 3, 3, 595);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,249)', 'Control 4 mode mono', 3, 3, 596);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,250)', 'Control 4 mode pan', 3, 3, 597);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,251)', 'Control 4 mode module level', 3, 3, 598);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,252)', 'Control 4 mode buss 1/2', 3, 3, 599);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,253)', 'Control 4 mode buss 1/2 balance', 3, 3, 600);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,254)', 'Control 4 mode buss 3/4', 3, 3, 601);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,255)', 'Control 4 mode buss 3/4 balance', 3, 3, 602);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,256)', 'Control 4 mode buss 5/6', 3, 3, 603);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,257)', 'Control 4 mode buss 5/6 balance', 3, 3, 604);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,258)', 'Control 4 mode buss 7/8', 3, 3, 605);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,259)', 'Control 4 mode buss 7/8 balance', 3, 3, 606);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,260)', 'Control 4 mode buss 9/10', 3, 3, 607);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,261)', 'Control 4 mode buss 9/10 balance', 3, 3, 608);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,262)', 'Control 4 mode buss 11/12', 3, 3, 609);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,263)', 'Control 4 mode buss 11/12 balance', 3, 3, 610);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,264)', 'Control 4 mode buss 13/14', 3, 3, 611);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,265)', 'Control 4 mode buss 13/14 balance', 3, 3, 612);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,266)', 'Control 4 mode buss 15/16', 3, 3, 613);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,267)', 'Control 4 mode buss 15/16 balance', 3, 3, 614);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,268)', 'Control 4 mode buss 17/18', 3, 3, 615);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,269)', 'Control 4 mode buss 17/18 balance', 3, 3, 616);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,270)', 'Control 4 mode buss 19/20', 3, 3, 617);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,271)', 'Control 4 mode buss 19/20 balance', 3, 3, 618);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,272)', 'Control 4 mode buss 21/22', 3, 3, 619);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,273)', 'Control 4 mode buss 21/22 balance', 3, 3, 620);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,274)', 'Control 4 mode buss 23/24', 3, 3, 621);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,275)', 'Control 4 mode buss 23/24 balance', 3, 3, 622);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,276)', 'Control 4 mode buss 25/26', 3, 3, 623);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,277)', 'Control 4 mode buss 25/26 balance', 3, 3, 624);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,278)', 'Control 4 mode buss 27/28', 3, 3, 625);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,279)', 'Control 4 mode buss 27/28 balance', 3, 3, 626);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,280)', 'Control 4 mode buss 29/30', 3, 3, 627);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,281)', 'Control 4 mode buss 29/30 balance', 3, 3, 628);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,282)', 'Control 4 mode buss 31/32', 3, 3, 629);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,283)', 'Control 4 mode buss 31/32 balance', 3, 3, 630);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,284)', 'Master control 1 mode buss 1/2', 3, 3, 631);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,285)', 'Master control 1 mode buss 3/4', 3, 3, 632);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,286)', 'Master control 1 mode buss 5/6', 3, 3, 633);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,287)', 'Master control 1 mode buss 7/8', 3, 3, 634);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,288)', 'Master control 1 mode buss 9/10', 3, 3, 635);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,289)', 'Master control 1 mode buss 11/12', 3, 3, 636);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,290)', 'Master control 1 mode buss 13/14', 3, 3, 637);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,291)', 'Master control 1 mode buss 15/16', 3, 3, 638);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,292)', 'Master control 1 mode buss 17/18', 3, 3, 639);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,293)', 'Master control 1 mode buss 19/20', 3, 3, 640);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,294)', 'Master control 1 mode buss 21/22', 3, 3, 641);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,295)', 'Master control 1 mode buss 23/24', 3, 3, 642);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,296)', 'Master control 1 mode buss 25/26', 3, 3, 643);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,297)', 'Master control 1 mode buss 27/28', 3, 3, 644);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,298)', 'Master control 1 mode buss 29/30', 3, 3, 645);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,299)', 'Master control 1 mode buss 31/32', 3, 3, 646);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,300)', 'Master control 2 mode buss 1/2', 3, 3, 647);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,301)', 'Master control 2 mode buss 3/4', 3, 3, 648);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,302)', 'Master control 2 mode buss 5/6', 3, 3, 649);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,303)', 'Master control 2 mode buss 7/8', 3, 3, 650);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,304)', 'Master control 2 mode buss 9/10', 3, 3, 651);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,305)', 'Master control 2 mode buss 11/12', 3, 3, 652);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,306)', 'Master control 2 mode buss 13/14', 3, 3, 653);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,307)', 'Master control 2 mode buss 15/16', 3, 3, 654);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,308)', 'Master control 2 mode buss 17/18', 3, 3, 655);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,309)', 'Master control 2 mode buss 19/20', 3, 3, 656);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,310)', 'Master control 2 mode buss 21/22', 3, 3, 657);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,311)', 'Master control 2 mode buss 23/24', 3, 3, 658);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,312)', 'Master control 2 mode buss 25/26', 3, 3, 659);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,313)', 'Master control 2 mode buss 27/28', 3, 3, 660);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,314)', 'Master control 2 mode buss 29/30', 3, 3, 661);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,315)', 'Master control 2 mode buss 31/32', 3, 3, 662);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,316)', 'Master control 3 mode buss 1/2', 3, 3, 663);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,317)', 'Master control 3 mode buss 3/4', 3, 3, 664);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,318)', 'Master control 3 mode buss 5/6', 3, 3, 665);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,319)', 'Master control 3 mode buss 7/8', 3, 3, 666);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,320)', 'Master control 3 mode buss 9/10', 3, 3, 667);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,321)', 'Master control 3 mode buss 11/12', 3, 3, 668);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,322)', 'Master control 3 mode buss 13/14', 3, 3, 669);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,323)', 'Master control 3 mode buss 15/16', 3, 3, 670);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,324)', 'Master control 3 mode buss 17/18', 3, 3, 671);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,325)', 'Master control 3 mode buss 19/20', 3, 3, 672);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,326)', 'Master control 3 mode buss 21/22', 3, 3, 673);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,327)', 'Master control 3 mode buss 23/24', 3, 3, 674);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,328)', 'Master control 3 mode buss 25/26', 3, 3, 675);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,329)', 'Master control 3 mode buss 27/28', 3, 3, 676);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,330)', 'Master control 3 mode buss 29/30', 3, 3, 677);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,331)', 'Master control 3 mode buss 31/32', 3, 3, 678);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,332)', 'Master control 4 mode buss 1/2', 3, 3, 679);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,333)', 'Master control 4 mode buss 3/4', 3, 3, 680);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,334)', 'Master control 4 mode buss 5/6', 3, 3, 681);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,335)', 'Master control 4 mode buss 7/8', 3, 3, 682);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,336)', 'Master control 4 mode buss 9/10', 3, 3, 683);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,337)', 'Master control 4 mode buss 11/12', 3, 3, 684);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,338)', 'Master control 4 mode buss 13/14', 3, 3, 685);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,339)', 'Master control 4 mode buss 15/16', 3, 3, 686);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,340)', 'Master control 4 mode buss 17/18', 3, 3, 687);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,341)', 'Master control 4 mode buss 19/20', 3, 3, 688);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,342)', 'Master control 4 mode buss 21/22', 3, 3, 689);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,343)', 'Master control 4 mode buss 23/24', 3, 3, 690);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,344)', 'Master control 4 mode buss 25/26', 3, 3, 691);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,345)', 'Master control 4 mode buss 27/28', 3, 3, 692);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,346)', 'Master control 4 mode buss 29/30', 3, 3, 693);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,347)', 'Master control 4 mode buss 31/32', 3, 3, 694);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,348)', 'Master control 1', 2, 6, 695);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,348)', 'Master control 1', 1, 1, 696);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,349)', 'Master control 1 reset', 3, 0, 697);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,350)', 'Master control 2', 2, 6, 698);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,350)', 'Master control 2', 1, 1, 699);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,351)', 'Master control 2 reset', 3, 0, 700);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,352)', 'Master control 3', 2, 6, 701);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,352)', 'Master control 3', 1, 1, 702);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,353)', 'Master control 3 reset', 3, 0, 703);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,354)', 'Master control 4', 1, 1, 704);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,354)', 'Master control 4', 2, 6, 705);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,355)', 'Master control 4 reset', 3, 0, 706);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,381)', 'Reset console 1 to programmed defaults', 3, 3, 707);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,382)', 'Reset console 2 to programmed defaults', 3, 3, 708);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,383)', 'Reset console 3 to programmed defaults', 3, 3, 709);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,384)', 'Reset console 4 to programmed defaults', 3, 3, 710);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,385)', 'Console preset 1', 3, 3, 711);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,386)', 'Console preset 2', 3, 3, 712);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,387)', 'Console preset 3', 3, 3, 713);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,388)', 'Console preset 4', 3, 3, 714);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,389)', 'Console preset 5', 3, 3, 715);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,390)', 'Console preset 6', 3, 3, 716);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,391)', 'Console preset 7', 3, 3, 717);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,392)', 'Console preset 8', 3, 3, 718);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,393)', 'Console preset 9', 3, 3, 719);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,394)', 'Console preset 10', 3, 3, 720);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,395)', 'Console preset 11', 3, 3, 721);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,396)', 'Console preset 12', 3, 3, 722);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,397)', 'Console preset 13', 3, 3, 723);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,398)', 'Console preset 14', 3, 3, 724);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,399)', 'Console preset 15', 3, 3, 725);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,400)', 'Console preset 16', 3, 3, 726);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,401)', 'Console preset 17', 3, 3, 727);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,402)', 'Console preset 18', 3, 3, 728);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,403)', 'Console preset 19', 3, 3, 729);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,404)', 'Console preset 20', 3, 3, 730);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,405)', 'Console preset 21', 3, 3, 731);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,406)', 'Console preset 22', 3, 3, 732);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,407)', 'Console preset 23', 3, 3, 733);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,408)', 'Console preset 24', 3, 3, 734);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,409)', 'Console preset 25', 3, 3, 735);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,410)', 'Console preset 26', 3, 3, 736);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,411)', 'Console preset 27', 3, 3, 737);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,412)', 'Console preset 28', 3, 3, 738);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,413)', 'Console preset 29', 3, 3, 739);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,414)', 'Console preset 30', 3, 3, 740);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,415)', 'Console preset 31', 3, 3, 741);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,416)', 'Console preset 32', 3, 3, 742);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,417)', 'Master & control 1 mode buss 1/2', 3, 3, 743);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,418)', 'Master & control 1 mode buss 3/4', 3, 3, 744);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,419)', 'Master & control 1 mode buss 5/6', 3, 3, 745);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,420)', 'Master & control 1 mode buss 7/8', 3, 3, 746);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,421)', 'Master & control 1 mode buss 9/10', 3, 3, 747);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,422)', 'Master & control 1 mode buss 11/12', 3, 3, 748);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,423)', 'Master & control 1 mode buss 13/14', 3, 3, 749);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,424)', 'Master & control 1 mode buss 15/16', 3, 3, 750);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,425)', 'Master & control 1 mode buss 17/18', 3, 3, 751);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,426)', 'Master & control 1 mode buss 19/20', 3, 3, 752);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,427)', 'Master & control 1 mode buss 21/22', 3, 3, 753);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,428)', 'Master & control 1 mode buss 23/24', 3, 3, 754);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,429)', 'Master & control 1 mode buss 25/26', 3, 3, 755);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,430)', 'Master & control 1 mode buss 27/28', 3, 3, 756);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,431)', 'Master & control 1 mode buss 29/30', 3, 3, 757);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,432)', 'Master & control 1 mode buss 31/32', 3, 3, 758);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,433)', 'Master & control 2 mode buss 1/2', 3, 3, 759);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,434)', 'Master & control 2 mode buss 3/4', 3, 3, 760);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,435)', 'Master & control 2 mode buss 5/6', 3, 3, 761);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,436)', 'Master & control 2 mode buss 7/8', 3, 3, 762);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,437)', 'Master & control 2 mode buss 9/10', 3, 3, 763);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,438)', 'Master & control 2 mode buss 11/12', 3, 3, 764);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,439)', 'Master & control 2 mode buss 13/14', 3, 3, 765);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,440)', 'Master & control 2 mode buss 15/16', 3, 3, 766);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,441)', 'Master & control 2 mode buss 17/18', 3, 3, 767);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,442)', 'Master & control 2 mode buss 19/20', 3, 3, 768);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,443)', 'Master & control 2 mode buss 21/22', 3, 3, 769);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,444)', 'Master & control 2 mode buss 23/24', 3, 3, 770);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,445)', 'Master & control 2 mode buss 25/26', 3, 3, 771);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,446)', 'Master & control 2 mode buss 27/28', 3, 3, 772);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,447)', 'Master & control 2 mode buss 29/30', 3, 3, 773);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,448)', 'Master & control 2 mode buss 31/32', 3, 3, 774);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,449)', 'Master & control 3 mode buss 1/2', 3, 3, 775);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,450)', 'Master & control 3 mode buss 3/4', 3, 3, 776);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,451)', 'Master & control 3 mode buss 5/6', 3, 3, 777);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,452)', 'Master & control 3 mode buss 7/8', 3, 3, 778);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,453)', 'Master & control 3 mode buss 9/10', 3, 3, 779);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,454)', 'Master & control 3 mode buss 11/12', 3, 3, 780);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,455)', 'Master & control 3 mode buss 13/14', 3, 3, 781);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,456)', 'Master & control 3 mode buss 15/16', 3, 3, 782);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,457)', 'Master & control 3 mode buss 17/18', 3, 3, 783);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,458)', 'Master & control 3 mode buss 19/20', 3, 3, 784);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,459)', 'Master & control 3 mode buss 21/22', 3, 3, 785);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,460)', 'Master & control 3 mode buss 23/24', 3, 3, 786);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,461)', 'Master & control 3 mode buss 25/26', 3, 3, 787);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,462)', 'Master & control 3 mode buss 27/28', 3, 3, 788);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,463)', 'Master & control 3 mode buss 29/30', 3, 3, 789);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,464)', 'Master & control 3 mode buss 31/32', 3, 3, 790);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,465)', 'Master & control 4 mode buss 1/2', 3, 3, 791);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,466)', 'Master & control 4 mode buss 3/4', 3, 3, 792);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,467)', 'Master & control 4 mode buss 5/6', 3, 3, 793);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,468)', 'Master & control 4 mode buss 7/8', 3, 3, 794);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,469)', 'Master & control 4 mode buss 9/10', 3, 3, 795);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,470)', 'Master & control 4 mode buss 11/12', 3, 3, 796);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,471)', 'Master & control 4 mode buss 13/14', 3, 3, 797);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,472)', 'Master & control 4 mode buss 15/16', 3, 3, 798);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,473)', 'Master & control 4 mode buss 17/18', 3, 3, 799);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,474)', 'Master & control 4 mode buss 19/20', 3, 3, 800);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,475)', 'Master & control 4 mode buss 21/22', 3, 3, 801);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,476)', 'Master & control 4 mode buss 23/24', 3, 3, 802);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,477)', 'Master & control 4 mode buss 25/26', 3, 3, 803);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,478)', 'Master & control 4 mode buss 27/28', 3, 3, 804);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,479)', 'Master & control 4 mode buss 29/30', 3, 3, 805);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,480)', 'Master & control 4 mode buss 31/32', 3, 3, 806);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,481)', 'Console 1 preset', 0, 4, 807);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,482)', 'Console 2 preset', 0, 4, 808);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,483)', 'Console 3 preset', 0, 4, 809);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(4,,484)', 'Console 4 preset', 0, 4, 810);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,0)', 'Module on', 3, 3, 811);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,1)', 'Module off', 3, 3, 812);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,2)', 'Module on/off', 3, 3, 813);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,3)', 'Module fader on', 3, 3, 814);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,4)', 'Module fader off', 3, 3, 815);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,5)', 'Module fader on/off', 3, 3, 816);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,6)', 'Module fader and on active', 3, 3, 817);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,7)', 'Module fader and on inactive', 3, 3, 818);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,8)', 'Module buss 1/2 on', 3, 3, 819);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,9)', 'Module buss 1/2 off', 3, 3, 820);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,10)', 'Module buss 1/2 on/off', 3, 3, 821);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,11)', 'Module buss 3/4 on', 3, 3, 822);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,12)', 'Module buss 3/4 off', 3, 3, 823);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,13)', 'Module buss 3/4 on/off', 3, 3, 824);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,14)', 'Module buss 5/6 on', 3, 3, 825);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,15)', 'Module buss 5/6 off', 3, 3, 826);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,16)', 'Module buss 5/6 on/off', 3, 3, 827);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,17)', 'Module buss 7/8 on', 3, 3, 828);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,18)', 'Module buss 7/8 off', 3, 3, 829);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,19)', 'Module buss 7/8 on/off', 3, 3, 830);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,20)', 'Module buss 9/10 on', 3, 3, 831);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,21)', 'Module buss 9/10 off', 3, 3, 832);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,22)', 'Module buss 9/10 on/off', 3, 3, 833);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,23)', 'Module buss 11/12 on', 3, 3, 834);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,24)', 'Module buss 11/12 off', 3, 3, 835);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,25)', 'Module buss 11/12 on/off', 3, 3, 836);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,26)', 'Module buss 13/14 on', 3, 3, 837);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,27)', 'Module buss 13/14 off', 3, 3, 838);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,28)', 'Module buss 13/14 on/off', 3, 3, 839);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,29)', 'Module buss 15/16 on', 3, 3, 840);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,30)', 'Module buss 15/16 off', 3, 3, 841);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,31)', 'Module buss 15/16 on/off', 3, 3, 842);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,32)', 'Module buss 17/18 on', 3, 3, 843);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,33)', 'Module buss 17/18 off', 3, 3, 844);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,34)', 'Module buss 17/18 on/off', 3, 3, 845);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,35)', 'Module buss 19/20 on', 3, 3, 846);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,36)', 'Module buss 19/20 off', 3, 3, 847);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,37)', 'Module buss 19/20 on/off', 3, 3, 848);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,38)', 'Module buss 21/22 on', 3, 3, 849);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,39)', 'Module buss 21/22 off', 3, 3, 850);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,40)', 'Module buss 21/22 on/off', 3, 3, 851);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,41)', 'Module buss 23/24 on', 3, 3, 852);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,42)', 'Module buss 23/24 off', 3, 3, 853);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,43)', 'Module buss 23/24 on/off', 3, 3, 854);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,44)', 'Module buss 25/26 on', 3, 3, 855);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,45)', 'Module buss 25/26 off', 3, 3, 856);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,46)', 'Module buss 25/26 on/off', 3, 3, 857);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,47)', 'Module buss 27/28 on', 3, 3, 858);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,48)', 'Module buss 27/28 off', 3, 3, 859);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,49)', 'Module buss 27/28 on/off', 3, 3, 860);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,50)', 'Module buss 29/30 on', 3, 3, 861);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,51)', 'Module buss 29/30 off', 3, 3, 862);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,52)', 'Module buss 29/30 on/off', 3, 3, 863);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,53)', 'Module buss 31/32 on', 3, 3, 864);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,54)', 'Module buss 31/32 off', 3, 3, 865);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,55)', 'Module buss 31/32 on/off', 3, 3, 866);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,56)', 'Module cough on/off', 3, 3, 867);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,57)', 'Start', 3, 3, 868);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,58)', 'Stop', 3, 3, 869);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,59)', 'Start/stop', 3, 3, 870);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,60)', 'Phantom', 3, 3, 871);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,61)', 'Pad', 3, 3, 872);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,62)', 'Input gain', 2, 5, 873);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(5,,63)', 'Alert', 3, 3, 874);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,0)', 'Label', 0, 4, 875);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,1)', 'Source', 2, 4, 876);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,2)', 'Monitor speaker level', 0, 4, 877);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,2)', 'Monitor speaker level', 0, 1, 878);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,2)', 'Monitor speaker level', 0, 5, 879);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,3)', 'Monitor phones level', 0, 5, 880);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,3)', 'Monitor phones level', 0, 4, 881);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,3)', 'Monitor phones level', 0, 1, 882);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,4)', 'Level', 2, 4, 883);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,4)', 'Level', 1, 1, 884);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,4)', 'Level', 0, 5, 885);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,5)', 'Mute', 3, 3, 886);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,6)', 'Mute & Monitor mute', 0, 3, 887);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,7)', 'Dim', 3, 3, 888);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,8)', 'Dim & Monitor dim', 0, 3, 889);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,9)', 'Mono', 3, 3, 890);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,10)', 'Mono & Monitor mono', 0, 3, 891);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,11)', 'Phase', 3, 3, 892);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,12)', 'Phase & Monitor phase', 0, 3, 893);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,13)', 'Talkback 1', 3, 3, 894);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,14)', 'Talkback 1 & Monitor talkback 1', 0, 3, 895);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,15)', 'Talkback 2', 3, 3, 896);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,16)', 'Talkback 2 & Monitor talkback 2', 0, 3, 897);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,17)', 'Talkback 3', 3, 3, 898);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,18)', 'Talkback 3 & Monitor talkback 3', 0, 3, 899);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,19)', 'Talkback 4', 3, 3, 900);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,20)', 'Talkback 4 & Monitor talkback 4', 0, 3, 901);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,21)', 'Talkback 5', 3, 3, 902);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,22)', 'Talkback 5 & Monitor talkback 5', 0, 3, 903);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,23)', 'Talkback 6', 3, 3, 904);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,24)', 'Talkback 6 & Monitor talkback 6', 0, 3, 905);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,25)', 'Talkback 7', 3, 3, 906);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,26)', 'Talkback 7 & Monitor talkback 7', 0, 3, 907);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,27)', 'Talkback 8', 3, 3, 908);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,28)', 'Talkback 8 & Monitor talkback 8', 0, 3, 909);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,29)', 'Talkback 9', 3, 3, 910);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,30)', 'Talkback 9 & Monitor talkback 9', 0, 3, 911);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,31)', 'Talkback 10', 3, 3, 912);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,32)', 'Talkback 10 & Monitor talkback 10', 0, 3, 913);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,33)', 'Talkback 11', 3, 3, 914);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,34)', 'Talkback 11 & Monitor talkback 11', 0, 3, 915);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,35)', 'Talkback 12', 3, 3, 916);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,36)', 'Talkback 12 & Monitor talkback 12', 0, 3, 917);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,37)', 'Talkback 13', 3, 3, 918);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,38)', 'Talkback 13 & Monitor talkback 13', 0, 3, 919);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,39)', 'Talkback 14', 3, 3, 920);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,40)', 'Talkback 14 & Monitor talkback 14', 0, 3, 921);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,41)', 'Talkback 15', 3, 3, 922);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,42)', 'Talkback 15 & Monitor talkback 15', 0, 3, 923);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,43)', 'Talkback 16', 3, 3, 924);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,44)', 'Talkback 16 & Monitor talkback 16', 0, 3, 925);
INSERT INTO functions (func, name, rcv_type, xmt_type, pos) VALUES ('(6,,45)', 'Routing', 2, 4, 926);

ALTER TABLE monitor_buss_config
  ADD COLUMN console smallint NOT NULL DEFAULT 1 CHECK(console>=1 AND console<=4);

ALTER TABLE monitor_buss_config
  ADD CHECK(dim_level>=-140 AND dim_level<=0);

ALTER TABLE module_config
  ADD COLUMN new_buss_1_2_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_1_2_level>=-140 AND new_buss_1_2_level<=10),
  ADD COLUMN new_buss_1_2_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_1_2_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_1_2_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_1_2_balance>=0 AND new_buss_1_2_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_3_4_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_3_4_level>=-140 AND new_buss_3_4_level<=10),
  ADD COLUMN new_buss_3_4_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_3_4_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_3_4_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_3_4_balance>=0 AND new_buss_3_4_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_5_6_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_5_6_level>=-140 AND new_buss_5_6_level<=10),
  ADD COLUMN new_buss_5_6_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_5_6_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_5_6_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_5_6_balance>=0 AND new_buss_5_6_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_7_8_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_7_8_level>=-140 AND new_buss_7_8_level<=10),
  ADD COLUMN new_buss_7_8_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_7_8_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_7_8_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_7_8_balance>=0 AND new_buss_7_8_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_9_10_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_9_10_level>=-140 AND new_buss_9_10_level<=10),
  ADD COLUMN new_buss_9_10_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_9_10_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_9_10_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_9_10_balance>=0 AND new_buss_9_10_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_11_12_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_11_12_level>=-140 AND new_buss_11_12_level<=10),
  ADD COLUMN new_buss_11_12_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_11_12_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_11_12_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_11_12_balance>=0 AND new_buss_11_12_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_13_14_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_13_14_level>=-140 AND new_buss_13_14_level<=10),
  ADD COLUMN new_buss_13_14_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_13_14_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_13_14_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_13_14_balance>=0 AND new_buss_13_14_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_15_16_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_15_16_level>=-140 AND new_buss_15_16_level<=10),
  ADD COLUMN new_buss_15_16_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_15_16_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_15_16_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_15_16_balance>=0 AND new_buss_15_16_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_17_18_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_17_18_level>=-140 AND new_buss_17_18_level<=10),
  ADD COLUMN new_buss_17_18_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_17_18_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_17_18_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_17_18_balance>=0 AND new_buss_17_18_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_19_20_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_19_20_level>=-140 AND new_buss_19_20_level<=10),
  ADD COLUMN new_buss_19_20_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_19_20_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_19_20_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_19_20_balance>=0 AND new_buss_19_20_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_21_22_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_21_22_level>=-140 AND new_buss_21_22_level<=10),
  ADD COLUMN new_buss_21_22_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_21_22_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_21_22_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_21_22_balance>=0 AND new_buss_21_22_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_23_24_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_23_24_level>=-140 AND new_buss_23_24_level<=10),
  ADD COLUMN new_buss_23_24_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_23_24_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_23_24_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_23_24_balance>=0 AND new_buss_23_24_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_25_26_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_25_26_level>=-140 AND new_buss_25_26_level<=10),
  ADD COLUMN new_buss_25_26_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_25_26_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_25_26_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_25_26_balance>=0 AND new_buss_25_26_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_27_28_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_27_28_level>=-140 AND new_buss_27_28_level<=10),
  ADD COLUMN new_buss_27_28_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_27_28_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_27_28_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_27_28_balance>=0 AND new_buss_27_28_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_29_30_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_29_30_level>=-140 AND new_buss_29_30_level<=10),
  ADD COLUMN new_buss_29_30_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_29_30_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_29_30_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_29_30_balance>=0 AND new_buss_29_30_balance<=1023);

ALTER TABLE module_config
  ADD COLUMN new_buss_31_32_level double precision NOT NULL DEFAULT 0 CHECK(new_buss_31_32_level>=-140 AND new_buss_31_32_level<=10),
  ADD COLUMN new_buss_31_32_on_off boolean NOT NULL DEFAULT true,
  ADD COLUMN new_buss_31_32_pre_post boolean NOT NULL DEFAULT false,
  ADD COLUMN new_buss_31_32_balance smallint NOT NULL DEFAULT 512 CHECK(new_buss_31_32_balance>=0 AND new_buss_31_32_balance<=1023);

UPDATE module_config SET new_buss_1_2_level = buss_1_2_level[1];
UPDATE module_config SET new_buss_1_2_on_off = buss_1_2_on_off[1];
UPDATE module_config SET new_buss_1_2_pre_post = buss_1_2_pre_post[1];
UPDATE module_config SET new_buss_1_2_balance = buss_1_2_balance[1];
UPDATE module_config SET new_buss_3_4_level = buss_3_4_level[1];
UPDATE module_config SET new_buss_3_4_on_off = buss_3_4_on_off[1];
UPDATE module_config SET new_buss_3_4_pre_post = buss_3_4_pre_post[1];
UPDATE module_config SET new_buss_3_4_balance = buss_3_4_balance[1];
UPDATE module_config SET new_buss_5_6_level = buss_5_6_level[1];
UPDATE module_config SET new_buss_5_6_on_off = buss_5_6_on_off[1];
UPDATE module_config SET new_buss_5_6_pre_post = buss_5_6_pre_post[1];
UPDATE module_config SET new_buss_5_6_balance = buss_5_6_balance[1];
UPDATE module_config SET new_buss_7_8_level = buss_7_8_level[1];
UPDATE module_config SET new_buss_7_8_on_off = buss_7_8_on_off[1];
UPDATE module_config SET new_buss_7_8_pre_post = buss_7_8_pre_post[1];
UPDATE module_config SET new_buss_7_8_balance = buss_7_8_balance[1];
UPDATE module_config SET new_buss_9_10_level = buss_9_10_level[1];
UPDATE module_config SET new_buss_9_10_on_off = buss_9_10_on_off[1];
UPDATE module_config SET new_buss_9_10_pre_post = buss_9_10_pre_post[1];
UPDATE module_config SET new_buss_9_10_balance = buss_9_10_balance[1];
UPDATE module_config SET new_buss_11_12_level = buss_11_12_level[1];
UPDATE module_config SET new_buss_11_12_on_off = buss_11_12_on_off[1];
UPDATE module_config SET new_buss_11_12_pre_post = buss_11_12_pre_post[1];
UPDATE module_config SET new_buss_11_12_balance = buss_11_12_balance[1];
UPDATE module_config SET new_buss_13_14_level = buss_13_14_level[1];
UPDATE module_config SET new_buss_13_14_on_off = buss_13_14_on_off[1];
UPDATE module_config SET new_buss_13_14_pre_post = buss_13_14_pre_post[1];
UPDATE module_config SET new_buss_13_14_balance = buss_13_14_balance[1];
UPDATE module_config SET new_buss_15_16_level = buss_15_16_level[1];
UPDATE module_config SET new_buss_15_16_on_off = buss_15_16_on_off[1];
UPDATE module_config SET new_buss_15_16_pre_post = buss_15_16_pre_post[1];
UPDATE module_config SET new_buss_15_16_balance = buss_15_16_balance[1];
UPDATE module_config SET new_buss_17_18_level = buss_17_18_level[1];
UPDATE module_config SET new_buss_17_18_on_off = buss_17_18_on_off[1];
UPDATE module_config SET new_buss_17_18_pre_post = buss_17_18_pre_post[1];
UPDATE module_config SET new_buss_17_18_balance = buss_17_18_balance[1];
UPDATE module_config SET new_buss_19_20_level = buss_19_20_level[1];
UPDATE module_config SET new_buss_19_20_on_off = buss_19_20_on_off[1];
UPDATE module_config SET new_buss_19_20_pre_post = buss_19_20_pre_post[1];
UPDATE module_config SET new_buss_19_20_balance = buss_19_20_balance[1];
UPDATE module_config SET new_buss_21_22_level = buss_21_22_level[1];
UPDATE module_config SET new_buss_21_22_on_off = buss_21_22_on_off[1];
UPDATE module_config SET new_buss_21_22_pre_post = buss_21_22_pre_post[1];
UPDATE module_config SET new_buss_21_22_balance = buss_21_22_balance[1];
UPDATE module_config SET new_buss_23_24_level = buss_23_24_level[1];
UPDATE module_config SET new_buss_23_24_on_off = buss_23_24_on_off[1];
UPDATE module_config SET new_buss_23_24_pre_post = buss_23_24_pre_post[1];
UPDATE module_config SET new_buss_23_24_balance = buss_23_24_balance[1];
UPDATE module_config SET new_buss_25_26_level = buss_25_26_level[1];
UPDATE module_config SET new_buss_25_26_on_off = buss_25_26_on_off[1];
UPDATE module_config SET new_buss_25_26_pre_post = buss_25_26_pre_post[1];
UPDATE module_config SET new_buss_25_26_balance = buss_25_26_balance[1];
UPDATE module_config SET new_buss_27_28_level = buss_27_28_level[1];
UPDATE module_config SET new_buss_27_28_on_off = buss_27_28_on_off[1];
UPDATE module_config SET new_buss_27_28_pre_post = buss_27_28_pre_post[1];
UPDATE module_config SET new_buss_27_28_balance = buss_27_28_balance[1];
UPDATE module_config SET new_buss_29_30_level = buss_29_30_level[1];
UPDATE module_config SET new_buss_29_30_on_off = buss_29_30_on_off[1];
UPDATE module_config SET new_buss_29_30_pre_post = buss_29_30_pre_post[1];
UPDATE module_config SET new_buss_29_30_balance = buss_29_30_balance[1];
UPDATE module_config SET new_buss_31_32_level = buss_31_32_level[1];
UPDATE module_config SET new_buss_31_32_on_off = buss_31_32_on_off[1];
UPDATE module_config SET new_buss_31_32_pre_post = buss_31_32_pre_post[1];
UPDATE module_config SET new_buss_31_32_balance = buss_31_32_balance[1];

ALTER TABLE module_config
  DROP COLUMN buss_1_2_level,
  DROP COLUMN buss_1_2_on_off,
  DROP COLUMN buss_1_2_pre_post,
  DROP COLUMN buss_1_2_balance,
  DROP COLUMN buss_1_2_use_preset,
  DROP COLUMN buss_3_4_level,
  DROP COLUMN buss_3_4_on_off,
  DROP COLUMN buss_3_4_pre_post,
  DROP COLUMN buss_3_4_balance,
  DROP COLUMN buss_3_4_use_preset,
  DROP COLUMN buss_5_6_level,
  DROP COLUMN buss_5_6_on_off,
  DROP COLUMN buss_5_6_pre_post,
  DROP COLUMN buss_5_6_balance,
  DROP COLUMN buss_5_6_use_preset,
  DROP COLUMN buss_7_8_level,
  DROP COLUMN buss_7_8_on_off,
  DROP COLUMN buss_7_8_pre_post,
  DROP COLUMN buss_7_8_balance,
  DROP COLUMN buss_7_8_use_preset,
  DROP COLUMN buss_9_10_level,
  DROP COLUMN buss_9_10_on_off,
  DROP COLUMN buss_9_10_pre_post,
  DROP COLUMN buss_9_10_balance,
  DROP COLUMN buss_9_10_use_preset,
  DROP COLUMN buss_11_12_level,
  DROP COLUMN buss_11_12_on_off,
  DROP COLUMN buss_11_12_pre_post,
  DROP COLUMN buss_11_12_balance,
  DROP COLUMN buss_11_12_use_preset,
  DROP COLUMN buss_13_14_level,
  DROP COLUMN buss_13_14_on_off,
  DROP COLUMN buss_13_14_pre_post,
  DROP COLUMN buss_13_14_balance,
  DROP COLUMN buss_13_14_use_preset,
  DROP COLUMN buss_15_16_level,
  DROP COLUMN buss_15_16_on_off,
  DROP COLUMN buss_15_16_pre_post,
  DROP COLUMN buss_15_16_balance,
  DROP COLUMN buss_15_16_use_preset,
  DROP COLUMN buss_17_18_level,
  DROP COLUMN buss_17_18_on_off,
  DROP COLUMN buss_17_18_pre_post,
  DROP COLUMN buss_17_18_balance,
  DROP COLUMN buss_17_18_use_preset,
  DROP COLUMN buss_19_20_level,
  DROP COLUMN buss_19_20_on_off,
  DROP COLUMN buss_19_20_pre_post,
  DROP COLUMN buss_19_20_balance,
  DROP COLUMN buss_19_20_use_preset,
  DROP COLUMN buss_21_22_level,
  DROP COLUMN buss_21_22_on_off,
  DROP COLUMN buss_21_22_pre_post,
  DROP COLUMN buss_21_22_balance,
  DROP COLUMN buss_21_22_use_preset,
  DROP COLUMN buss_23_24_level,
  DROP COLUMN buss_23_24_on_off,
  DROP COLUMN buss_23_24_pre_post,
  DROP COLUMN buss_23_24_balance,
  DROP COLUMN buss_23_24_use_preset,
  DROP COLUMN buss_25_26_level,
  DROP COLUMN buss_25_26_on_off,
  DROP COLUMN buss_25_26_pre_post,
  DROP COLUMN buss_25_26_balance,
  DROP COLUMN buss_25_26_use_preset,
  DROP COLUMN buss_27_28_level,
  DROP COLUMN buss_27_28_on_off,
  DROP COLUMN buss_27_28_pre_post,
  DROP COLUMN buss_27_28_balance,
  DROP COLUMN buss_27_28_use_preset,
  DROP COLUMN buss_29_30_level,
  DROP COLUMN buss_29_30_on_off,
  DROP COLUMN buss_29_30_pre_post,
  DROP COLUMN buss_29_30_balance,
  DROP COLUMN buss_29_30_use_preset,
  DROP COLUMN buss_31_32_level,
  DROP COLUMN buss_31_32_on_off,
  DROP COLUMN buss_31_32_pre_post,
  DROP COLUMN buss_31_32_balance,
  DROP COLUMN buss_31_32_use_preset;

ALTER TABLE module_config
  RENAME COLUMN new_buss_1_2_level TO buss_1_2_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_1_2_on_off TO buss_1_2_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_1_2_pre_post TO buss_1_2_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_1_2_balance TO buss_1_2_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_3_4_level TO buss_3_4_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_3_4_on_off TO buss_3_4_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_3_4_pre_post TO buss_3_4_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_3_4_balance TO buss_3_4_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_5_6_level TO buss_5_6_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_5_6_on_off TO buss_5_6_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_5_6_pre_post TO buss_5_6_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_5_6_balance TO buss_5_6_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_7_8_level TO buss_7_8_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_7_8_on_off TO buss_7_8_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_7_8_pre_post TO buss_7_8_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_7_8_balance TO buss_7_8_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_9_10_level TO buss_9_10_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_9_10_on_off TO buss_9_10_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_9_10_pre_post TO buss_9_10_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_9_10_balance TO buss_9_10_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_11_12_level TO buss_11_12_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_11_12_on_off TO buss_11_12_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_11_12_pre_post TO buss_11_12_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_11_12_balance TO buss_11_12_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_13_14_level TO buss_13_14_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_13_14_on_off TO buss_13_14_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_13_14_pre_post TO buss_13_14_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_13_14_balance TO buss_13_14_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_15_16_level TO buss_15_16_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_15_16_on_off TO buss_15_16_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_15_16_pre_post TO buss_15_16_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_15_16_balance TO buss_15_16_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_17_18_level TO buss_17_18_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_17_18_on_off TO buss_17_18_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_17_18_pre_post TO buss_17_18_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_17_18_balance TO buss_17_18_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_19_20_level TO buss_19_20_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_19_20_on_off TO buss_19_20_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_19_20_pre_post TO buss_19_20_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_19_20_balance TO buss_19_20_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_21_22_level TO buss_21_22_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_21_22_on_off TO buss_21_22_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_21_22_pre_post TO buss_21_22_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_21_22_balance TO buss_21_22_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_23_24_level TO buss_23_24_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_23_24_on_off TO buss_23_24_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_23_24_pre_post TO buss_23_24_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_23_24_balance TO buss_23_24_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_25_26_level TO buss_25_26_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_25_26_on_off TO buss_25_26_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_25_26_pre_post TO buss_25_26_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_25_26_balance TO buss_25_26_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_27_28_level TO buss_27_28_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_27_28_on_off TO buss_27_28_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_27_28_pre_post TO buss_27_28_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_27_28_balance TO buss_27_28_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_29_30_level TO buss_29_30_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_29_30_on_off TO buss_29_30_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_29_30_pre_post TO buss_29_30_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_29_30_balance TO buss_29_30_balance;
ALTER TABLE module_config
  RENAME COLUMN new_buss_31_32_level TO buss_31_32_level;
ALTER TABLE module_config
  RENAME COLUMN new_buss_31_32_on_off TO buss_31_32_on_off;
ALTER TABLE module_config
  RENAME COLUMN new_buss_31_32_pre_post TO buss_31_32_pre_post;
ALTER TABLE module_config
  RENAME COLUMN new_buss_31_32_balance TO buss_31_32_balance;

ALTER TABLE buss_config
  ADD COLUMN console smallint NOT NULL DEFAULT 1 CHECK(console>=1 AND console<=4),
  ADD COLUMN mono boolean NOT NULL DEFAULT FALSE;

ALTER TABLE buss_config
  ADD CHECK(level>=-140 AND level<=10);

UPDATE module_config SET buss_1_2_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 1;
UPDATE module_config SET buss_3_4_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 2;
UPDATE module_config SET buss_5_6_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 3;
UPDATE module_config SET buss_7_8_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 4;
UPDATE module_config SET buss_9_10_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 5;
UPDATE module_config SET buss_11_12_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 6;
UPDATE module_config SET buss_13_14_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 7;
UPDATE module_config SET buss_15_16_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 8;
UPDATE module_config SET buss_17_18_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 9;
UPDATE module_config SET buss_19_20_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 10;
UPDATE module_config SET buss_21_22_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 11;
UPDATE module_config SET buss_23_24_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 12;
UPDATE module_config SET buss_25_26_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 13;
UPDATE module_config SET buss_27_28_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 14;
UPDATE module_config SET buss_29_30_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 15;
UPDATE module_config SET buss_31_32_pre_post = b.pre_level FROM buss_config b WHERE module_config.console = b.console AND b.number = 16;

ALTER TABLE buss_config
  DROP COLUMN pre_level;

CREATE TABLE routing_preset (
  mod_number smallint NOT NULL CHECK (mod_number>=1 AND mod_number<=128),
  mod_preset varchar(1) NOT NULL CHECK(mod_preset>='A' AND mod_preset<='H'),
  buss_1_2_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_1_2_level float NOT NULL DEFAULT 0 CHECK(buss_1_2_level>=-140 AND buss_1_2_level<=10),
  buss_1_2_on_off boolean NOT NULL DEFAULT TRUE,
  buss_1_2_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_1_2_balance smallint NOT NULL DEFAULT 512 CHECK(buss_1_2_balance>=0 AND buss_1_2_balance<=1023),
  buss_3_4_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_3_4_level float NOT NULL DEFAULT 0 CHECK(buss_3_4_level>=-140 AND buss_3_4_level<=10),
  buss_3_4_on_off boolean NOT NULL DEFAULT TRUE,
  buss_3_4_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_3_4_balance smallint NOT NULL DEFAULT 512 CHECK(buss_3_4_balance>=0 AND buss_3_4_balance<=1023),
  buss_5_6_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_5_6_level float NOT NULL DEFAULT 0 CHECK(buss_5_6_level>=-140 AND buss_5_6_level<=10),
  buss_5_6_on_off boolean NOT NULL DEFAULT TRUE,
  buss_5_6_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_5_6_balance smallint NOT NULL DEFAULT 512 CHECK(buss_5_6_balance>=0 AND buss_5_6_balance<=1023),
  buss_7_8_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_7_8_level float NOT NULL DEFAULT 0 CHECK(buss_7_8_level>=-140 AND buss_7_8_level<=10),
  buss_7_8_on_off boolean NOT NULL DEFAULT TRUE,
  buss_7_8_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_7_8_balance smallint NOT NULL DEFAULT 512 CHECK(buss_7_8_balance>=0 AND buss_7_8_balance<=1023),
  buss_9_10_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_9_10_level float NOT NULL DEFAULT 0 CHECK(buss_9_10_level>=-140 AND buss_9_10_level<=10),
  buss_9_10_on_off boolean NOT NULL DEFAULT TRUE,
  buss_9_10_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_9_10_balance smallint NOT NULL DEFAULT 512 CHECK(buss_9_10_balance>=0 AND buss_9_10_balance<=1023),
  buss_11_12_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_11_12_level float NOT NULL DEFAULT 0 CHECK(buss_11_12_level>=-140 AND buss_11_12_level<=10),
  buss_11_12_on_off boolean NOT NULL DEFAULT TRUE,
  buss_11_12_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_11_12_balance smallint NOT NULL DEFAULT 512 CHECK(buss_11_12_balance>=0 AND buss_11_12_balance<=1023),
  buss_13_14_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_13_14_level float NOT NULL DEFAULT 0 CHECK(buss_13_14_level>=-140 AND buss_13_14_level<=10),
  buss_13_14_on_off boolean NOT NULL DEFAULT TRUE,
  buss_13_14_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_13_14_balance smallint NOT NULL DEFAULT 512 CHECK(buss_13_14_balance>=0 AND buss_13_14_balance<=1023),
  buss_15_16_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_15_16_level float NOT NULL DEFAULT 0 CHECK(buss_15_16_level>=-140 AND buss_15_16_level<=10),
  buss_15_16_on_off boolean NOT NULL DEFAULT TRUE,
  buss_15_16_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_15_16_balance smallint NOT NULL DEFAULT 512 CHECK(buss_15_16_balance>=0 AND buss_15_16_balance<=1023),
  buss_17_18_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_17_18_level float NOT NULL DEFAULT 0 CHECK(buss_17_18_level>=-140 AND buss_17_18_level<=10),
  buss_17_18_on_off boolean NOT NULL DEFAULT TRUE,
  buss_17_18_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_17_18_balance smallint NOT NULL DEFAULT 512 CHECK(buss_17_18_balance>=0 AND buss_17_18_balance<=1023),
  buss_19_20_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_19_20_level float NOT NULL DEFAULT 0 CHECK(buss_19_20_level>=-140 AND buss_19_20_level<=10),
  buss_19_20_on_off boolean NOT NULL DEFAULT TRUE,
  buss_19_20_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_19_20_balance smallint NOT NULL DEFAULT 512 CHECK(buss_19_20_balance>=0 AND buss_19_20_balance<=1023),
  buss_21_22_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_21_22_level float NOT NULL DEFAULT 0 CHECK(buss_21_22_level>=-140 AND buss_21_22_level<=10),
  buss_21_22_on_off boolean NOT NULL DEFAULT TRUE,
  buss_21_22_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_21_22_balance smallint NOT NULL DEFAULT 512 CHECK(buss_21_22_balance>=0 AND buss_21_22_balance<=1023),
  buss_23_24_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_23_24_level float NOT NULL DEFAULT 0 CHECK(buss_23_24_level>=-140 AND buss_23_24_level<=10),
  buss_23_24_on_off boolean NOT NULL DEFAULT TRUE,
  buss_23_24_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_23_24_balance smallint NOT NULL DEFAULT 512 CHECK(buss_23_24_balance>=0 AND buss_23_24_balance<=1023),
  buss_25_26_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_25_26_level float NOT NULL DEFAULT 0 CHECK(buss_25_26_level>=-140 AND buss_25_26_level<=10),
  buss_25_26_on_off boolean NOT NULL DEFAULT TRUE,
  buss_25_26_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_25_26_balance smallint NOT NULL DEFAULT 512 CHECK(buss_25_26_balance>=0 AND buss_25_26_balance<=1023),
  buss_27_28_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_27_28_level float NOT NULL DEFAULT 0 CHECK(buss_27_28_level>=-140 AND buss_27_28_level<=10),
  buss_27_28_on_off boolean NOT NULL DEFAULT TRUE,
  buss_27_28_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_27_28_balance smallint NOT NULL DEFAULT 512 CHECK(buss_27_28_balance>=0 AND buss_27_28_balance<=1023),
  buss_29_30_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_29_30_level float NOT NULL DEFAULT 0 CHECK(buss_29_30_level>=-140 AND buss_29_30_level<=10),
  buss_29_30_on_off boolean NOT NULL DEFAULT TRUE,
  buss_29_30_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_29_30_balance smallint NOT NULL DEFAULT 512 CHECK(buss_29_30_balance>=0 AND buss_29_30_balance<=1023),
  buss_31_32_use_preset boolean NOT NULL DEFAULT FALSE,
  buss_31_32_level float NOT NULL DEFAULT 0 CHECK(buss_31_32_level>=-140 AND buss_31_32_level<=10),
  buss_31_32_on_off boolean NOT NULL DEFAULT TRUE,
  buss_31_32_pre_post boolean NOT NULL DEFAULT FALSE,
  buss_31_32_balance smallint NOT NULL DEFAULT 512 CHECK(buss_31_32_balance>=0 AND buss_31_32_balance<=1023),
  PRIMARY KEY(mod_number, mod_preset)
);

INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'A' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'B' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'C' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'D' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'E' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'F' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'G' FROM generate_series(1, 128);
INSERT INTO routing_preset (mod_number, mod_preset) SELECT *, 'H' FROM generate_series(1, 128);

ALTER TABLE module_config
  ADD COLUMN use_insert_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_gain_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_lc_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_phase_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_mono_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_eq_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_dyn_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN use_mod_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_1_2_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_3_4_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_5_6_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_7_8_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_9_10_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_11_12_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_13_14_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_15_16_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_17_18_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_19_20_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_21_22_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_23_24_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_25_26_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_27_28_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_29_30_use_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN buss_31_32_use_preset boolean NOT NULL DEFAULT FALSE;

CREATE TABLE buss_preset (
  pos smallint NOT NULL DEFAULT 9999,
  number smallint NOT NULL CHECK (number>=1 AND number<=1280) PRIMARY KEY,
  label varchar(32) NOT NULL
);

CREATE TABLE buss_preset_rows (
  number smallint NOT NULL CHECK(number>=1 AND number<=1280),
  buss smallint NOT NULL CHECK(buss>=1 AND buss<=16),
  use_preset boolean NOT NULL DEFAULT FALSE,
  level float NOT NULL DEFAULT 0.0,
  on_off boolean NOT NULL DEFAULT TRUE,
  PRIMARY KEY(number, buss)
);

CREATE TABLE monitor_buss_preset_rows (
  number smallint NOT NULL CHECK(number>=1 AND number<=1280),
  monitor_buss smallint NOT NULL CHECK(monitor_buss>=1 AND monitor_buss<=16),
  use_preset boolean[24] NOT NULL DEFAULT ARRAY[FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  on_off boolean[24] NOT NULL DEFAULT ARRAY[FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE],
  PRIMARY KEY(number, monitor_buss)
);

CREATE TABLE console_preset (
  pos smallint NOT NULL DEFAULT 9999,
  number smallint NOT NULL CHECK(number>=1 AND number<=32) PRIMARY KEY,
  label varchar(32) NOT NULL DEFAULT 'Preset',
  console1 boolean NOT NULL DEFAULT FALSE,
  console2 boolean NOT NULL DEFAULT FALSE,
  console3 boolean NOT NULL DEFAULT FALSE,
  console4 boolean NOT NULL DEFAULT FALSE,
  mod_preset varchar(1) DEFAULT 'A' CHECK(mod_preset>='A' AND mod_preset<='H'),
  buss_preset smallint CHECK(number>=1 AND number<=1280)
);

ALTER TABLE buss_preset_rows   ADD FOREIGN KEY (number)        REFERENCES buss_preset (number)    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE extern_src_config
  ADD COLUMN safe1 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe2 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe3 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe4 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe5 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe6 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe7 boolean NOT NULL DEFAULT TRUE,
  ADD COLUMN safe8 boolean NOT NULL DEFAULT TRUE;

CREATE OR REPLACE FUNCTION buss_preset_renumber() RETURNS integer AS $$
DECLARE
  _record RECORD;
  cnt_pos smallint;
BEGIN
  cnt_pos := 1;
  FOR _record IN ( SELECT number FROM buss_preset ORDER BY pos )
  LOOP
    UPDATE buss_preset SET pos = cnt_pos WHERE number = _record.number;
    cnt_pos := cnt_pos + 1;
  END LOOP;
  RETURN cnt_pos;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION routing_preset_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('routing_preset_changed', OLD.mod_number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('routing_preset_changed', NEW.mod_number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION buss_preset_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('buss_preset_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('buss_preset_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION buss_preset_rows_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('buss_preset_rows_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('buss_preset_rows_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION monitor_buss_preset_rows_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('monitor_buss_preset_rows_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('monitor_buss_preset_rows_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION console_preset_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES('console_preset_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('console_preset_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION console_preset_renumber() RETURNS integer AS $$
DECLARE
  _record RECORD;
  cnt_pos smallint;
BEGIN
  cnt_pos := 1;
  FOR _record IN ( SELECT number FROM console_preset ORDER BY pos )
  LOOP
    UPDATE console_preset SET pos = cnt_pos WHERE number = _record.number;
    cnt_pos := cnt_pos + 1;
  END LOOP;
  RETURN cnt_pos;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION src_config_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    UPDATE module_config SET source_a = 0 WHERE source_a = OLD.number+288;
    UPDATE module_config SET source_b = 0 WHERE source_b = OLD.number+288;
    UPDATE module_config SET source_c = 0 WHERE source_c = OLD.number+288;
    UPDATE module_config SET source_d = 0 WHERE source_d = OLD.number+288;
    UPDATE module_config SET source_e = 0 WHERE source_e = OLD.number+288;
    UPDATE module_config SET source_f = 0 WHERE source_f = OLD.number+288;
    UPDATE module_config SET source_g = 0 WHERE source_g = OLD.number+288;
    UPDATE module_config SET source_h = 0 WHERE source_h = OLD.number+288;
    UPDATE module_config SET insert_source = 0 WHERE insert_source = OLD.number+288;
    UPDATE dest_config SET source = 0 WHERE source = OLD.number+288;
    UPDATE dest_config SET mix_minus_source = 0 WHERE mix_minus_source = OLD.number+288;
    UPDATE extern_src_config SET ext1 = 0 WHERE ext1 = OLD.number+288;
    UPDATE extern_src_config SET ext2 = 0 WHERE ext2 = OLD.number+288;
    UPDATE extern_src_config SET ext3 = 0 WHERE ext3 = OLD.number+288;
    UPDATE extern_src_config SET ext4 = 0 WHERE ext4 = OLD.number+288;
    UPDATE extern_src_config SET ext5 = 0 WHERE ext5 = OLD.number+288;
    UPDATE extern_src_config SET ext6 = 0 WHERE ext6 = OLD.number+288;
    UPDATE extern_src_config SET ext7 = 0 WHERE ext7 = OLD.number+288;
    UPDATE extern_src_config SET ext8 = 0 WHERE ext8 = OLD.number+288;
    UPDATE monitor_buss_config SET default_selection = 0 WHERE default_selection = OLD.number+288;
    UPDATE talkback_config SET source = 0 WHERE source = OLD.number+288;
    INSERT INTO recent_changes (change, arguments) VALUES('src_config_changed', OLD.number::text);
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('src_config_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER routing_preset_notify            AFTER INSERT OR DELETE OR UPDATE ON routing_preset            FOR EACH ROW EXECUTE PROCEDURE routing_preset_changed();
CREATE TRIGGER buss_preset_notify               AFTER INSERT OR DELETE OR UPDATE ON buss_preset               FOR EACH ROW EXECUTE PROCEDURE buss_preset_changed();
CREATE TRIGGER buss_preset_rows_notify          AFTER INSERT OR DELETE OR UPDATE ON buss_preset_rows          FOR EACH ROW EXECUTE PROCEDURE buss_preset_rows_changed();
CREATE TRIGGER monitor_buss_preset_rows_notify  AFTER INSERT OR DELETE OR UPDATE ON monitor_buss_preset_rows  FOR EACH ROW EXECUTE PROCEDURE monitor_buss_preset_rows_changed();
CREATE TRIGGER console_preset_notify            AFTER INSERT OR DELETE OR UPDATE ON console_preset            FOR EACH ROW EXECUTE PROCEDURE console_preset_changed();

ALTER TABLE global_config
  DROP COLUMN routing_preset_1_label,
  DROP COLUMN routing_preset_2_label,
  DROP COLUMN routing_preset_3_label,
  DROP COLUMN routing_preset_4_label,
  DROP COLUMN routing_preset_5_label,
  DROP COLUMN routing_preset_6_label,
  DROP COLUMN routing_preset_7_label,
  DROP COLUMN routing_preset_8_label,
  DROP COLUMN use_module_defaults;

ALTER TABLE dest_config
  ADD COLUMN routing smallint NOT NULL DEFAULT 0 CHECK(routing>=0 AND routing<=3);

ALTER TABLE dest_config
  ALTER COLUMN output1_addr DROP NOT NULL,
  ALTER COLUMN output2_addr DROP NOT NULL;

ALTER TABLE src_config
  ALTER COLUMN input1_addr DROP NOT NULL,
  ALTER COLUMN input2_addr DROP NOT NULL;

ALTER TABLE src_config
  DROP CONSTRAINT src_config_input1_sub_ch_check1,
  DROP CONSTRAINT src_config_input2_sub_ch_check1;

ALTER TABLE src_config
  ADD CONSTRAINT src_config_input1_sub_ch_check1 CHECK (input1_sub_ch >= 0 AND input1_sub_ch <= 32),
  ADD CONSTRAINT src_config_input2_sub_ch_check1 CHECK (input2_sub_ch >= 0 AND input2_sub_ch <= 32);

COMMIT;
