CtrlNames = {
	Prompt = "PromptCtrl",
	Message = "MessageCtrl",
	SelectArea = "SelectAreaCtrl",
	SelectTranScript = "SelectTranScriptCtrl",
}

PanelNames = {
	"PromptPanel",	
	"MessagePanel",
	"SelectAreaPanel",
	"SelectTranScriptPanel",
}

--协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
--当前使用的协议类型--
TestProtoType = ProtocalType.BINARY;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;
EventTriggerListener = LuaFramework.EventTriggerListener;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();

WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;
Camera = UnityEngine.Camera;