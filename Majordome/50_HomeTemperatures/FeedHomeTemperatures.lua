-- Store home's temperature in Domestik's database
--
-->> listen=HomeTemperatures
-->> need_topic=HomeTemperatures

-- PostgreSQL access
-- package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

local pgmoon = require "pgmoon"
local db = pgmoon.new( {
	database = "www",
--	user= "toto"
})

assert(db:connect())

-- Extract probe name
local _, nlevel=HomeTemperatures:getTopic():gsub("/","")	-- amount of level

MAJORDOME_TOPIC = MAJORDOME_TOPIC ..'/'
local tbl =  {MAJORDOME_TOPIC:match((MAJORDOME_TOPIC:gsub("[^/]*/", "([^/]*)/")))}
local name = tbl[nlevel+1]

-- ignore deeper level
-- (usually, I publish the raw/uncorrected value)

if not tbl[nlevel+2] then
	local req = string.format("INSERT INTO domestik.probe_hardware VALUES ('Maison', %s, %f, false, now() );", db:escape_literal(name), db:escape_literal(tonumber(MAJORDOME_PAYLOAD)));
--	print(req)

	local status, err = db:query(req)
	if not status then
		print("failed", err)
	end
end
