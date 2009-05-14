-- On an empty PostgreSQL installation, execute the following to
-- create and load the DB for use with the axum software:
-- 
--  $ createuser -U postgres -S -D -R axum
--  $ createdb -U postgres axum -O axum
--  $ psql -U axum <axum-database.sql


-- General TODO list (not very important)
--  - Operator classes for the custom types
--  - More sanity checking (NULL values on custom types)
--  - Foreign key: configuration(func) -> functions(func)
--  - db_to_position or position_to_db table
--  - more triggers


CREATE LANGUAGE plpgsql;



-- T Y P E S

CREATE TYPE function_number AS (
  type integer,
  seq integer,
  func integer
);

CREATE TYPE mambanet_data AS (
  int integer,
  fl float,
  bits bit varying(64),
  str varchar(64)
);

CREATE TYPE mambanet_minmax AS (
  int integer,
  fl float
);

CREATE TYPE mambanet_unique_id AS (
  man smallint,
  prod smallint,
  id smallint
);




-- T A B L E S

CREATE TABLE configuration (
  addr integer NOT NULL,
  object integer NOT NULL,
  func function_number NOT NULL,
  PRIMARY KEY(addr, object)
);

CREATE TABLE defaults (
  addr integer NOT NULL,
  object integer NOT NULL,
  data mambanet_data NOT NULL,
  PRIMARY KEY(addr, object)
);

CREATE TABLE templates (
  man_id smallint NOT NULL,
  prod_id smallint NOT NULL,
  firm_major smallint NOT NULL,
  "desc" varchar(32) NOT NULL,
  services smallint NOT NULL CHECK (services >= 0 AND services <= 3),
  sensor_type smallint NOT NULL CHECK(sensor_type >= 0 AND sensor_type <= 6),
  sensor_size smallint CHECK(sensor_size >= 0 AND sensor_size <= 64),
  sensor_min mambanet_minmax,
  sensor_max mambanet_minmax,
  actuator_type smallint NOT NULL CHECK(actuator_type >= 0 AND actuator_type <= 6),
  actuator_size smallint CHECK(actuator_size >= 0 AND actuator_size <= 64),
  actuator_min mambanet_minmax,
  actuator_max mambanet_minmax,
  actuator_def mambanet_minmax,
  PRIMARY KEY(man_id, prod_id, firm_major)
);

CREATE TABLE functions (
  func function_number NOT NULL,
  name varchar(64) NOT NULL,
  rcv_type smallint NOT NULL CHECK(rcv_type >= 0 AND rcv_type <= 6),
  xmt_type smallint NOT NULL CHECK(xmt_type >= 0 AND xmt_type <= 6)
);
CREATE UNIQUE INDEX functions_unique ON functions (rcv_type, xmt_type, ((func).type), ((func).seq), ((func).func));

CREATE TABLE addresses (
  addr integer NOT NULL PRIMARY KEY,
  name VARCHAR(32),
  id mambanet_unique_id NOT NULL,
  engine_addr integer NOT NULL,
  services smallint NOT NULL,
  active boolean NOT NULL DEFAULT FALSE,
  parent mambanet_unique_id NOT NULL DEFAULT ROW(0,0,0),
  setname boolean NOT NULL DEFAULT FALSE,
  refresh boolean NOT NULL DEFAULT FALSE,
  firstseen bigint NOT NULL DEFAULT DATE_PART('epoch', NOW()),
  lastseen bigint NOT NULL DEFAULT DATE_PART('epoch', NOW()),
  addr_requests integer NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX addresses_unique_id ON addresses (((id).man), ((id).prod), ((id).id));

CREATE TABLE recent_changes (
  change varchar(32) NOT NULL,
  arguments varchar(64) NOT NULL,
  timestamp timestamp NOT NULL DEFAULT NOW(),
  pid integer NOT NULL DEFAULT pg_backend_pid()
);




-- F O R E I G N   K E Y S

ALTER TABLE configuration ADD FOREIGN KEY (addr) REFERENCES addresses (addr);
ALTER TABLE defaults      ADD FOREIGN KEY (addr) REFERENCES addresses (addr);




-- T R I G G E R S

CREATE OR REPLACE FUNCTION notify_changes() RETURNS trigger AS $$
BEGIN
  -- remove changes older than an hour
  DELETE FROM recent_changes WHERE timestamp < (NOW() - INTERVAL '1 hour');
  -- send notify
  NOTIFY change;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER recent_changes_notify AFTER INSERT ON recent_changes FOR EACH STATEMENT EXECUTE PROCEDURE notify_changes();


CREATE OR REPLACE FUNCTION addresses_changed() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO recent_changes (change, arguments) VALUES ('address_removed', OLD.addr::text);
  ELSIF TG_OP = 'UPDATE' THEN
    IF (OLD.id).man <> (NEW.id).man OR (OLD.id).prod <> (NEW.id).prod OR (OLD.id).id <> (NEW.id).id THEN
      RAISE EXCEPTION 'Changing addresses.id is not allowed';
    END IF;
    IF OLD.engine_addr <> NEW.engine_addr THEN
      INSERT INTO recent_changes (change, arguments) VALUES ('address_set_engine', NEW.addr::text);
    END IF;
    IF OLD.addr <> NEW.addr THEN
      INSERT INTO recent_changes (change, arguments) VALUES ('address_set_addr', OLD.addr::text||' '||NEW.addr::text);
    END IF;
    IF OLD.name <> NEW.name THEN
      UPDATE addresses SET setname = TRUE WHERE addr = NEW.addr;
    END IF;
    IF OLD.setname = FALSE AND NEW.setname = TRUE THEN
      INSERT INTO recent_changes (change, arguments) VALUES ('address_set_name', NEW.addr::text);
    END IF;
    IF OLD.refresh = FALSE AND NEW.refresh = TRUE THEN
      INSERT INTO recent_changes (change, arguments) VALUES ('address_refresh', NEW.addr::text);
    END IF;
  END IF;
  RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER addresses_change_notify AFTER DELETE OR UPDATE ON addresses FOR EACH ROW EXECUTE PROCEDURE addresses_changed();


