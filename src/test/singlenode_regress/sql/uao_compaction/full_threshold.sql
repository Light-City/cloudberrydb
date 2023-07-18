-- @Description Tests that that full vacuum is ignoring the threshold guc value.

CREATE TABLE uao_full_threshold (a INT, b INT, c CHAR(128)) WITH (appendonly=true);
CREATE INDEX uao_full_threshold_index ON uao_full_threshold(b);
INSERT INTO uao_full_threshold SELECT i as a, 1 as b, 'hello world' as c FROM generate_series(1, 100) AS i;
ANALYZE uao_full_threshold;

VACUUM FULL uao_full_threshold;
DELETE FROM uao_full_threshold WHERE a < 4;
SET gp_appendonly_compaction_threshold=100;
VACUUM FULL uao_full_threshold;
