ALTER TABLE src_config
  ADD COLUMN use_phase_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN phase_on_off boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN phase smallint NOT NULL DEFAULT 3 CHECK(phase>=0 AND phase<=3),
  ADD COLUMN use_mono_preset boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN mono_on_off boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN mono smallint NOT NULL DEFAULT 3 CHECK(mono>=0 AND mono<=3);

ALTER TABLE module_config
  ADD COLUMN phase smallint NOT NULL DEFAULT 3 CHECK(phase>=0 AND phase<=3),
  ADD COLUMN phase_on_off boolean NOT NULL DEFAULT FALSE,
  ADD COLUMN mono smallint NOT NULL DEFAULT 3 CHECK(mono>=0 AND mono<=3),
  ADD COLUMN mono_on_off boolean NOT NULL DEFAULT FALSE;

ALTER TABLE functions
  ADD COLUMN pos smallint NOT NULL DEFAULT 9999;
