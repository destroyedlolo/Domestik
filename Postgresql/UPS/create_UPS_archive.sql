--
-- Create table for UPS figures archiving
--
--	History :
--	---------
--
-- 15/06/2025 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.UPS_archive CASCADE;

\qecho Create UPS_archive_archives schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.UPS_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum INTEGER,
	maximum INTEGER,
	average FLOAT
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.UPS_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.UPS_archive IS 'UPS'' figures archive';
COMMENT ON COLUMN :Domestik_Schema.UPS_archive.figure IS 'figure''s name';
COMMENT ON COLUMN :Domestik_Schema.UPS_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkuaf ON :Domestik_Schema.UPS_archive (figure);
CREATE INDEX dmkuafs ON :Domestik_Schema.UPS_archive (figure, sample_time);
