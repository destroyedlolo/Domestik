--
-- Create table for Machines' swap usage
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
DROP TABLE IF EXISTS :Domestik_Schema.machines_swap CASCADE;

\qecho Create machines_swap table
\qecho -----------------------------

CREATE TABLE :Domestik_Schema.machines_swap (
	sample_time TIMESTAMP WITH TIME ZONE,
	name TEXT NOT NULL,
	minimum FLOAT,
	maximum FLOAT,
	average FLOAT
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.machines_swap TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.machines_swap IS 'Computers'' cpu load';
COMMENT ON COLUMN :Domestik_Schema.machines_swap.name IS 'Machine''s name';
COMMENT ON COLUMN :Domestik_Schema.machines_swap.sample_time IS 'When the data sampled';

CREATE INDEX dmkmslf ON :Domestik_Schema.machines_swap (name);
CREATE INDEX dmkmslfs ON :Domestik_Schema.machines_swap (name, sample_time);
