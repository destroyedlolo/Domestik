-- Store home's temperature in Domestik's database
--
-->> listen=HomeTemperatures
-->> need_topic=HomeTemperatures

local _, nlevel=HomeTemperatures:getTopic():gsub("/","")	-- amount of level
print(MAJORDOME_TOPIC, MAJORDOME_PAYLOAD)

-- Extract probe name
MAJORDOME_TOPIC = MAJORDOME_TOPIC ..'/'
local tbl =  {MAJORDOME_TOPIC:match((MAJORDOME_TOPIC:gsub("[^/]*/", "([^/]*)/")))}

local name = tbl[nlevel+1]
print(name, MAJORDOME_PAYLOAD)
