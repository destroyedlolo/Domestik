--
-- Create table for Home Temperature figures
--
--	History :
--	---------
--
-- 26/10/2014 - LF : First version
-- 12/08/2015 - LF : Simplify archive table
-- 19/10/2024 - LF : recreation for V2
-- 11/05/2025 - LF : creation for temperature
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.home_temperatures CASCADE;

\qecho Create home_temperatures schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.home_temperatures (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value REAL
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_temperatures TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_temperatures IS 'Home Temperatures figures';
COMMENT ON COLUMN :Domestik_Schema.home_temperatures.figure IS 'Temperature''s name';
COMMENT ON COLUMN :Domestik_Schema.home_temperatures.value IS 'Temperature''s value';
COMMENT ON COLUMN :Domestik_Schema.home_temperatures.sample_time IS 'When the data sampled';

CREATE INDEX dmkhtf ON :Domestik_Schema.home_temperatures (figure);
CREATE INDEX dmkhtfs ON :Domestik_Schema.home_temperatures (figure, sample_time);
