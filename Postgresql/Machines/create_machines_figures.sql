--
-- Create table for Machines' figures
--
--	History :
--	---------
--
-- 10/06/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.machines_figures CASCADE;

\qecho Create machines_figures table
\qecho -----------------------------

CREATE TABLE :Domestik_Schema.machines_figures (
	sample_time TIMESTAMP WITH TIME ZONE,
	name TEXT NOT NULL,
	figure TEXT NOT NULL,
	minimum FLOAT,
	maximum FLOAT,
	average FLOAT
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.machines_figures TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.machines_figures IS 'Machines'' figures';
COMMENT ON COLUMN :Domestik_Schema.machines_figures.name IS 'Machine''s name';
COMMENT ON COLUMN :Domestik_Schema.machines_figures.sample_time IS 'When the data sampled';

CREATE INDEX dmkmflf ON :Domestik_Schema.machines_figures (name);
CREATE INDEX dmkmflfs ON :Domestik_Schema.machines_figures (name, sample_time);
