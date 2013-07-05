
LayerManager = {}



local function onAdded(event)
	if LayerManager.noticeLayer:getChildrenCount() > 0 then
		LayerManager.lobbyLayer:setTouchEnabled(false)
		LayerManager.gameLayer:setTouchEnabled(false)
		LayerManager.uiLayer:setTouchEnabled(false)
		LayerManager.topLayer:setTouchEnabled(false)
	end
end



local function onRemoved(event)
	if LayerManager.noticeLayer:getChildrenCount() <= 0 then
		LayerManager.lobbyLayer:setTouchEnabled(true)
		LayerManager.gameLayer:setTouchEnabled(true)
		LayerManager.uiLayer:setTouchEnabled(true)
		LayerManager.topLayer:setTouchEnabled(true)
	end
end

function LayerManager.setup(layer)
	LayerManager.root = layer;
	LayerManager.lobbyLayer = display.newLayer();
	LayerManager.gameLayer = display.newLayer();
	LayerManager.uiLayer = display.newLayer();
	LayerManager.topLayer = display.newLayer();
	LayerManager.noticeLayer = require("managers.layer.NoticeLayer").new();
	
	LayerManager.root:addChild(LayerManager.lobbyLayer);
	LayerManager.root:addChild(LayerManager.gameLayer);
	LayerManager.root:addChild(LayerManager.uiLayer);
	LayerManager.root:addChild(LayerManager.topLayer);
	LayerManager.root:addChild(LayerManager.noticeLayer);
	
	LayerManager.noticeLayer:addEventListener(Event.ON_ADD_CHILD, onAdded)
	LayerManager.noticeLayer:addEventListener(Event.ON_REMOVE_CHILD, onRemoved)
end