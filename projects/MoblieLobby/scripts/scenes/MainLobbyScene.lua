-- main lobby scence
require("managers.LayerManager")


local MainLobbyScene = class("MainLobbyScene", function() return require("scenes.BaseScene").new("MainLobbyScene") end)

function MainLobbyScene:ctor()
	self.bg = display.newBackgroundSprite("#lobby_bg.png")
	self.topBar = require("module.topbar.TopBarModule").new()
	LayerManager.setup(self.layer)
	LayerManager.lobbyLayer:addChild(self.bg)
	LayerManager.uiLayer:addChild(self.topBar)
	
	
	
end

return MainLobbyScene