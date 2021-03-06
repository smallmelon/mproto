local parser = require "sprotoparser"
local core = require "sproto.core"
local print_r = require "print_r"

local sp = parser.parse [[
.foobar {
	.nest {
		a 1 : string
		b 3 : boolean
		c 5 : integer
	}
	a 0 : string
	b 1 : integer
	c 2 : boolean
	d 3 : nest

	e 4 : *string
	f 5 : *integer
	g 6 : *boolean
	h 7 : foobar
}
]]

sp = core.newproto(sp)
--core.dumpproto(sp)

local st = core.querytype(sp, "foobar")

local obj = {
	a = "hello",
	b = 1000000,
	c = true,
	d = {
		a = "world",
		-- skip b
		c = -1,
	},
	e = { "ABC", "def" },
	f = { -3, -2, -1, 0 , 1, 2},
	g = { true, false, true },
	h = { b = 100 },
--	h = {
--		{ b = 100 },
--		{},
--		{ b = -100, c= false },
--		{ b = 0, e = { "test" } },
--	},
}

local code = core.encode(st, obj)
parser.dump(code)
print("----- encode(data) ---------\n")
local pack = core.pack(code)
parser.dump(pack)
print("----- pack(encode) ---------\n")
local unpa = core.unpack(pack)
parser.dump(unpa)
print("----- unpack(pack) ---------\n")
local pack1 = core.pack(unpa)
parser.dump(pack1)
print("----- pack(unpack) ---------\n")
obj = core.decode(st, code)
print_r(obj)
print("----- decode(encode) ---------\n")
obj = core.decode(st, unpa)
print_r(obj)
print("----- decode(unpack) ---------\n")


