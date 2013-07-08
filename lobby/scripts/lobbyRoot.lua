require("config")
require("Event")
require("error.ErrorMap")

require("framework.init")
require("framework.client.init")

lobbyRoot = {}
eventDispatcher = require("framework.client.api.EventProtocol")
serverJsonConnection = require("net.ServerJsonConnection")
jsonParse = require("cjson")
lobbyModel = require("data.LobbyModel")

function lobbyRoot.startLobby()
--	local testJson = {}
--	
--	testJson.testParm1 = {1, 2, 3, 4}
--	testJson.name = "mainlobby";
--	testJson.testObject = {2,3,4 , abc = 234, subObj = {pk = "tk", fuck = {a = "f", b = "g" }}}
--	
--	print(lobbyRoot.jsonParse)
--	print(lobbyRoot.jsonParse.encode(testJson))
	CCFileUtils:sharedFileUtils():addSearchPath("res/")
	display.addSpriteFramesWithFile("lobbyAssets.plist", "lobbyAssets.png")
	
	
	serverJsonConnection:initServer("http://internal65.grandorientcasino.com:8080/gameserver/jsonmessage/", require("net.parse.JsonDataParse"), nil)
	lobbyRoot.mainScene = require("scenes.MainLobbyScene").new();
	display.replaceScene(lobbyRoot.mainScene,"fade", 0.3, display.COLOR_WHITE);
	serverJsonConnection:addEventListener(CommandMap.CMD_REGISTER_PLAYER, onData)
	serverJsonConnection:sendRequest(CommandMap.CMD_REGISTER_PLAYER, {firstName = "aa", lastName="bb", email = "nightmareljy@gmail.com", facebookId = "333", sex = "male", language = "en_US"});
end

function lobbyRoot.backToLobby()
	
end

function onData(event)
	serverJsonConnection:removeEventListener(CommandMap.CMD_REGISTER_PLAYER, onData)
	print(event.name)
end



function lobbyRoot.testJson()
	local testJson = {}
	testJson.testParm1 = {1, 2, 3, 4}
	testJson.name = "mainlobby";
	testJson.testObject = {phone = 13918090549, address = {home = "abc street" , family = {father = "ljy", mother = "cwj"}}}
	
	local socket = require("socket")
	local startTime = socket:gettime();
	local strJson = jsonParse.encode(testJson);
	print(strJson)
	print(string.format("Json encode usedTime:%f",socket:gettime() - startTime) )
	print("JsonLen:" .. string.len(strJson))
	
	

	startTime = socket:gettime()
	jsonParse.decode(strJson);
	print(string.format("Json decode usedTime:%f",socket:gettime() - startTime) )
	
	
end

function lobbyRoot.testPB()
	require "pbc.protobuf"
	local parser = require "pbc.parser"
	
	
	local t = parser.register("addressbook.proto", GAME_LUA_ROOT.."/pbc/test/pb/msg")
	
	local testJson = {}
	testJson.testParm1 = {1, 2, 3, 4}
	testJson.name = "mainlobby";
	testJson.testObject = {phone = 13918090549, address = {home = "abc street" , family = {father = "ljy", mother = "cwj"}}}
	
	local socket = require("socket")
	local startTime = socket:gettime();
	
	local code = protobuf.encode("tutorial.Person", testJson)
	print(code)
	print(string.format("PB encode usedTime:%f",socket:gettime() - startTime) )
	print("JsonLen:" .. string.len(code))
	
	startTime = socket:gettime()
	local decode = protobuf.decode("tutorial.Person" , code)
	print(string.format("PB decode usedTime:%f",socket:gettime() - startTime) )
	
	print(decode.name)
end