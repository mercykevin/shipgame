require("net.Commandmap")

local JsonDataParse = {}
JsonDataParse.parseMap = {}

function JsonDataParse:addParseCmd(cmd, parse)
	self.parseMap[cmd] = parse
end


function JsonDataParse:getParseCmd(req)
	if (self.parseMap[req] ~= nil) then
		local parseCmd = self.parseMap[req];
		if (type(parseCmd) ~= "table") then
			self.parseMap[req] = require(parseCmd)
		end
	
		return self.parseMap[req]
	else
		return nil	
	end
end

function JsonDataParse:execute(req, data)
	local cmd = self:getParseCmd(req)
	if cmd ~= nil then
		cmd.execute(req, data)
	end
end

function JsonDataParse:transferData(req, data)
	local cmd = self:getParseCmd(req)
	if cmd ~= nil then
		return cmd.transferData(req, data)
	else
		return data;
	end
end


return JsonDataParse