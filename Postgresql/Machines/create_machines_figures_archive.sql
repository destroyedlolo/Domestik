--
-- Create table for Machines' figures archive
--
--	History :
--	---------
--
-- 12/06/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.machines_figures_archive CASCADE;

\qecho Create machines_figures_archive table
\qecho -----------------------------

CREATE TABLE :Domestik_Schema.machines_figures_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	name TEXT NOT NULL,
	figure TEXT NOT NULL,
	minimum FLOAT,
	maximum FLOAT,
	average FLOAT
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.machines_figures_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.machines_figures_archive IS 'Machines'' figures archive';
COMMENT ON COLUMN :Domestik_Schema.machines_figures_archive.name IS 'Machine''s name';
COMMENT ON COLUMN :Domestik_Schema.machines_figures_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkmflfa ON :Domestik_Schema.machines_figures_archive (name);
CREATE INDEX dmkmflfas ON :Domestik_Schema.machines_figures_archive (name, sample_time);
