local ExpBar = class("ExpBar", function() 
	return display.newNode()
end)

function ExpBar:ctor()
	self.expBar = display.newSprite("#jyt.png",0,0)
	self:addChild(self.expBar)

	self.textLabel = ui.newTTFLabel({
		text = "Lv555",
		align = ui.TEXT_ALIGN_CENTER,
		size = 20,
		dimensions = CCSizeMake(self.expBar:getContentSize().width, self.expBar:getContentSize().height)
	})
	
	self:addChild(self.textLabel)
end

function ExpBar:updateLevelInfo(info)
	self.textLabel:setString("Lv" .. info.level)
	self.expBar:setTextureRect(CCRectMake(0, 0, self.expBar:getContentSize().width * 1, self.expBar:getContentSize().height))
end

return ExpBar