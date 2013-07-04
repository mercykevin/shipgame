local PlayLayer= class("PlayLayer",
	 function () return display.newLayer() 
end)

--create function
function PlayLayer:ctor()   
	self.backSkyHeight=0
	self.m_isBackSkyReload=false
	self.m_backTileMapHeight=0
	self.m_isBackTileReload=false
	self.beginPos=CCPoint(160,19)
	self.score=0
	self.shipLife=4
	self.state="staring"
	self.shipMoved=false
	--
	self.bg=display.newSprite("#bg01.jpg")
	self.bg:setAnchorPoint(CCPoint(0, 0))
	self.bg:setPosition(CCPoint(0, 0))
	self.backSkyHeight=self.bg:getContentSize().height
	self:addChild(self.bg,-10)
	local action=CCMoveBy:create(3,CCPoint(0,-48))
	transition.execute(self.bg,action,{})
	self.backSkyHeight=self.backSkyHeight-48
	--瓦片背景2
	self.bgTitleMap=CCTMXTiledMap:create("bg_title.tmx")
	self.bgTitleMap:setAnchorPoint(CCPoint(0, 0))
	self.bgTitleMap:setPosition(CCPoint(0, 0))
	self:addChild(self.bgTitleMap,-9)
	self.m_backTileMapHeight=self.bgTitleMap:getContentSize().width*self.bgTitleMap:getContentSize().height
	action=CCMoveBy:create(3,CCPoint(0,-200))
	transition.execute(self.bgTitleMap,action,{})
	self.m_backTileMapHeight = self.m_backTileMapHeight-200
	--每三秒执行一次滚动
	local movingBgEntry=scheduler.scheduleGlobal(function () self:movingBackground() end,3,false)
	game.scheduleEntry["movingBgEntry"]=movingBgEntry
	--增加使用飞机
	self.shipSprite=require("views.Ship").new()
	self.shipSprite:setAnchorPoint(CCPoint(0.5, 0.5))
	self.shipSprite:setPosition(self.beginPos)
	self:addChild(self.shipSprite,-8)
	--分数显示
	local scoreBMPLabel=CCLabelBMFont:create("Score: 0","myuifont.fnt")
	scoreBMPLabel:setAnchorPoint(CCPoint(0.5, 0.5))
	scoreBMPLabel:setPosition(CCPoint(CONFIG_SCREEN_WIDTH-50,463))
	self:addChild(scoreBMPLabel,1000)
	--ship life显示	
	local shipIcon=CCSpriteExtend.extend(CCSprite:create("ship01.png",CCRect(0, 0, 60, 38)))
	shipIcon:setScale(0.6)
	shipIcon:setPosition(CCPoint(30,460))
	self:addChild(shipIcon,1,5)
	--显示生命值
	self.lifeLabel=CCLabelBMFont:create(tostring(self.shipLife),"myuifont.fnt")
	self.lifeLabel:setPosition(CCPoint(60,463))
	self:addChild(self.lifeLabel,1000)
	--
	self.version=10
	
	self:addTouchEventListener(function (eventType, touches) self:onTouchs(eventType, touches) end,true)
	self:setTouchEnabled(true)
	--每z
	local playLayerUpdate=scheduler.scheduleGlobal(function () self:onUpdate() end,0,false)
	game.scheduleEntry["playLayerUpdate"]=playLayerUpdate
	--字弹
	self.bulletList={}
end


--moving someing 
function PlayLayer:movingBackground()
	local action=CCMoveBy:create(3,CCPoint(0,-48))
	transition.execute(self.bg,action,{})
	self.backSkyHeight=self.backSkyHeight-48
	if self.backSkyHeight<=480 then
		if not self.m_isBackSkyReload then
			self.bgOther=display.newSprite("#bg01.jpg")
			self.bgOther:setAnchorPoint(CCPoint(0, 0))
			self.bgOther:setPosition(CCPoint(0, 480));
			self:addChild(self.bgOther,-10)
			self.m_isBackSkyReload=true
		end
		local action=CCMoveBy:create(3,CCPoint(0,-48))
		transition.execute(self.bgOther,action,{})
	end
	if self.backSkyHeight<=0 then
		self.backSkyHeight=self.bg:getContentSize().height
		self:removeChild(self.bg,true)
		self.bg=self.bgOther
		self.bgOther=nil
		self.m_isBackSkyReload=false
	end
	--
	
	local titleBgAction=CCMoveBy:create(3,CCPoint(0,-200))
	transition.execute(self.bgTitleMap,titleBgAction,{})
	self.m_backTileMapHeight = self.m_backTileMapHeight-200
	if self.m_backTileMapHeight<=480 then
		if not self.m_isBackTileReload then
			self.bgTitleMapOther=CCTMXTiledMap:create("bg_title.tmx")
			self.bgTitleMapOther:setAnchorPoint(CCPoint(0, 0))
			self.bgTitleMapOther:setPosition(CCPoint(0, 480));
			self:addChild(self.bgTitleMapOther,-9)
			self.m_isBackTileReload=true
		end
		local titleBgOtherAction=CCMoveBy:create(3,CCPoint(0,-200))
		transition.execute(self.bgTitleMapOther,titleBgOtherAction,{})
	end
	if self.m_backTileMapHeight<=0 then
		self.m_backTileMapHeight=self.bgTitleMap:getContentSize().height*self.bgTitleMap:getContentSize().height
		self:removeChild(self.bgTitleMap,true)
		self.bgTitleMap=self.bgTitleMapOther
		self.bgTitleMapOther=nil
		self.m_isBackTileReload=false
	end
	
end


function PlayLayer:onTouchs(eventType, touches)
	if eventType==CCTOUCHBEGAN then
		return self:onBegan(eventType, touches)
	elseif eventType==CCTOUCHMOVED then
		return self:onTouchMoved(eventType, touches)
	else
		return self:onTouchEnded(eventType, touches)
	end
		
end

function PlayLayer:onBegan(eventType, touches)
	self.shipMoved=true
	self.beganX1=touches[1]
	self.beganY1=touches[2]
end

function PlayLayer:onTouchMoved(eventType, touches)
	if self.shipMoved then
		local x2=touches[1]
		local y2=touches[2]
		local delta=ccpSub(CCPoint(x2,y2),CCPoint(self.beganX1,self.beganY1))
		local curShipPos=CCPoint(self.shipSprite:getPositionX(),self.shipSprite:getPositionY())
		local newPos=ccpAdd(curShipPos,delta)
		local x=math.max(newPos.x,30)
		x=math.min(CONFIG_SCREEN_WIDTH-30,x)
		local y=math.max(newPos.y,19)
		y=math.min(CONFIG_SCREEN_HEIGHT-19,y)
		self.shipSprite:setPosition(CCPoint(x,y))
		self.beganX1=x2
		self.beganY1=y2
	end
end

function PlayLayer:onTouchEnded(eventType, touches)
	self.shipMoved=false
end

function PlayLayer:onUpdate()
	for i=#self.bulletList,1,-1 do
		local value=self.bulletList[i]
		value:move()
		local y=value:getPositionY()
		if y>CONFIG_SCREEN_HEIGHT then
			self:removeChild(value,true)
			table.remove(self.bulletList,i)
		end
	end
end

return PlayLayer