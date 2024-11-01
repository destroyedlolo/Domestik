-- Collect photovoltaic saving
-- Feed billing table as well
--
-- In the header of the script (comment block at the very beginning of
-- the script), each line starting with -->> are Majordome's commands.
-- Consequently, '--->>' are commented out commands.
--
-- Indicate the Timer(s) to wait for
-- (more than one "when" can be present)
-->> when=5minutes
--->> when=10s
--
--	MinMaxes
-->> need_namedminmax=Saving
-->> need_namedminmax=Injection
--
-- Billing's
-->> require_topic=ConsOptTarif
--
-- remove some trace
-- This option is useful to avoid logging of very noisy topics
--->> quiet
--
-- Disable this script
--->> disabled
--

print ""

-- Tarifs
local THP=0.27/1000
local THC=0.2068/1000
local TREVENTE=0.1269/1000

--	Iterate against stored values
for _,v in ipairs( table.pack(Saving:FiguresNames()) ) do

	print(v)
	print "---------"
	print( "Number of samples :", Saving:getSamplesNumber(v) )
	print( "Min value :", Saving:getMin(v) )
	print( "Max value :", Saving:getMax(v) )
	print( "Average :", Saving:getAverage(v) )
	print( "Sum :", Saving:getSum(v) )

	-- Clear storage : restart a new series
--	Saving:Clear(v)
end

for _,v in ipairs( table.pack(Injection:FiguresNames()) ) do

	print(v)
	print "---------"
	print( "Number of samples :", Injection:getSamplesNumber(v) )
	print( "Min value :", Injection:getMin(v) )
	print( "Max value :", Injection:getMax(v) )
	print( "Average :", Injection:getAverage(v) )
	print( "Sum :", Injection:getSum(v) )

	-- Clear storage : restart a new series
--	Injection:Clear(v)
end

-- PostgreSQL access
package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

print 'Gains'
print '-----'

local pgmoon = require "pgmoon"
local DB = require("DB")
local db = pgmoon.new(
	DB
)
assert(db:connect())

local req = string.format("INSERT INTO ".. DB.schema ..".electricity_powersaving VALUES ('Saving', %f, now() );", db:escape_literal(Saving:getSum("Saving")/12));

local status, err = db:query(req)
if not status then
	print("failed", err)
end

if ConsOptTarif:getVal() == 'HP..' then
	req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Saving', %f, now() );", db:escape_literal(Saving:getSum("Saving")/12*THP));
	print('Economie :', Saving:getSum("Saving")/12*THP)
else
	req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Saving', %f, now() );", db:escape_literal(Saving:getSum("Saving")/12*THC));
	print('Economie :', Saving:getSum("Saving")/12*THC)
end
status, err = db:query(req)
if not status then
	print("failed", err)
end

Saving:Clear("Saving");

req = string.format("INSERT INTO ".. DB.schema ..".electricity_powersaving VALUES ('Injection', %f, now() );", db:escape_literal(Injection:getSum("Injection")/12));

status, err = db:query(req)
if not status then
	print("failed", err)
end

req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Injection', %f, now() );", db:escape_literal(Injection:getSum("Injection")/12 * TREVENTE ));

	print('Revente:', Injection:getSum("Injection")/12 * TREVENTE)
--	print("->", Injection:getSum("Injection")/12, TREVENTE)
status, err = db:query(req)
if not status then
	print("failed", err)
end

Injection:Clear("Injection");

