
local initconnection=require("debugger")
initconnection("127.0.0.1", 10000, "game_debug", nil, nil, "/Users/oscar/workspace/game/shipgame/projects/CasinoGame/scripts")
require"debugger.plugins.ffi"

--require('mobdebug').start()

-- for CCLuaEngine
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

CCLuaLoadChunksFromZip("res/framework_precompiled.zip")

xpcall(function()
    require("game")
    game.startup()
    CCLuaLog("test xpcall")
end, __G__TRACKBACK__)
