--
-- Create table for Machines' memory usage
--
--	History :
--	---------
--
-- 07/06/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.machines_memory CASCADE;

\qecho Create machines_memory table
\qecho -----------------------------

CREATE TABLE :Domestik_Schema.machines_memory (
	sample_time TIMESTAMP WITH TIME ZONE,
	name TEXT NOT NULL,
	minimum FLOAT,
	maximum FLOAT,
	average FLOAT
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.machines_memory TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.machines_memory IS 'Computers'' cpu load';
COMMENT ON COLUMN :Domestik_Schema.machines_memory.name IS 'Machine''s name';
COMMENT ON COLUMN :Domestik_Schema.machines_memory.sample_time IS 'When the data sampled';

CREATE INDEX dmkmmlf ON :Domestik_Schema.machines_memory (name);
CREATE INDEX dmkmmlfs ON :Domestik_Schema.machines_memory (name, sample_time);
