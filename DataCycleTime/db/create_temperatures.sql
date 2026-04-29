--
-- Create table to store temperature figures
--


\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS home_temperatures CASCADE;

\qecho Create temperature schema
\qecho -------------------------------

CREATE TABLE home_temperatures (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value REAL
);

CREATE INDEX dmkhtf ON home_temperatures (probe, figure);
CREATE INDEX dmkhtfs ON home_temperatures (probe, figure, sample_time);
