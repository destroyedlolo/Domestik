-- Collect producer power statistics
-- Store in the database the maximum collected
--
-- Frequency of data collection
-->> when=5minutes
--->> when=10s
--
-->> need_minmax=ProdPower
-->> need_topic=DomestikAvgProdPower
--

if MAJORDOME_VERBOSE then
	print ""
	print "Prod Power"
	print "----------"
	print( "Number of samples :", ProdPower:getSamplesNumber() )
	print( "Min value :", ProdPower:getMin() )
	print( "Max value :", ProdPower:getMax() )
	print( "Average :", ProdPower:getAverage() )
	print( "Sum :", ProdPower:getSum() )
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
local req = string.format("INSERT INTO ".. DB.schema ..".electricity_power VALUES ('Production', %f, now() );", db:escape_literal(ProdPower:getMax(v)))

local status, err = db:query(req)
if not status then
	print("failed", err)
end

-- Publish collected average
DomestikAvgProdPower:Publish( ProdPower:getAverage() )

-- Clear the statistics
ProdPower:Reset()
