
local initconnection=require("debugger")
initconnection('127.0.0.1', 10000 , 'game_debug',nil,nil,"/Users/sunwei/Documents/quick-aspect/projects/CasinoGame/scripts")

--require('mobdebug').start()

-- for CCLuaEngine
function __G__TRACKBACK__(errorMessage)
    CCLuaLog("----------------------------------------")
    CCLuaLog("LUA ERROR: "..tostring(errorMessage).."\n")
    CCLuaLog(debug.traceback("", 2))
    CCLuaLog("----------------------------------------")
end

CCLuaLoadChunksFromZip("res/framework_precompiled.zip")

xpcall(function()
    require("game")
    game.startup()
    CCLuaLog("test xpcall")
end, __G__TRACKBACK__)
