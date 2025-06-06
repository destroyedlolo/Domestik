--
-- Create table for Machines' cpuload
--
--	History :
--	---------
--
-- 06/06/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.machines_cpuload CASCADE;

\qecho Create machines_figures table
\qecho -----------------------------

CREATE TABLE :Domestik_Schema.machines_cpuload (
	sample_time TIMESTAMP WITH TIME ZONE,
	name TEXT NOT NULL,
	minimum FLOAT,
	maximum FLOAT,
	average FLOAT
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.machines_cpuload TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.machines_cpuload IS 'Computers'' cpu load';
COMMENT ON COLUMN :Domestik_Schema.machines_cpuload.name IS 'Machine''s name';
COMMENT ON COLUMN :Domestik_Schema.machines_cpuload.sample_time IS 'When the data sampled';

CREATE INDEX dmkmclf ON :Domestik_Schema.machines_cpuload (name);
CREATE INDEX dmkmclfs ON :Domestik_Schema.machines_cpuload (name, sample_time);
