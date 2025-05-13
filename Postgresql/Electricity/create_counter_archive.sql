--
-- Create table for electricity counter archiving
--
--	History :
--	---------
--
-- 26/10/2014 - LF : First version
-- 12/08/2015 - Simplify archive table
-- 24/03/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_counter_archive CASCADE;

\qecho Create electricity_counter_archive
\qecho ----------------------------------

CREATE TABLE :Domestik_Schema.electricity_counter_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	counter TEXT NOT NULL,
	figure TEXT NOT NULL,
	increase INTEGER,
	UNIQUE(sample_time, counter, figure)
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_counter_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_counter_archive IS 'Counter''s archived statistic';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter_archive.counter IS 'Counter''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter_archive.figure IS 'Counter''s figure';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter_archive.increase IS 'Counter increasing during the time period';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkpcntac ON :Domestik_Schema.electricity_counter_archive (counter);
CREATE INDEX dmkpcntacf ON :Domestik_Schema.electricity_counter_archive (counter, figure);
CREATE INDEX dmkpcntas ON :Domestik_Schema.electricity_counter_archive (sample_time);

