local PlayScene= class("PlayScene",
	 function () return display.newScene("PlayScene") 
end)

--create function
function PlayScene:ctor()
	local playLayer=require("views.PlayLayer").new()
	self:addChild(playLayer)
end

return PlayScene