-- Store counter for consumed 'HeureCreuse' in Domestik's database
-->> group=Electricité.Compteurs
--
-->> when=Periode
--
-->> require_topic=ConsCounterHC
--
-->> quiet

if SelSharedVar.Get('ansConsCounterHC') then
	SelLog.Log('I', "HC: " .. SelSharedVar.Get('ConsCounterHC') .. " -> " .. (SelSharedVar.Get('ConsCounterHC') - SelSharedVar.Get('ansConsCounterHC')) )
end

	-- Store previous value
SelSharedVar.Set('ansConsCounterHC', SelSharedVar.Get('ConsCounterHC'))
