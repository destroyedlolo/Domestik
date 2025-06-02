-->> desc=Collect consumer power statistics
-->> group=Electricité.Puissance
--
-- Frequency of data collection
-->> when=Periode
-->> need_timer=Periode
--
-- Where data come
-->> need_namedminmax=ConsPower
--

SelLog.Log('I', "Consommation :" .. ConsPower:getAverage("Consommation") .. " -> ".. ConsPower:getAverage("Consommation") * (Periode:getEvery() / 3600))

print(ConsPower:getSamplesNumber("Consommation"), ConsPower:getSum("Consommation"), ConsPower:getSum("Consommation") / ConsPower:getSamplesNumber("Consommation"))
ConsPower:Reset("Consommation")
print(ConsPower:getSamplesNumber("Consommation"))
