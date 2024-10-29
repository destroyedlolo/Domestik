-- Collect photovoltaic saving
--
-- In the header of the script (comment block at the very beginning of
-- the script), each line starting with -->> are Majordome's commands.
-- Consequently, '--->>' are commented out commands.
--
-- Indicate the Timer(s) to wait for
-- (more than one "when" can be present)
-->> when=10s
--
--	MinMaxes
-->> need_namedminmax=Saving
-->> need_namedminmax=Injection
--
-- remove some trace
-- This option is useful to avoid logging of very noisy topics
--->> quiet
--
-- Disable this script
--->> disabled
--

print ""

--	Iterate against stored values
for _,v in ipairs( table.pack(Saving:FiguresNames()) ) do

	print(v)
	print "---------"
	print( "Number of samples :", Saving:getSamplesNumber(v) )
	print( "Min value :", Saving:getMin(v) )
	print( "Max value :", Saving:getMax(v) )
	print( "Average :", Saving:getAverage(v) )
	print( "Sum :", Saving:getSum(v) )

	-- Clear storage : restart a new series
	Saving:Clear(v)
end

for _,v in ipairs( table.pack(Injection:FiguresNames()) ) do

	print(v)
	print "---------"
	print( "Number of samples :", Injection:getSamplesNumber(v) )
	print( "Min value :", Injection:getMin(v) )
	print( "Max value :", Injection:getMax(v) )
	print( "Average :", Injection:getAverage(v) )
	print( "Sum :", Injection:getSum(v) )

	-- Clear storage : restart a new series
	Injection:Clear(v)
end
