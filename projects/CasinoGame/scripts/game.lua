
require("config")
require("framework.init")
require("framework.client.init")
scheduler=require("framework.client.scheduler")

-- define global module
game = {}

game.scheduleEntry={}

function game.startup()
 	
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)
    --
	display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_MOONWARRIORS,GAME_TEXTURE_IMAGE_MOONWARRIORS)
	--
	display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_BULLET,GAME_TEXTURE_IMAGE_BULLET)
	--
	display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_EXPLOSION,GAME_TEXTURE_IMAGE_EXPLOSION)
	
    -- preload all sounds
    for k, v in pairs(GAME_SFX) do
        audio.preloadSound(v)
    end

    game.enterMenuScene()
    -- game.playLevel(1)
end

function game.exit()
    CCDirector:sharedDirector():endToLua()
end

function game.enterMenuScene()
	game.unSchedule()
    display.replaceScene(require("scenes.MoonMenuScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game.enterAboutScene()
	game.unSchedule()
	display.replaceScene(require("scenes.AboutScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game.enterGame()
	game.unSchedule()
	display.replaceScene(require("scenes.PlayScene").new(), "fade", 0.6, display.COLOR_WHITE)
	local learnLuaScene=require("scenes.LearnLuaScene")
	local scene2=learnLuaScene.new()
	CCLuaLog(learnLuaScene.test_var)
	CCLuaLog(scene2.test_var)
end

function game.unSchedule()
	if game.scheduleEntry["shipFlyEntryId"] then
		scheduler.unscheduleGlobal(game.scheduleEntry["shipFlyEntryId"])
		game.scheduleEntry["shipFlyEntryId"]=nil
	end
	if game.scheduleEntry["movingBgEntry"] then
		scheduler.unscheduleGlobal(game.scheduleEntry["movingBgEntry"])
		game.scheduleEntry["movingBgEntry"]=nil
	end
	if game.scheduleEntry["playLayerUpdate"] then
		scheduler.unscheduleGlobal(game.scheduleEntry["playLayerUpdate"])
		game.scheduleEntry["playLayerUpdate"]=nil
	end
	if game.scheduleEntry["shipFired"] then
		scheduler.unscheduleGlobal(game.scheduleEntry["shipFired"])
		game.scheduleEntry["shipFired"]=nil
	end
end

function game.enterMoreGamesScene()
    display.replaceScene(require("scenes.MoreGamesScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game.enterChooseLevelScene()
    display.replaceScene(require("scenes.ChooseLevelScene").new(), "fade", 0.6, display.COLOR_WHITE)
end
