local MoonMenuScene=class("MoonMenuScene",function ()
	return display.newScene("MoonMenuScene")
end)

function MoonMenuScene:ctor()
	self.bgSp=display.newBackgroundSprite("#loading.png")
	self:addChild(self.bgSp)
	--add logo
	self.logoSp=display.newSprite("#logo.png")
	--set anchor
	self.logoSp:setAnchorPoint(CCPoint(0,0))
	self.logoSp:setPosition(0,250)
	self:addChild(self.logoSp)
	--add menubutton
	--newgame button
	local newGameItemParams={}
	newGameItemParams.image=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(0, 0, 126, 33)))
	newGameItemParams.imageSelected=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(0, 33, 126, 33)))
	newGameItemParams.imageDisabled=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(0, 33*2, 126, 33)))
	newGameItemParams.tag=101
	newGameItemParams.x=0
	newGameItemParams.y=70
	newGameItemParams.sound="Music/buttonEffet.mp3"
	newGameItemParams.listener=function () self:newGame() end
	local newGameItem=ui.newImageMenuItem(newGameItemParams)
	newGameItem:setAnchorPoint(CCPoint(0,0))
	--option button
	local optionItemParams={}
	optionItemParams.image=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(126, 0, 126, 33)))
	optionItemParams.imageSelected=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(126, 33, 126, 33)))
	optionItemParams.imageDisabled=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(126, 33*2, 126, 33)))
	optionItemParams.tag=102
	optionItemParams.x=0
	optionItemParams.y=35
	local optionItem=ui.newImageMenuItem(optionItemParams)
	optionItem:setAnchorPoint(CCPoint(0,0))
	--about button
	local aboutItemParams={}
	aboutItemParams.image=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(126*2, 0, 126, 33)))
	aboutItemParams.imageSelected=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(126*2, 33, 126, 33)))
	aboutItemParams.imageDisabled=CCSpriteExtend.extend(CCSprite:create("menu.png",CCRectMake(126*2, 33*2, 126, 33)))
	aboutItemParams.tag=103
	aboutItemParams.x=0
	aboutItemParams.y=0
	aboutItemParams.listener=function () self:about() end
	local aboutItem=ui.newImageMenuItem(aboutItemParams)
	aboutItem:setAnchorPoint(CCPoint(0,0))
	--menu
    local menuItems={newGameItem,optionItem,aboutItem}
    self.menu=ui.newMenu(menuItems)
    self.menu:setAnchorPoint(CCPoint(0,0))
    self.menu:setPosition(97,110)
    self:addChild(self.menu)
    --add ship fly schdule
    --self:shipFly()
    local shipFlyEntryId=scheduler.scheduleGlobal(function () self:shipFly() end,3,false)
    game.scheduleEntry["shipFlyEntryId"]=shipFlyEntryId
	--播放背景音效
	audio.setMusicVolume(0.7)
	audio.playMusic("Music/mainMainMusic.mp3", true) 
end


function MoonMenuScene:shipFly()
	if not self.shipSp then
		self.shipSp=CCSpriteExtend.extend(CCSprite:create("ship01.png",CCRectMake(0, 45, 60, 38)))
		self.shipSp:setAnchorPoint(CCPoint(0,0))
		self:addChild(self.shipSp,0,100)	
	end
	math.randomseed(tostring(os.time()):reverse():sub(1,6))
	local randomPos=CCPoint(math.random()*320,0)
	self.shipSp:setPosition(randomPos)
	local desPos=CCPoint(math.random()*320,randomPos.y+480+10)
	local action=CCMoveBy:create(3,desPos)
	local actionArgs={delay=0.5}
	transition.execute(self.shipSp,action,actionArgs)
end


function MoonMenuScene:newGame()
	game.enterGame()
end

function MoonMenuScene:option()
end

function MoonMenuScene:about()
	game.enterAboutScene()
end

return MoonMenuScene