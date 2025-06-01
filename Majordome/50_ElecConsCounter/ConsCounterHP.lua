-- Store coutner for consumed 'HeurePlaine' in Domestik's database
-->> group=Electricité.Compteurs
--
-->> when=Periode
--
-->> require_topic=ConsCounterHP
-->> quiet

if SelSharedVar.Get('ansConsCounterHP') then
	SelLog.Log('I', "HP: " .. SelSharedVar.Get('ConsCounterHP') .. " -> " .. (SelSharedVar.Get('ConsCounterHP') - SelSharedVar.Get('ansConsCounterHP')) )
end

	-- Store previous value
SelSharedVar.Set('ansConsCounterHP', SelSharedVar.Get('ConsCounterHP'))
