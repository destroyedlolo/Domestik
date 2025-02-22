-- Store coutner for consumed 'HeurePlaine' in Domestik's database
--
-->> when=5minutes

if not SelSharedVar.Get('ConsCounterHP') then	-- Ensure the data is feed
	return
end

if SelSharedVar.Get('ConsCounterHP') ~= SelSharedVar.Get('ansConsCounterHP') then

	-- PostgreSQL access
	package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

	local pgmoon = require "pgmoon"
	local DB = require("DB")
	local db = pgmoon.new(
		DB
	)
	assert(db:connect())

	local req = string.format("INSERT INTO ".. DB.schema ..".electricity_counter VALUES ('Consommation', 'HP', %f, now() );", SelSharedVar.Get('ConsCounterHP'));

	local status, err = db:query(req)
	if not status then
		print("failed", err)
	end
end

	-- Store previous value
SelSharedVar.Set('ansConsCounterHP', SelSharedVar.Get('ConsCounterHP'))

