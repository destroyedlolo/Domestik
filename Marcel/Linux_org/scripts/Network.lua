-------------
-- Monitor network activities
-- This version rely on /sys filesystem and as such, rely on linux kernel.
-- More information : https://www.kernel.org/doc/Documentation/filesystems/sysfs.txt
--
-- This file is part of Domestik project
-- Released under Creative Commons Attribution-NonCommercial 3.0 License
--
-- Copyright 2013-24 Laurent Faillie
---------
--
--	27/10/2013	First version
--	08/11/2013	Prevents negative value if a counter overflows.
--	19/09/2024	Migrate to Domestik V2
--
---------

function Network( section_name )
	local topic = 'Machines/' .. Marcel.Hostname() ..'/network/'

end
