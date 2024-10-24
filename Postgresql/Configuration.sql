--
-- This file contains all configurations directive shared among
-- all scripts.
--
-- It's the only modifiable script : feel free to customize it as per
-- your needs.
-- It is strongly recommended not to modify other sql.
--
-- History :
-- ---------
--
--	19/10/2024 - LF : Creation for Domestik2
--	23/10/2024 - LF : use dedicated user (easier for grafana)
--

-- Postgresql's user
\set Domestik_User 'domestik2'

-- Domestik dedicated schema
\set Domestik_Schema 'domestik2'

