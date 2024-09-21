-- Process Tracking
--

function PublishProcessTracking(section_name, arg)
	local processes = {}

	for p in arg:gmatch("([^;]+)") do
		processes[p] = true
	end

	local topic = 'Machines/' .. Marcel.Hostname() ..'/process/'

	for pid in lfs.dir('/proc') do
		if tonumber(pid) ~= nil then
			local f = io.open('/proc/'.. pid ..'/comm', 'r')
			if f ~= nil then
				local cmd = f:read('*l')
				f:close()

				if processes[ cmd ] then
					local d = io.open('/proc/'.. pid ..'/status', 'r')
					if d then	-- Process still alive
						local dt

						for l in d:lines() do
							local tok, v = l:match("(%a+):%s*(%d+)")
							v = tonumber(v)

							if tok == "VmData" then
								dt = v
							elseif tok == "VmStk" then
								if dt then
									Marcel.MQTTPublish( topic .. cmd, dt .."/".. v )
								end
								break;	-- Supposed to be the last informative
							end
						end

						d:close()
					end
				end
			end
		end
	end
end
