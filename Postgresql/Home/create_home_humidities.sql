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
DROP TABLE IF EXISTS :Domestik_Schema.home_humidities CASCADE;

\qecho Create home_humidities schema
\qecho -------------------------------

CREATE TABLE :Domestik_Schema.home_humidities (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.home_humidities TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.home_humidities IS 'Humidity figures';
COMMENT ON COLUMN :Domestik_Schema.home_humidities.figure IS 'Humidity''s name';
COMMENT ON COLUMN :Domestik_Schema.home_humidities.value IS 'Humidity''s value';
COMMENT ON COLUMN :Domestik_Schema.home_humidities.sample_time IS 'When the data sampled';

CREATE INDEX dmkhmdhp ON :Domestik_Schema.home_humidities (figure);
CREATE INDEX dmkhmdhps ON :Domestik_Schema.home_humidities (figure, sample_time);
