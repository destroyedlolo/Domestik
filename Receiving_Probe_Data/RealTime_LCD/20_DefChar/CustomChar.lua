-->> desc=Define custom chars
-->> RunAtStartup
-->> need_renderer=LCD

-- Define custom characters
-- char 0-2 are already used by the clock

-- 3 : 1 wire
LCD:SetChar(3, {
	" x   ",
	"xx   ",
	" x   ",
	"xxx  ",
	"     ",
	"x   x",
	"x x x",
	" x x "
})

-- 4 : Zigbee
LCD:SetChar(4, {
	"xxxx ",
	"  x  ",
	" x   ",
	"xxxx ",
	" x   ",
	" xxx ",
	" x  x",
	" xxx "
})

-- 5 : powersaving
LCD:SetChar(5, {
	" xXX ",
	"x   X",
	"XXX  ",
	"X    ",
	"XXX  ",
	"x   X",
	" xXx ",
	"     "
})

-- 6 : Volt-Ampere
LCD:SetChar(6, {
	"x   x",
	"x  x ",
	"x x  ",
	"xx  x",
	"x  xx",
	"  x x",
	" xxxx",
	"x   x"
})

