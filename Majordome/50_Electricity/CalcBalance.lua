-- Calculate the balance b/w electricity consumption and production
--
-->> listen=DomestikAvgProdPower
-->> listen=DomestikAvgConsPower
-->> require_topic=DomestikAvgProdPower
-->> require_topic=DomestikAvgConsPower
--
-->> need_topic=ElectricityBalance
--

local cons, prod = tonumber(DomestikAvgConsPower:getVal()), tonumber(DomestikAvgProdPower:getVal())
local diff = cons - prod

if MAJORDOME_VERBOSE then
		print('Electricity Balance :', diff)
end

ElectricityBalance:Publish(diff)
