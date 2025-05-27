-->> desc=Calculate the balance b/w electricity consumption and production
-->> group=Electricité.Economie
--
-->> listen=ConsPower
-->> need_topic=ConsPower
-->> require_topic=ProdPower
--
-->> need_minmax=SavingCollector
-->> need_minmax=InjectionCollector

local cons, prod = tonumber(ConsPower:getVal()), tonumber(ProdPower:getVal())
local diff = prod - cons

local saving, injection
if diff >= 0 then
	saving = cons
	injection = diff
else
	saving = prod
	injection = 0
end

SavingCollector:Push(saving)
