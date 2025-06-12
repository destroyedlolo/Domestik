--
-- Create table for UPS figures
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
DROP TABLE IF EXISTS :Domestik_Schema.UPS CASCADE;

\qecho Create UPS_archives schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.UPS (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum INTEGER,
	maximum INTEGER,
	average INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.UPS TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.UPS IS 'UPS'' figures';
COMMENT ON COLUMN :Domestik_Schema.UPS.figure IS 'figure''s name';
COMMENT ON COLUMN :Domestik_Schema.UPS.sample_time IS 'When the data sampled';

CREATE INDEX dmkuf ON :Domestik_Schema.UPS (figure);
CREATE INDEX dmkufs ON :Domestik_Schema.UPS (figure, sample_time);
