--local initconnection = require("debugger")
--initconnection("127.0.0.1" , 10000 , 'luaidekey')

-- for CCLuaEngine
function __G__TRACKBACK__(errorMessage)
    CCLuaLog("----------------------------------------")
    CCLuaLog("LUA ERROR: "..tostring(errorMessage).."\n")
    CCLuaLog(debug.traceback("", 2))
    CCLuaLog("----------------------------------------")
end

CCLuaLoadChunksFromZip("assets/framework_precompiled.zip")

xpcall(function()
	require("lobbyRoot")
	lobbyRoot.startLobby()
end, __G__TRACKBACK__)