--
-- Migrates Domestik1 data to Domestik2
--
--	History :
--	---------
--
-- 25/10/2024 - LF : Creation
--

-- externalize configuration
\i Configuration.sql

\qecho Migrate Consommation
\qecho --------------------

INSERT INTO :Domestik_Schema.electricity_power
	SELECT 'Consommation', value, sample_time
	FROM domestik.probe_hardware
	WHERE host='EDF' and probe='consomation_Puissance';

\qecho Migrate Production
\qecho ------------------

INSERT INTO :Domestik_Schema.electricity_power
	SELECT 'Production', value, sample_time
	FROM domestik.probe_hardware
	WHERE host='EDF' and probe='production_Puissance';
