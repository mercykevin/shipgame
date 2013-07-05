local AboutScene=class("AboutScene",function () 
	return display.newScene("AboutScene") 
end)

function AboutScene:ctor()
	self.bgSp=display.newBackgroundSprite("#loading.png")
	self.bgSp:setAnchorPoint(CCPoint(0,0))
	self.bgSp:setPosition(0,0)
	self:addChild(self.bgSp,0,1)
	local aboutSp=CCSpriteExtend.extend(CCSprite:create("menuTitle.png",CCRectMake(0, 36, 100, 34)))
	aboutSp:setPosition(CCPoint(160,420))
	self:addChild(aboutSp)
	-- 说明
	local params={}
	params.text="This showcase utilizes many features from Quick cocos2dx engine, including: Parallax background, tilemap, actions, ease, frame animation, schedule, Labels, keyboard Dispatcher, Scene Transition. \n\nArt and audio is copyrighted by Enigmata Genus Revenge, you may not use any copyrigted material without permission. This showcase is licensed under GPL. \n\nProgrammer: \n Kevin Sun \n Effects animation: Hao Wu\n Quality Assurance"
	params.font="Arial"
	params.size=14
	params.textAlign=ui.TEXT_ALIGN_LEFT
	params.dimensions=CCSize(320*0.85,480)
	local aboutLabel=ui.newTTFLabel(params)
	aboutLabel:setAnchorPoint(CCPoint(0.5,0.5))
	aboutLabel:setPosition(160,220)
	self:addChild(aboutLabel)
	--添加返回按钮
	local returnParams={}
	returnParams.text="Go back"
	returnParams.font="Arial"
	returnParams.size=14
	returnParams.listener=function () game.enterMenuScene() end
	returnParams.x=0
	returnParams.y=0
	local returnItem=ui.newTTFLabelMenuItem(returnParams)
	returnItem:setAnchorPoint(CCPoint(0.5,0.5))
	local menu=ui.newMenu({returnItem})
	menu:setAnchorPoint(CCPoint(0,0))
	menu:setPosition(160,40)
	self:addChild(menu)
end

return AboutScene