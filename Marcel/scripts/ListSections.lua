-- This scripts shows how to enumerate sections
--

print ""
print "Defined sections"
print "----------------"

-- print(Marcel.SendAlertsCounter())

for s in Marcel.Sections()
do 
	print('"' .. s:getName() .. '"', s:getKind(), s:isEnabled() )

	local cust = s:getCustomFigures()
	if cust then
		for k,v in pairs(cust) do
			if type(v) == 'table' then
				for _, vv in pairs(v)
				do
					print('\t\t', vv)
				end
			else
				print('\t', k .. ':', v)
			end
		end
	end

	if s.inError then
		print("\tinError()", s:inError())
	end
end

print ""

	
if mod_alert then	-- Only if mod_alert is loaded
	print ""
	print "Defined Named notifications"
	print "---------------------------"

	for n in mod_alert.NamedNotifications()
	do
		print('"' .. n:getName() .. '"', n:isEnabled() )
	end
end

print ""
