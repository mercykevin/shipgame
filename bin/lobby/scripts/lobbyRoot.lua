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
	CCFileUtils:sharedFileUtils():addSearchPath("assets/")
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