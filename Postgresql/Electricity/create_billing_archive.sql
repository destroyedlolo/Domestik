--
-- Create table for electricity billing archive
--
--	History :
--	---------
--
-- 15/04/2025 - LF : First version
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_billing_archive CASCADE;

\qecho Create electricity_powersaving schema
\qecho -------------------------------------

CREATE TABLE :Domestik_Schema.electricity_billing_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value float
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_billing_archive TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_billing_archive IS 'Electricity billing archive';
COMMENT ON COLUMN :Domestik_Schema.electricity_billing_archive.figure IS 'Billing''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_billing_archive.value IS 'Billing''s value';
COMMENT ON COLUMN :Domestik_Schema.electricity_billing_archive.sample_time IS 'When the data sampled';

CREATE INDEX dmkbahp ON :Domestik_Schema.electricity_billing_archive (figure);
CREATE INDEX dmkbahps ON :Domestik_Schema.electricity_billing_archive (figure, sample_time);
