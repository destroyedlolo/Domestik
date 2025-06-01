--
-- Migrates Domestik1 data to Domestik2
--
--	History :
--	---------
--
-- 08/04/2025 - LF : Creation
--
-- domestik.probe_counter_archive
--                Table "domestik.probe_counter_archive"
--  Column  |           Type           | Collation | Nullable | Default 
-- ----------+--------------------------+-----------+----------+---------
-- host     | text                     |           | not null | 
-- probe    | text                     |           | not null | 
-- time     | timestamp with time zone |           | not null | 
-- increase | integer                  |           |          | 
--
-- GRANT SELECT ON TABLE domestik.probe_counter_archive TO domestik2;
--
--               Table "domestik2.electricity_counter_archive"
--    Column    |           Type           | Collation | Nullable | Default 
-- -------------+--------------------------+-----------+----------+---------
--  sample_time | timestamp with time zone |           |          | 
--  counter     | text                     |           | not null | 
--  figure      | text                     |           | not null | 
--  increase    | integer                  |           |          | 
-- 

-- externalize configuration
\i Configuration.sql

\qecho Migrate Consommation
\qecho --------------------

INSERT INTO :Domestik_Schema.electricity_counter_archive
	SELECT time, 'Consommation', regexp_replace(probe, '^consomation_', ''), increase 
	FROM domestik.probe_counter_archive
	WHERE probe LIKE 'consomation_%'
	ON CONFLICT DO NOTHING;

\qecho Migrate Production
\qecho ------------------

INSERT INTO :Domestik_Schema.electricity_counter_archive
	SELECT time, 'Production', regexp_replace(probe, '^production_', ''), increase
	FROM domestik.probe_counter_archive
	WHERE probe LIKE 'production_%'
	ON CONFLICT DO NOTHING;
