LuaHelper = {}

function LuaHelper.stringToTable(str)
	local result = {}
	for i = 1, string.len(str) do
		table.insert(result, string.sub(str,i , i))
	end
	
	return result
end

function LuaHelper.resverTable(t)
	local result = {}
	
	for i = table.getn(t), 1, -1 do
		table.insert(result, t[i])
	end

	return result
end

function LuaHelper.tableToString(t)
	local str = ""
	for i = 1, table.getn(t) do
		str = str .. t[i]
	end
	return str
end