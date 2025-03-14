--
-- Create table for electricity counter
--
--	History :
--	---------
--
-- 26/10/2014 - LF : First version
-- 12/08/2015 - LF : Simplify archive table
-- 19/10/2024 - LF : recreation for V2
--

-- externalize configuration
\i Configuration.sql

SET ROLE :Domestik_User;

\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS :Domestik_Schema.electricity_counter CASCADE;

\qecho Create electricity_counter schema
\qecho ---------------------------------

CREATE TABLE :Domestik_Schema.electricity_counter (
	sample_time TIMESTAMP WITH TIME ZONE,
	counter TEXT NOT NULL,
	figure TEXT NOT NULL,
	value INTEGER
);

GRANT ALL PRIVILEGES ON TABLE :Domestik_Schema.electricity_counter TO :Domestik_User;

COMMENT ON TABLE :Domestik_Schema.electricity_counter IS 'Electricity counter figures';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter.counter IS 'Counter''s name';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter.figure IS 'Counter''s figure';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter.value IS 'figure''s value';
COMMENT ON COLUMN :Domestik_Schema.electricity_counter.sample_time IS 'When the data sampled';

CREATE INDEX dmkpcnth ON :Domestik_Schema.electricity_counter (counter);
CREATE INDEX dmkpcnthp ON :Domestik_Schema.electricity_counter (counter, figure);
CREATE INDEX dmkpcnthps ON :Domestik_Schema.electricity_counter (counter, figure, sample_time);
