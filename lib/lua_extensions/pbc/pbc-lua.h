//
//  pbc-lua.h
//  libquickcocos2dx
//
//  Created by 孙 伟 on 13-7-2.
//  Copyright (c) 2013年 qeeplay.com. All rights reserved.
//

#ifndef __PBC_LUA_H
#define __PBC_LUA_H

#if __cplusplus
extern "C" {
#endif

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

int luaopen_protobuf_c(lua_State *L);

#if __cplusplus
}
#endif

#endif /* __PBC_LUA_H */
