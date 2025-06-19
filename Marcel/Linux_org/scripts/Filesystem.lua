---------
-- Monitor filesystems' usage
--
-- This file is part of Domestik project and covered by CC BY-NC 3.0 licence
--
-- Copyright 2013 - 2024 Laurent Faillie
---------
--
-- 18/03/2013	Premiere version
-- 31/03/2013	Ignore zero sized filesystem
-- 19/09/2024	Migrate to Domestik V2
--
---------
-- Example :
-- Machines/PSet/Filesystem//tmp	509165/514522
-- Machines/PSet/Filesystem//var/tmp	257701/257707
---------

local posix = require "posix"

function Filesystem( section_name )
	local topic = 'Machines/' .. Marcel.Hostname() ..'/Filesystem/'

	local f = io.open("/etc/mtab")
	for l in f:lines() do
		local dev, mnt, tp = l:match("(.-)%s(/%a-.-)%s(%w-)%s")
		local st = posix.statvfs( mnt )
		if st and tp ~= "none" then	-- ignore FS where size is N/A
			if st.blocks ~= 0 and st.files ~= 0 then -- and zero sized ones
				Marcel.MQTTPublish( topic .. mnt, st.bavail .. "/" .. st.blocks )
			end
		end
	end
	f:close()
end
