-- Publish S.M.A.R.T alert
-- 
--


function PublishSmart( section_name )
	local f = io.open('/tmp/smartd.msg','r')

	if f then
		local msg = f:read('*all')
		f:close()

		local topic = 'Machines/' .. Marcel.Hostname() ..'/SMART'
		Marcel.MQTTPublish( topic, msg )
	end
end
