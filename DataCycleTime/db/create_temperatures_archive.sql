--
-- Create table to store temperature figures
--


\qecho Drop potential existing environment
\qecho -----------------------------------
DROP TABLE IF EXISTS home_temperatures_archive CASCADE;

\qecho Create archive schema
\qecho -------------------------------

CREATE TABLE home_temperatures_archive (
	sample_time TIMESTAMP WITH TIME ZONE,
	figure TEXT NOT NULL,
	minimum REAL,
	maximum REAL,
	average REAL
);

CREATE INDEX dmkhtaf ON :Domestik_Schema.home_temperatures_archive (figure);
CREATE INDEX dmkhtafs ON :Domestik_Schema.home_temperatures_archive (figure, sample_time);
