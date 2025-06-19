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
DROP TABLE IF EXISTS :Domestik_Schema.home_temperatures_archive CASCADE;

\qecho Create home_temperatures_archive schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.home_temperatures_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum REAL,
	maximum REAL,
	average REAL
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_temperatures_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_temperatures_archive IS 'Archiving of home temperatures';
COMMENT ON COLUMN :Domestik_Schema.home_temperatures_archive.figure IS 'Temperatures''s name';
COMMENT ON COLUMN :Domestik_Schema.home_temperatures_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkhtaf ON :Domestik_Schema.home_temperatures_archive (figure);
CREATE INDEX dmkhtafs ON :Domestik_Schema.home_temperatures_archive (figure, sample_time);
