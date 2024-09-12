-- This script load in memory all scripts found in sub directories
-- They are mainly expected to create users functions

require'lfs'

for entry in lfs.dir(MARCEL_SCRIPT_DIR) do
    if lfs.attributes(MARCEL_SCRIPT_DIR .. '/' .. entry,"mode") == "directory" and 
		file:sub(1, 1) ~= '.'
	then
		if MARCEL_DEBUG then
			print("Reading ", entry)
		end

--[[
		file ~= MARCEL_SCRIPT and
		file ~= "README.md" and
		file:sub(1, 1) ~= '.'
	then
		if MARCEL_DEBUG then
			print("*Lua* Running ", file)
		end
		dofile(MARCEL_SCRIPT_DIR .. '/' .. file)
--]]
	end
end

