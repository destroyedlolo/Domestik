--
-- This file will create Domestik V2 environment in a postgresql database.
--
-- History :
-- ---------
--
--	23/03/2013 - LF : First version
--	11/04/2013 - LF : Add jobs
--	13/05/2013 - LF : Add archive maintenance
--	19/10/2024 - LF : switch to Domestik2
--

-- externalize configuration
\i Configuration.sql

\qecho Drop potential existing environment
\qecho -----------------------------------
\unset ON_ERROR_STOP
DROP SCHEMA IF EXISTS :Domestik_Schema CASCADE;

\qecho Create the schema
\qecho -----------------
\set ON_ERROR_STOP
CREATE SCHEMA :Domestik_Schema;
GRANT ALL PRIVILEGES ON SCHEMA :Domestik_Schema TO :Domestik_User;
COMMENT ON SCHEMA :Domestik_Schema IS 'Domestik monitoring tool own database';


