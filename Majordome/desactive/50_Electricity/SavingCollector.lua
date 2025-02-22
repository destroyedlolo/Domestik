-- Simulate the saving due to the production (if we where in auto-production)
-- Notez-bien : it will not work if we are REALLY doing auto-production as
-- in such case, the Linky can't provide our real consumption.
--
-->> listen=DomestikAvgProdPower
-->> listen=DomestikAvgConsPower
--
-->> require_topic=DomestikAvgProdPower
-->> require_topic=DomestikAvgConsPower
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

package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path
-- Tarifs
local tarifs = require("Tarif")

local billing
if ConsOptTarif:getVal() == '1' then
	billing = tarifs.THP
print("**** HP")
else
	billing = tarifs.THC
print("**** HC")
end	

	-- Get the values
local cons, prod = tonumber(DomestikAvgConsPower:getVal()), tonumber(DomestikAvgProdPower:getVal())
local diff = cons - prod

	-- Clear topics to ensure actual values for next run
SelSharedVar.Set('DomestikAvgProdPower')
SelSharedVar.Set('DomestikAvgConsPower')

-- PostgreSQL access

local req, status, err
local pgmoon = require "pgmoon"
local DB = require("DB")
local db = pgmoon.new(
	DB
)
assert(db:connect())


	-- Calculation
if diff > 0 then
	-- Not enough production
	-- So we are reducing the consumption billing by our production

	req = string.format("INSERT INTO ".. DB.schema ..".electricity_powersaving VALUES ('Saving', %f, now() );", prod);
	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Saving', %f, now() );", prod*billing);

	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	-- Injection
	req = string.format("INSERT INTO ".. DB.schema ..".electricity_powersaving VALUES ('Injection', %f, now() );", 0);
	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Injection', %f, now() );", 0);
	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	if MAJORDOME_VERBOSE then
		print('Economie :', prod*billing)
	end
else
	-- We are producing more
	req = string.format("INSERT INTO ".. DB.schema ..".electricity_powersaving VALUES ('Saving', %f, now() );", cons);
	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Saving', %f, now() );", cons*billing);

	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	-- Injection
	req = string.format("INSERT INTO ".. DB.schema ..".electricity_powersaving VALUES ('Injection', %f, now() );", -diff);
	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	req = string.format("INSERT INTO ".. DB.schema ..".electricity_billing VALUES ('Injection', %f, now() );", -diff*tarifs.TREVENTE);
	status, err = db:query(req)
	if not status then
		print("failed", err)
	end

	if MAJORDOME_VERBOSE then
		print('Economie :', cons*billing, 'Revente :', -diff*tarifs.TREVENTE)
	end
end
