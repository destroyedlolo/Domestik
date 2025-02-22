-- Collect consumer power statistics
-- Store in the database the maximum collected
--
-- Frequency of data collection
-->> when=5minutes
--->> when=10s
--
-->> need_minmax=ConsPower
-->> need_topic=DomestikAvgConsPower
--

if MAJORDOME_VERBOSE then
	print ""
	print "Cons Power"
	print "----------"
	print( "Number of samples :", ConsPower:getSamplesNumber() )
	print( "Min value :", ConsPower:getMin() )
	print( "Max value :", ConsPower:getMax() )
	print( "Average :", ConsPower:getAverage() )
	print( "Sum :", ConsPower:getSum() )
end

-- PostgreSQL access
package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

local pgmoon = require "pgmoon"
local DB = require("DB")
local db = pgmoon.new(
	DB
)
assert(db:connect())

-- Store in database
local req = string.format("INSERT INTO ".. DB.schema ..".electricity_power VALUES ('Consommation', %f, now() );", db:escape_literal(ConsPower:getMax(v)))

local status, err = db:query(req)
if not status then
	print("failed", err)
end

-- Publish collected average
DomestikAvgConsPower:Publish( ConsPower:getAverage()/12 )

-- Clear the statistics
ConsPower:Reset()
