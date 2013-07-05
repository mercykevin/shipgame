--local initconnection = require("debugger")
--initconnection("127.0.0.1" , 10000 , 'luaidekey')
--require"debugger.plugins.ffi"

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
	require("lobbyRoot")
--	lobbyRoot.startLobby()
	lobbyRoot.testJson()
	lobbyRoot.testPB()
end, __G__TRACKBACK__)
