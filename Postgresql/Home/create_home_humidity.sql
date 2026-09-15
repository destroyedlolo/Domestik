--
-- Create table for humidity figure
--
--	History :
--	---------
--
-- 15/09/2026 - LF : First version
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.home_humidity CASCADE;

\qecho Create home_humidity schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.home_humidity (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_humidity TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_humidity IS 'Humidity figures';
COMMENT ON COLUMN :Domestik_Schema.home_humidity.figure IS 'Humidity''s name';
COMMENT ON COLUMN :Domestik_Schema.home_humidity.value IS 'Humidity''s value';
COMMENT ON COLUMN :Domestik_Schema.home_humidity.sample_time IS 'When the data sampled';

CREATE INDEX dmkhmdhp ON :Domestik_Schema.home_humidity (figure);
CREATE INDEX dmkhmdhps ON :Domestik_Schema.home_humidity (figure, sample_time);
