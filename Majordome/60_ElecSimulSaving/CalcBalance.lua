-- Calculate the balance b/w electricity consumption and production
--
-->> listen=DomestikAvgProdPower
-->> listen=DomestikAvgConsPower
-->> require_topic=DomestikAvgProdPower
-->> require_topic=DomestikAvgConsPower
--
-->> need_topic=ElectricityBalance
-->> need_topic=ElectricitySaving
-->> need_topic=ElectricityInjection
--

local cons, prod = tonumber(DomestikAvgConsPower:getVal()), tonumber(DomestikAvgProdPower:getVal())
local diff = prod - cons

local saving, injection
if diff >= 0 then
	saving = cons
	injection = diff
else
	saving = prod
	injection = 0
end

if MAJORDOME_VERBOSE then
	if MAJORDOME_DEBUG then
		SelLog.Log('D', "cons : ".. cons ..", prod :".. prod)
	end
	SelLog.Log('I', "Electricity Balance : ".. diff)
	SelLog.Log('I', "Saving : ".. saving ..", Injection : " .. injection)
end

ElectricityBalance:Publish(diff)
ElectricitySaving:Publish(saving)
ElectricityInjection:Publish(injection)
