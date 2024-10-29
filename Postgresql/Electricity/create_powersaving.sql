--
-- Create table for electricity saving
--
--	History :
--	---------
--
-- 29/10/2014 - LF : First version
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_powersaving CASCADE;

\qecho Create electricity_powersaving schema
\qecho -------------------------------------

CREATE TABLE :Domestik_Schema.electricity_powersaving (
	figure TEXT NOT NULL,
	value INTEGER,
	sample_time TIMESTAMP WITH TIME ZONE
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_powersaving TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_powersaving IS 'Electricity power figures';
COMMENT ON COLUMN :Domestik_Schema.electricity_powersaving.figure IS 'Power''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_powersaving.value IS 'Power''s value';
COMMENT ON COLUMN :Domestik_Schema.electricity_powersaving.sample_time IS 'When the data sampled';

CREATE INDEX dmkppswrhp ON :Domestik_Schema.electricity_powersaving (figure);
CREATE INDEX dmkppswrhps ON :Domestik_Schema.electricity_powersaving (figure, sample_time);
