--
-- Migrates Domestik1 data to Domestik2
--
--	History :
--	---------
--
-- 19/10/2024 - LF : Creation
--

-- externalize configuration
\i Configuration.sql

\qecho Migrate Consommation
\qecho --------------------

INSERT INTO :Domestik_Schema.electricity_counter
	SELECT 'Consommation', regexp_replace(probe, '^consomation_', ''), value, sample_time
	FROM domestik.probe_counter
	WHERE probe LIKE 'consomation_%';

\qecho Migrate Consommation
\qecho --------------------

INSERT INTO :Domestik_Schema.electricity_counter
	SELECT 'Production', regexp_replace(probe, '^production_', ''), value, sample_time
	FROM domestik.probe_counter
	WHERE probe LIKE 'production_%';
