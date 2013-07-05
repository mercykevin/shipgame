local NoticeLayer = class("NoticeLayer", function() 
	return display.newLayer()
end)

function NoticeLayer:ctor()
	eventDispatcher.extend(self)
	self.numChildren = self:getChildrenCount();
	self:scheduleUpdate(function(dt) self:enterFrame(dt) end)
end

function NoticeLayer:enterFrame(dt)
	local newCount = self:getChildrenCount();
	if newCount > self.numChildren then
		self:dispatchEvent({name = Event.ON_ADD_CHILD})
	elseif newCount < self.numChildren then
		self:dispatchEvent({name = Event.ON_REMOVE_CHILD})
	end
	
	self.numChildren = newCount
end

return NoticeLayer