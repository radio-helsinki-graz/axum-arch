BEGIN;

UPDATE functions SET rcv_type = 4 WHERE (func).type=4 AND (func).func>=525 AND (func).func<=532;

COMMIT;
