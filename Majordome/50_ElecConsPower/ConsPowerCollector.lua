-->> desc=Collect consumer power statistics
-->> group=Electricité.Puissance
--
-- Frequency of data collection
-->> when=Periode
--
-- Where data come
-->> need_namedminmax=ConsPower
--

SelLog.Log('I', "Consommation :" .. ConsPower:getAverage("Consommation"))
