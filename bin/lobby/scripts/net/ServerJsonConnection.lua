--net connection package
require("net.ServerEvent")


local connection = {};

eventDispatcher.extend(connection)

connection.serverUrl = "";

-- parse proto
connection.parse = nil;

--log func
connection.logFunc = nil;

local function initCmd()
	if (connection.parse ~= nil) then
		connection.parse:addParseCmd(CommandMap.CMD_REGISTER_PLAYER, "net.parse.cmd.ParseRegisterLobby")
	end
end

function connection:initServer(url, par, log)
	self.serverUrl = url
	print(url)
	print(self.serverUrl)
	self.parse = par
	self.logFunc = log
	
	initCmd()
end 

local function requestMade(req)
	return connection.serverUrl .. "?rpc=" .. req .. "&ra=" .. math.random()
end



local function onData(event)
	local request = event.request
	local requestName = request.requestName
	local code = request:getResponseStatusCode()
	if (event.name == Event.COMPLETE and code == 200) then
		local response = request:getResponseString();
		if (connection.logFunc ~= nil) then
			connection.logFunc(response)
		end
		
		print(response)
		print(request:getResponseDataLength());
		
		if (connection.parse ~= nil) then
			connection.parse:execute(requestName, jsonParse.decode(response))
		end
		
		
		
		connection:dispatchEvent({name = requestName, data = response})
	else
		connection:dispatchEvent({name = ServerEvent.RequestError, code = request:getErrorCode(), msg = request:getErrorMessage()})
	end
	
end

function connection:sendRequest(req, parm)
	local request = network.createHTTPRequest(onData, requestMade(req), kCCHTTPRequestMethodPOST)
	request.requestName = req
	request:addRequestHeader("Content-Type:text/json");
	if (parm ~= nil) then
		
		
		if (self.parse ~= nil) then
			parm = self.parse:transferData(req, parm)
		end 
		local jsonStr= jsonParse.encode(parm)
		request:setPOSTData(jsonStr);
	end
	request:start()
end

return connection