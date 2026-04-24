--
-- Create table to store probes' figures
--


\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS figures CASCADE;

\qecho Create figures schema
\qecho -------------------------------

CREATE TABLE figures (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	value REAL
);

CREATE INDEX dmkhtf ON figures (probe, figure);
CREATE INDEX dmkhtfs ON figures (probe, figure, sample_time);
