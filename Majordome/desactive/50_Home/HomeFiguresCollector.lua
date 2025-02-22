-- Gather home's statistics
-- In the header of the script (comment bloc at the very beginning of
-- the script), each line starting with -->> are Majordome's commands.
-- Consequently, '--->>' are commented out commands.
--
-- Name of this script
-- if not set, takes the filename
-- Notez-bien : if used, this directive MUST be defined before any
-- listen directive.
--->> name=Toto
--
-- remove some trace
-- This option is useful to avoid logging of very noisy topics
-->> quiet
--
-- Disable this NamedMinMax
--->> disabled
--
-- Indicate MQTT topic(s) to listen to
-- More than one "listen" can be present
-->> listen=HomeTemperatures
--
-->> need_topic=HomeTemperatures

-- Extract probe name
local _, nlevel=HomeTemperatures:getTopic():gsub("/","")	-- amount of level

MAJORDOME_TOPIC = MAJORDOME_TOPIC ..'/'
local tbl =  {MAJORDOME_TOPIC:match((MAJORDOME_TOPIC:gsub("[^/]*/", "([^/]*)/")))}

local name = tbl[nlevel+1]

-- Transcodage of some name
-- If the value is nul, the topic is ignored
local transco =  {
	["GarageP"] = "Porte Garage",
	["Congelateur"] = 0
}

if transco[name] == 0 then
	return
elseif transco[name] then
	name = transco[name]
end

-- ignore any deeper level
-- (usually, I publish the raw/uncorrected value)

if not tbl[nlevel+2] then
	-- PostgreSQL access
	package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

	local pgmoon = require "pgmoon"
	local DB = require("DB")
	local db = pgmoon.new(
		DB
	)
	assert(db:connect())

	local req = string.format("INSERT INTO ".. DB.schema ..".home_figures VALUES (%s, 'Temperature', %f, now())", db:escape_literal(name), db:escape_literal(tonumber(MAJORDOME_PAYLOAD)));
--	print(req)

	local status, err = db:query(req)
	if not status then
		print("failed", err)
	end
--[[
else
	print("Ignoring", tbl[nlevel+2])
]]
end

