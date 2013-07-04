protobuf = require "protobuf"
parser = require "parser"


t = parser.register("addressbook.proto","/Users/sunwei/Documents/quick-aspect/projects/CasinoGame/scripts/pbc")

addressbook = {
	name = "Alice",
	id = 12345,
	phone = {
		{ number = "1301234567" },
		{ number = "87654321", type = "WORK" },
	}
}

code = protobuf.encode("tutorial.Person", addressbook)

decode = protobuf.decode("tutorial.Person" , code)

print(decode.name)
print(decode.id)
for _,v in ipairs(decode.phone) do
	print("\t"..v.number, v.type)
end

buffer = protobuf.pack("tutorial.Person name id", "Alice", 123)
print(protobuf.unpack("tutorial.Person name id", buffer))