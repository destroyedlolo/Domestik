--
-- Create table for electricity powersaving archiving
--
--	History :
--	---------
--
-- 14/04/2025 - LF : First version
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_powersaving_archive CASCADE;

\qecho Create electricity_powersaving_archive
\qecho --------------------------------------

CREATE TABLE :Domestik_Schema.electricity_powersaving_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value INTEGER,
	UNIQUE(sample_time, figure)
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_powersaving_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_powersaving_archive IS 'Power saving''s archived statistic';
COMMENT ON COLUMN :Domestik_Schema.electricity_powersaving_archive.figure IS 'Power saving''s figure';
COMMENT ON COLUMN :Domestik_Schema.electricity_powersaving_archive.value IS 'Power saving during the time period';
COMMENT ON COLUMN :Domestik_Schema.electricity_powersaving_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkpsacf ON :Domestik_Schema.electricity_powersaving_archive (figure);
CREATE INDEX dmkpsas ON :Domestik_Schema.electricity_powersaving_archive (sample_time);

