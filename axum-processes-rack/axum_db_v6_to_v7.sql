BEGIN;

INSERT INTO functions VALUES ('(4,,369)', 'Control 1 mode AGC threshold', 3, 3);
INSERT INTO functions VALUES ('(4,,370)', 'Control 2 mode AGC threshold', 3, 3);
INSERT INTO functions VALUES ('(4,,371)', 'Control 3 mode AGC threshold', 3, 3);
INSERT INTO functions VALUES ('(4,,372)', 'Control 4 mode AGC threshold', 3, 3);
INSERT INTO functions VALUES ('(0,,201)', 'AGC threshold', 2, 4);

INSERT INTO functions VALUES ('(4,,373)', 'Control 1 mode downward expander threshold', 3, 3);
INSERT INTO functions VALUES ('(4,,374)', 'Control 2 mode downward expander threshold', 3, 3);
INSERT INTO functions VALUES ('(4,,375)', 'Control 3 mode downward expander threshold', 3, 3);
INSERT INTO functions VALUES ('(4,,376)', 'Control 4 mode downward expander threshold', 3, 3);
INSERT INTO functions VALUES ('(0,,202)', 'Downward expander threshold', 2, 4);

UPDATE functions SET name = 'AGC amount' WHERE (func).type = 0 AND (func).func = 59;

UPDATE functions SET name = 'Control 1 mode AGC amount' WHERE (func).type = 4 AND (func).func = 53;
UPDATE functions SET name = 'Control 2 mode AGC amount' WHERE (func).type = 4 AND (func).func = 118;
UPDATE functions SET name = 'Control 3 mode AGC amount' WHERE (func).type = 4 AND (func).func = 183;
UPDATE functions SET name = 'Control 4 mode AGC amount' WHERE (func).type = 4 AND (func).func = 248;

COMMIT;
