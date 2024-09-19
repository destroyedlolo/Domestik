-- Publish disks temperature
-- 
-- Example :
-- Machines/PSet/HDDTemp//dev/sda	53
--

function PublishHDDTemp( section_name )
	local socket = require("socket")

	local clt = socket.connect( "localhost", 7634 )
	if not clt then
		return nil
	end
	local s, err = clt:receive('*a')
	clt:close()

	local res = {}
	s=s.."|"
	for mnt,tp,temp,unit in s:gmatch("|(.-)|(.-)|(.-)|(.-)|") do
		temp = tonumber(temp)
		if temp then
			res[ mnt ] = temp
		end
	end

	local topic = 'Machines/' .. Marcel.Hostname() ..'/HDDTemp/'

	for dsk,val in pairs(res)
	do
		Marcel.MQTTPublish( topic .. dsk, val)
	end
end
