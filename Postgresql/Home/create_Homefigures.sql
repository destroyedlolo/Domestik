--
-- Create table for home figures
--
--
--	History :
--	---------
--
-- 27/10/2024 - LF : First version
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.home_figures CASCADE;

\qecho Create home_figures schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.home_figures (
	sample_time TIMESTAMP WITH TIME ZONE,
	probe TEXT NOT NULL,
	kind TEXT NOT NULL,
	value REAL
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_figures TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_figures IS 'Home''s figures';
COMMENT ON COLUMN :Domestik_Schema.home_figures.sample_time IS 'When the data sampled';
COMMENT ON COLUMN :Domestik_Schema.home_figures.probe IS 'Probe''s name';

CREATE INDEX dmkhff ON :Domestik_Schema.home_figures (figure);
CREATE INDEX dmkhffs ON :Domestik_Schema.home_figures (figure, sample_time);
