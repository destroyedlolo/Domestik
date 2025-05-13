--
-- Create table for electricity power archiving
--
--	History :
--	---------
--
-- 01/04/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_power_archive CASCADE;

\qecho Create electricity_power_archive schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.electricity_power_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum INTEGER,
	maximum INTEGER,
	average INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_power_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_power_archive IS 'Electricity power archived figures';
COMMENT ON COLUMN :Domestik_Schema.electricity_power_archive.figure IS 'Power''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_power_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkppwrahp ON :Domestik_Schema.electricity_power_archive (figure);
CREATE INDEX dmkppwrahps ON :Domestik_Schema.electricity_power_archive (figure, sample_time);
