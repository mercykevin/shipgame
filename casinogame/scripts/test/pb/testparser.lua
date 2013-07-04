require "pbc/protobuf"
local parser = require "pbc/parser"


local t = parser.register("addressbook.proto", GAME_LUA_ROOT.."/test/pb/msg/")

local addressbook = {
	name = "Alice",
	id = 12345,
	phone = {
		{ number = "1301234567" },
		{ number = "87654321", type = "WORK" },
	}
}

local code = protobuf.encode("tutorial.Person", addressbook)

local decode = protobuf.decode("tutorial.Person" , code)

print(decode.name)
print(decode.id)
for _,v in ipairs(decode.phone) do
	print("\t"..v.number, v.type)
end

local buffer = protobuf.pack("tutorial.Person name id", "Alice", 123)
print(protobuf.unpack("tutorial.Person name id", buffer))