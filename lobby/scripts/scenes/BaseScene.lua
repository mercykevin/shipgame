
local BaseScene = class("BaseScene", function(name)
	return display.newScene(name)
end)

function BaseScene:ctor()
	self.layer = display.newLayer();
	self:addChild(self.layer)
end


return BaseScene