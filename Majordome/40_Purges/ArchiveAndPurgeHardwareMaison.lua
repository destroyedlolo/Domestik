-- Archive and purge old hardware data
-->> when=MidnightOrAtLaunch

-- PostgreSQL access
package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

local pgmoon = require "pgmoon"
local db = pgmoon.new(
	require("DB")
)

assert(db:connect())

--

local res,status = db:query( [[
BEGIN;
INSERT INTO domestik.probe_hardware_archive
SELECT
        host, probe,
        CAST( to_char(sample_time, 'YYYYMMDD HH24:00') AS TIMESTAMP WITH TIME ZONE) AS time,
        min(value),
        max(value),
        bool_or(alert)
FROM domestik.probe_hardware
WHERE
        host='Maison' AND sample_time < ( SELECT now() - INTERVAL '1 day')
GROUP BY host,probe,time;
DELETE FROM domestik.probe_hardware
WHERE host='Maison' AND sample_time < ( SELECT now() - INTERVAL '1 day');
COMMIT;
]] )

if not res then
	SelLog.Log('E', "Archive hardware Maison failed : ".. status)
end

SelLog.Log('I', "Archive hardware Maison succeeded")
