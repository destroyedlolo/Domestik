-- Store power consumed in Domestik's database
--
-->> listen=ConsPower
-->> need_topic=ConsPower

-- PostgreSQL access
package.path = MAJORDOME_CONFIGURATION_DIRECTORY .. "/conf/?.lua;" .. package.path

local pgmoon = require "pgmoon"
local DB = require("DB")
local db = pgmoon.new(
	DB
)
assert(db:connect())


-- Transform the current time in portable number
local t = os.date("*t")
local dt = t.year * 100000000 + t.month * 1000000 + t.day *10000 + t.hour * 100 + t.min;

-- Retrieve previous value (if any)
local ans_val = SelSharedVar.Get("ConsPowerMax");
local ans_time = SelSharedVar.Get("ConsPowerH");

if ans_val then
	if tonumber(MAJORDOME_PAYLOAD) > tonumber(ans_val) then
		SelSharedVar.Set("ConsPowerMax", MAJORDOME_PAYLOAD);
	end

	if dt >= ans_time + 1 then	-- 5 minutes have passed
		local req = string.format("INSERT INTO ".. DB.schema ..".electricity_power VALUES ('Consommation', %f, now() );", db:escape_literal(tonumber(MAJORDOME_PAYLOAD)));

		local status, err = db:query(req)
		if not status then
			print("failed", err)
		end

			-- Restart for a new run
		SelSharedVar.Set("ConsPowerMax", 0.0);
		SelSharedVar.Set("ConsPowerH", dt);
	end
else
	SelSharedVar.Set("ConsPowerMax", MAJORDOME_PAYLOAD);
	SelSharedVar.Set("ConsPowerH", dt);
end
