--
-- Create table for temperatures archiving
--
--	History :
--	---------
--
-- 13/05/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.home_temperature_archives CASCADE;

\qecho Create home_temperature_archives schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.home_temperature_archives (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum INTEGER,
	maximum INTEGER,
	average INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_temperature_archives TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_temperature_archives IS 'Archiving of home temperatures';
COMMENT ON COLUMN :Domestik_Schema.home_temperature_archives.figure IS 'Temperatures''s name';
COMMENT ON COLUMN :Domestik_Schema.home_temperature_archives.sample_time IS 'When the data sampled';

CREATE INDEX dmkhtaf ON :Domestik_Schema.home_temperature_archives (figure);
CREATE INDEX dmkhtafs ON :Domestik_Schema.home_temperature_archives (figure, sample_time);
