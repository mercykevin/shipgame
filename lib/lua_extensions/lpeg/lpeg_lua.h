//
//  lpeg_lua.h
//  libquickcocos2dx
//
//  Created by 孙 伟 on 13-7-2.
//  Copyright (c) 2013年 qeeplay.com. All rights reserved.
//

#ifndef __LPEG_LUA_H
#define __LPEG_LUA_H

#include "lua.h"
#include "lauxlib.h"

#include "lptypes.h"
#include "lpcap.h"
#include "lpcode.h"
#include "lpprint.h"
#include "lptree.h"

#if __cplusplus
extern "C" {
#endif

int luaopen_lpeg (lua_State *L);

#if __cplusplus
}
#endif
    
#endif
