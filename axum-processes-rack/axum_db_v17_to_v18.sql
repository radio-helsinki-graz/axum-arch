BEGIN;

-- SRC_CONFIG TRIGGER NOT FOR POSITION (TO MUCH DELAY IN NOTIFIES)
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
  ELSIF TG_OP = 'UPDATE' THEN
    IF (OLD.number <> NEW.number OR
       OLD.label <> NEW.label OR
       OLD.input1_addr <> NEW.input1_addr OR
       OLD.input1_sub_ch <> NEW.input1_sub_ch OR
       OLD.input2_addr <> NEW.input2_addr OR
       OLD.input2_sub_ch <> NEW.input2_sub_ch OR
       OLD.input_phantom <> NEW.input_phantom OR
       OLD.input_pad <> NEW.input_pad OR
       OLD.input_gain <> NEW.input_gain OR
       OLD.redlight1 <> NEW.redlight1 OR
       OLD.redlight2 <> NEW.redlight2 OR
       OLD.redlight3 <> NEW.redlight3 OR
       OLD.redlight4 <> NEW.redlight4 OR
       OLD.redlight5 <> NEW.redlight5 OR
       OLD.redlight6 <> NEW.redlight6 OR
       OLD.redlight7 <> NEW.redlight7 OR
       OLD.redlight8 <> NEW.redlight8 OR
       OLD.monitormute1 <> NEW.monitormute1 OR
       OLD.monitormute2 <> NEW.monitormute2 OR
       OLD.monitormute3 <> NEW.monitormute3 OR
       OLD.monitormute4 <> NEW.monitormute4 OR
       OLD.monitormute5 <> NEW.monitormute5 OR
       OLD.monitormute6 <> NEW.monitormute6 OR
       OLD.monitormute7 <> NEW.monitormute7 OR
       OLD.monitormute8 <> NEW.monitormute8 OR
       OLD.monitormute9 <> NEW.monitormute9 OR
       OLD.monitormute10 <> NEW.monitormute10 OR
       OLD.monitormute11 <> NEW.monitormute11 OR
       OLD.monitormute12 <> NEW.monitormute12 OR
       OLD.monitormute13 <> NEW.monitormute13 OR
       OLD.monitormute14 <> NEW.monitormute14 OR
       OLD.monitormute15 <> NEW.monitormute15 OR
       OLD.monitormute16 <> NEW.monitormute16 OR
       OLD.default_src_preset <> NEW.default_src_preset OR
       (OLD.default_src_preset IS NULL AND NEW.default_src_preset IS NOT NULL) OR
       (OLD.default_src_preset IS NOT NULL AND NEW.default_src_preset IS NULL) OR
       OLD.start_trigger <> NEW.start_trigger OR
       OLD.stop_trigger <> NEW.stop_trigger OR
       OLD.pool1 <> NEW.pool1 OR
       OLD.pool2 <> NEW.pool2 OR
       OLD.pool3 <> NEW.pool3 OR
       OLD.pool4 <> NEW.pool4 OR
       OLD.pool5 <> NEW.pool5 OR
       OLD.pool6 <> NEW.pool6 OR
       OLD.pool7 <> NEW.pool7 OR
       OLD.pool8 <> NEW.pool8 OR
       OLD.related_dest <> NEW.related_dest)
    THEN
      INSERT INTO recent_changes (change, arguments) VALUES('src_config_changed', NEW.number::text);
    END IF;
  ELSE
    INSERT INTO recent_changes (change, arguments) VALUES('src_config_changed', NEW.number::text);
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

COMMIT;
