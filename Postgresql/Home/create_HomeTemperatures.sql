--
-- Create table for home figures
--
--
--	History :
--	---------
--
-- 27/10/2044 - LF : First version
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

COMMENT ON TABLE :Domestik_Schema.home_temperatures IS 'Home''s temperatures';
COMMENT ON COLUMN :Domestik_Schema.home_temperatures.figure IS 'Figure''s name';
COMMENT ON COLUMN :Domestik_Schema.home_figures.sample_time IS 'When the data sampled';

CREATE INDEX dmkhff ON :Domestik_Schema.home_temperatures (figure);
CREATE INDEX dmkhffs ON :Domestik_Schema.home_temperatures (figure, sample_time);
