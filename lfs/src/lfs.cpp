#include <dmsdk/sdk.h>
#include "lfs.h"


static void LuaInit(lua_State* L) {
    luaopen_lfs(L);
    lua_pop(L, 3);
}

dmExtension::Result AppInitializeLFSExtension(dmExtension::AppParams* params) {
    return dmExtension::RESULT_OK;
}

dmExtension::Result InitializeLFSExtension(dmExtension::Params* params) {
    LuaInit(params->m_L);
    dmLogInfo("Registered LuaFileSystem Extension");
    return dmExtension::RESULT_OK;
}

dmExtension::Result AppFinalizeLFSExtension(dmExtension::AppParams* params) {
    return dmExtension::RESULT_OK;
}

dmExtension::Result FinalizeLFSExtension(dmExtension::Params* params) {
    return dmExtension::RESULT_OK;
}

DM_DECLARE_EXTENSION(LFS, "LFS", AppInitializeLFSExtension, AppFinalizeLFSExtension, InitializeLFSExtension, 0, 0, FinalizeLFSExtension)
