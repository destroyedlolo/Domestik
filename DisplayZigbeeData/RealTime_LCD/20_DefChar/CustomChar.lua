-->> desc=Define custom chars
-->> RunAtStartup
-->> need_renderer=LCD

-- Define custom characters
-- char 0-2 are already used by the clock

-- 3 : DegreeC
LCD:SetChar(3, {
	"xxx  ",
	"x x  ",
	"xxx  ",
	"     ",
	"  xxx",
	" x   ",
	" x   ",
	"  xxx"
})

-- 4 : PPM
LCD:SetChar(4, {
	"xx xx",
	"xx xx",
	"x  x ",
	"x  x ",
	"     ",
	"xx xx",
	"x x x",
	"x   x"
})

-- 5 : H:
LCD:SetChar(5, {
	"x x  ",
	"x x  ",
	"x x x",
	"xxx  ",
	"x x  ",
	"x x x",
	"x x  ",
	"     "
--[[
	"     ",
	"    x",
	" x  x",
	"x x x",
	"x x x",
	"xx  x",
	"x   x",
	"xx  x"
--]]
})


