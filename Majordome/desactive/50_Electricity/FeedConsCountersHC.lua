-- Store coutner for consumed 'HeureCreuse' in Domestik's database
--
-->> when=5minutes

if not SelSharedVar.Get('ConsCounterHC') then	-- Ensure the data is feed
	return
end

if SelSharedVar.Get('ConsCounterHC') ~= SelSharedVar.Get('ansConsCounterHC') then

	-- PostgreSQL access
	package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

	local pgmoon = require "pgmoon"
	local DB = require("DB")
	local db = pgmoon.new(
		DB
	)
	assert(db:connect())

	local req = string.format("INSERT INTO ".. DB.schema ..".electricity_counter VALUES ('Consommation', 'HC', %f, now() );", SelSharedVar.Get('ConsCounterHC'));

	local status, err = db:query(req)
	if not status then
		print("failed", err)
	end
end

	-- Store previous value
SelSharedVar.Set('ansConsCounterHC', SelSharedVar.Get('ConsCounterHC'))
