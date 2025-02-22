--
-- Create table for electricity billing
--
--	History :
--	---------
--
-- 01/11/2014 - LF : First version
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_billing CASCADE;

\qecho Create electricity_powersaving schema
\qecho -------------------------------------

CREATE TABLE :Domestik_Schema.electricity_billing (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value float
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_billing TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_billing IS 'Electricity billing history';
COMMENT ON COLUMN :Domestik_Schema.electricity_billing.figure IS 'Billing''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_billing.value IS 'Power''s value';
COMMENT ON COLUMN :Domestik_Schema.electricity_billing.sample_time IS 'When the data sampled';

CREATE INDEX dmkbhp ON :Domestik_Schema.electricity_billing (figure);
CREATE INDEX dmkbhps ON :Domestik_Schema.electricity_billing (figure, sample_time);
