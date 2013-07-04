-- main lobby scence
require("managers.LayerManager")


local MainLobbyScene = class("MainLobbyScene", function() return require("scenes.BaseScene").new("MainLobbyScene") end)

function MainLobbyScene:ctor()
	self.bg = display.newBackgroundSprite("Lobby/lobby_bg.png")
	LayerManager.setup(self.layer)
	LayerManager.lobbyLayer:addChild(self.bg)
	
	
	
end

return MainLobbyScene