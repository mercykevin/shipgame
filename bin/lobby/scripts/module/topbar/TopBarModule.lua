require("utils.NumberUtil")

local TopBarModule = class("TopBarModule", function() 
	return display.newLayer();
end)

function TopBarModule:updateLevelInfo(info)
	self.expBar:updateLevelInfo(info)
end

function TopBarModule:updateBalanceInfo(balance)
	self.textBalance:setString(NumberUtil.getNumberByStyle(balance.amounts, 1, ""))
	self.textDragon:setString(NumberUtil.getNumberByStyle(balance.dragonDollar, 0, ""))
end

function TopBarModule:ctor()
	local topBg = display.newSprite("#top_bg.png",0,0)
	topBg:setAnchorPoint(ccp(0, 1))
	topBg:setPosition(display.left, display.top);
	self:addChild(topBg)

	local btnBack = ui.newImageMenuItem({
		image = "#back_nor.png",
		imageSelected = "#back_dow.png",
		imageDisabled = "#back_dis.png",
        x = display.left + 70,
        y = display.top - 7,
        listener = function()
            lobbyRoot.backToLobby();
        end
	})
	btnBack:setAnchorPoint(ccp(0, 1))
	
	local btnHome = ui.newImageMenuItem({
		image = "#home_nor.png",
		imageSelected = "#home_dow.png",
		imageDisabled = "#home_dis.png",
        x = display.left + 150,
        y = display.top - 7,
        listener = function()
            lobbyRoot.backToLobby();
        end
	})
	btnHome:setAnchorPoint(ccp(0, 1))
	
	
	local btnSet = ui.newImageMenuItem({
		image = "#setting_nor.png",
		imageSelected = "#setting_dow.png",
		imageDisabled = "#setting_dis.png",
        x = display.left + 1000,
        y = display.top - 7,
        listener = function()
            lobbyRoot.backToLobby();
        end
	})
	btnSet:setAnchorPoint(ccp(0, 1))
	
	self.expBar = require("module.topbar.ExpBar").new();
	self.expBar:setPosition(337, display.top - 33)
	
	self.menu = ui.newMenu({btnBack, btnHome, btnSet})
	self:addChild(self.expBar)
	self:addChild(self.menu)
	
	self.textBalance = ui.newTTFLabel({
		text = "",
		size = 20,
		dimensions = CCSizeMake(200, 80),
		x = 490,
		y = display.top - 35
	})
	
	self.textDragon = ui.newTTFLabel({
		text = "",
		align = ui.TEXT_ALIGN_RIGHT,
		size = 20,
		dimensions = CCSizeMake(200, 50),
		x = 640,
		y = display.top - 35
	})
	self.textBalance:setAnchorPoint(ccp(0, 0.5))
	self.textDragon:setAnchorPoint(ccp(0, 0.5))
	
	self:addChild(self.textBalance)
	self:addChild(self.textDragon)
end

return TopBarModule