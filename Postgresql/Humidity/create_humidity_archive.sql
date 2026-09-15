--
-- Create table for humidity archiving
--
--	History :
--	---------
--
-- 15/09/2026 - LF : creation
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.humidity_archive CASCADE;

\qecho Create humidity_archive schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.humidity_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum INTEGER,
	maximum INTEGER,
	average INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.humidity_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.humidity_archive IS 'Humidity archived figures';
COMMENT ON COLUMN :Domestik_Schema.humidity_archive.figure IS 'Humidity''s name';
COMMENT ON COLUMN :Domestik_Schema.humidity_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkhmdahp ON :Domestik_Schema.humidity_archive (figure);
CREATE INDEX dmkhmdahps ON :Domestik_Schema.humidity_archive (figure, sample_time);
