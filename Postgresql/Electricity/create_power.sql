--
-- Create table for electricity counter
--
--	History :
--	---------
--
-- 26/10/2014 - LF : First version
-- 12/08/2015 - LF : Simplify archive table
-- 19/10/2024 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_power CASCADE;

\qecho Create electricity_power schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.electricity_power (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_power TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_power IS 'Electricity power figures';
COMMENT ON COLUMN :Domestik_Schema.electricity_power.figure IS 'Power''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_power.value IS 'Power''s value';
COMMENT ON COLUMN :Domestik_Schema.electricity_power.sample_time IS 'When the data sampled';

CREATE INDEX dmkppwrhp ON :Domestik_Schema.electricity_power (figure);
CREATE INDEX dmkppwrhps ON :Domestik_Schema.electricity_power (figure, sample_time);
