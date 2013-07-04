local Bullet=class("Bullet",
	function () return display.newSprite() 
end)

function Bullet:ctor(speed,weaponType,attackMode)
	self.zOrder=3000
	self.ySpeed=-speed
	self.xSpeed=0
	self.attackMode=attackMode
	local bulletSpriteFrame=display.newSpriteFrame(weaponType)
	self:setDisplayFrame(bulletSpriteFrame)
end

function Bullet:move()
	local x=self:getPositionX()
	local y=self:getPositionY()
	x=x-self.xSpeed*(1/60)
	y=y-self.ySpeed*(1/60)
	self:setPosition(CCPoint(x,y))
end

return Bullet