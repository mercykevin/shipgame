require("utils.LuaHelper")

NumberUtil = {}

NumberUtil.NUMBER_SOURCE = 0;
NumberUtil.NUMBER_TOOGLE = 1;

NumberUtil.MILLION_TAG = "M";
NumberUtil.BILLION_TAG = "B";
NumberUtil.MILLION_NUM = 6;
NumberUtil.BILLION_NUM = 9;

function NumberUtil.getNumberByStyle(n, type, tag)
	n = string.format("%.0f", math.floor(n)) 
	print(n);
	tag = (tag ~= nil and tag) or ""
	local result = ""
	if (type == NumberUtil.NUMBER_SOURCE) then
		result = NumberUtil.getSourceNumber(n)
		return tag .. result
	else
		if string.len(n) > NumberUtil.BILLION_NUM then
			result = NumberUtil.getBillionNumber(n)
		elseif string.len(n) > NumberUtil.MILLION_NUM then
			result = NumberUtil.getShortNumber(n)
		else
			result = NumberUtil.getSourceNumber(n)
			return tag .. result
		end
	end
	
	return (string.len(result) > 8 and result ) or (tag .. result) 
end

function NumberUtil.getSourceNumber(n)
	local arr = LuaHelper.stringToTable(n)
	arr = LuaHelper.resverTable(arr)
	local loop = math.floor((table.getn(arr) - 1) / 3)
	local num = 1;
	for i = 1,loop do
		table.insert(arr, i * 3 + num, ",")
		num = num + 1
	end
	arr = LuaHelper.resverTable(arr)
	return LuaHelper.tableToString(arr)
end

function NumberUtil.getShortNumber(n)
	local arr = LuaHelper.stringToTable(n)
	arr = LuaHelper.resverTable(arr)
	local result = {}
	for i = NumberUtil.MILLION_TAG / 2 + 1, table.getn(arr) do
		if (i % 3 == 0 and i ~= NumberUtil.MILLION_NUM / 2 + 1) then
			if (i <= NumberUtil.MILLION_NUM + 1) then
				table.insert(result, ".")
			else
				table.insert(result, ",")
			end
		end
		table.insert(result, arr[i])
	end
	
	return LuaHelper.stringToTable( LuaHelper.resverTable(result) ) .. NumberUtil.MILLION_TAG
end

function NumberUtil.getBillionNumber(n)
	local arr = LuaHelper.stringToTable(n)
	arr = LuaHelper.resverTable(arr)
	local result = {}
	for i = 7, table.getn(arr) do
		if ((i - 7) % 3 == 0 and i ~= 7) then
			if (i <= NumberUtil.BILLION_NUM + 1) then
				table.insert(result, ".")
			else
				table.insert(result, ",")
			end
		end
		table.insert(result, arr[i])
	end
	
	return LuaHelper.tableToString( LuaHelper.resverTable(result) ) .. NumberUtil.BILLION_TAG
end