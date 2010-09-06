BEGIN;

  ALTER TABLE global_config
    ADD startup_state boolean NOT NULL DEFAULT FALSE;

  ALTER TABLE src_config
    ADD COLUMN use_mod_preset boolean NOT NULL DEFAULT FALSE,
    ADD COLUMN mod_on_off boolean NOT NULL DEFAULT FALSE,
    ADD COLUMN mod_lvl float NOT NULL DEFAULT -140;

COMMIT;
