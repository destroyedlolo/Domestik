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
DROP TABLE IF EXISTS :Domestik_Schema.home_figures CASCADE;
DROP TYPE IF EXISTS :Domestik_Schema.home_ekind;

\qecho Create home_figures schema
\qecho --------------------------

CREATE TYPE :Domestik_Schema.home_ekind AS ENUM('Temperature', 'Humidity');
COMMENT ON TYPE :Domestik_Schema.home_ekind IS 'Kind of stored data';

CREATE TABLE :Domestik_Schema.home_figures (
	figure TEXT NOT NULL,
	kind :Domestik_Schema.home_ekind NOT NULL,
	value REAL,
	sample_time TIMESTAMP WITH TIME ZONE
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_figures TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_figures IS 'Home''s environmentals';
COMMENT ON COLUMN :Domestik_Schema.home_figures.figure IS 'Figure''s name';
COMMENT ON COLUMN :Domestik_Schema.home_figures.sample_time IS 'When the data sampled';

CREATE INDEX dmkhff ON :Domestik_Schema.home_figures (figure);
CREATE INDEX dmkhffs ON :Domestik_Schema.home_figures (figure, sample_time);
