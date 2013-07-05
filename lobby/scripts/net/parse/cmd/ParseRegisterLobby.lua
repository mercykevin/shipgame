local parse = {}

function parse.transferData(req, data)
	return data
end

function parse.execute(req, data)
	if data.retCode == ErrorMap.NO_ERROR then
		lobbyModel.userInfo.userName = data.userName;
	end
end


return parse