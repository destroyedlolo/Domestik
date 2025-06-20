-- Publish memory figures
-- 
--

function PublishMemory( section_name )
	local f = io.open('/proc/meminfo','r')
	local mtotal, mfree, stotal, sfree, buffers, cached

	for l in f:lines() do
		local tok, v = l:match("(%a+):%s*(%d+)")
		v = tonumber(v)

		if tok == "MemTotal" then
			mtotal = v
		elseif tok == "MemFree" then
			mfree = v
		elseif tok == "SwapTotal" then
			stotal = v
		elseif tok == "SwapFree" then
			sfree = v
		elseif tok == "Buffers" then
			buffers = v
		elseif tok == "Cached" then
			cached = v
		end
	end

	local topic = 'Machines/' .. Marcel.Hostname() ..'/'

	Marcel.MQTTPublish( topic .. 'memory', mfree ..'/'.. mtotal)
	Marcel.MQTTPublish( topic .. 'swap', sfree ..'/'.. stotal)
	Marcel.MQTTPublish( topic .. 'Buffers', buffers)
	Marcel.MQTTPublish( topic .. 'Cached', cached)

end
