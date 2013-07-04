local Ship=class("Ship",function() 
	return CCSpriteExtend.extend(CCSprite:create("ship01.png",CCRect(0, 0, 60, 38))) end
)

function Ship:ctor()
	self.bulletSpeed=900
	local shipFrame0=CCSpriteFrame:create("ship01.png",CCRect(0, 0, 60, 38))
	local shipFrame1=CCSpriteFrame:create("ship01.png",CCRect(60, 0, 60, 38))
	local frames={}
	frames[1]=shipFrame0
	frames[2]=shipFrame1
	local shipAnimation=display.newAnimation(frames,0.1)
	local animationCache=CCAnimationCache:sharedAnimationCache()
	animationCache:addAnimation(shipAnimation,"shipAnimation")
	local shipAnimate=CCAnimate:create(animationCache:animationByName("shipAnimation"))
	self:runAction(CCRepeatForever:create(shipAnimate))
	--自动开火
	local shipFired=scheduler.scheduleGlobal(function () self:shoot() end,1/6,false)
	game.scheduleEntry["shipFired"]=shipFired
end

function Ship:shoot()
	local offset=13
	local curPos=CCPoint(self:getPositionX(),self:getPositionY())
	local cs=self:getContentSize()
	local parentLayer=self:getParent()
	--右边的子弹
	local bulletA=require("views.Bullet").new(self.bulletSpeed,"W1.png","normal")
	self:getParent():addChild(bulletA,bulletA.zOrder,UNIT_TAG.PLAYER_BULLET)
	bulletA:setPosition(CCPoint(curPos.x+offset,curPos.y+cs.height*0.2))
	table.insert(parentLayer.bulletList,bulletA)
	--左边的子弹
	local bulletB=require("views.Bullet").new(self.bulletSpeed,"W1.png","normal")
	self:getParent():addChild(bulletB,bulletB.zOrder,UNIT_TAG.PLAYER_BULLET)
	bulletB:setPosition(CCPoint(curPos.x-offset,curPos.y+cs.height*0.2))
	table.insert(parentLayer.bulletList,bulletB)
end


return Ship