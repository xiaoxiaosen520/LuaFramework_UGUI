--SelectTranScriptCtrl.lua

local list = require "list" 
require "Logic/TranScriptInfo"
require "Common/define"

TranScriptInfoList = list:new(); --����һ������

SelectTranScriptCtrl = {};
local this = SelectTranScriptCtrl;

local gameObject;
local transform;
local luaBehaviour;

function SelectTranScriptCtrl.New()
	return this;
end

function SelectTranScriptCtrl.Awake()

end

function SelectTranScriptCtrl.OnCreate(obj)
	gameObject = obj;
    transform = obj.transform;
	--luaBehaviour = gameObject:GetComponent('LuaBehaviour');
	local close=gameObject.Find("close");
	EventTriggerListener.Get(close).onPointerClick=EventTriggerListener.Get(close).onPointerClick+this.Close;
	--luaBehaviour:AddClick(SelectTranScriptPanel.btnClose, this.Close);--ע��رհ�ť�¼�
	for index,value in ipairs(SelectTranScriptPanel.Sprites) do   
		--luaBehaviour:AddClick(value.gameObject, this.ImageClick); --ע�ᰴť����¼�
		EventTriggerListener.Get(value.gameObject).onPointerClick=EventTriggerListener.Get(value.gameObject).onPointerClick+this.ImageClick;
	end
	
	resMgr:LoadTextAsset('data', { 'area' }, this.GetInfo);--����area.txt�ļ�
	
end

local nowAreaID = 0;
function SelectTranScriptCtrl.GetInfo(objs)
	--��߲ȿӲ��˲��١������淢��û��customsetting.cs������ 
	--_GT(typeof(StringSplitOptions)),�������	
	local str = System.String.New(objs[0]:ToString())
    local strArray = str:Split('\r\n',System.StringSplitOptions.RemoveEmptyEntries);--�Ի�����Ϊ�ָ������ָ��ַ���     
    --local strArray = LuaHelper.StringSplit(str,'\r\n');
	for i = 2, strArray.Length - 1 do
		local temp = System.String.New(strArray[i]);
		local strArray2 = temp:Split(',',System.StringSplitOptions.RemoveEmptyEntries);
		--local strArray2 = LuaHelper.StringSplit(temp,',');

		local l = TranScriptInfo:new(strArray2[0],strArray2[1],strArray2[2],strArray2[3],strArray2[4],strArray2[5]);
		TranScriptInfoList:push(l);--����
		nowAreaID=nowAreaID+1;
		SelectTranScriptCtrl.Refresh(nowAreaID);
	end	
		
end

local nowImageIndex;
local spriteIndex = 1;
function SelectTranScriptCtrl.Refresh(areaID)
	nowImageIndex = 1;

	local now = nil;  

    for i = 1,TranScriptInfoList.length,1 do  --��������
        now = TranScriptInfoList:next(now);  
        local v = now.value; 

        if(v.id == tostring(areaID)) then
			print(spriteIndex);
			SelectTranScriptPanel.Sprites[spriteIndex].data = v;
			spriteIndex = spriteIndex + 1;
			resMgr:LoadSprite('selecttranscript_asset', { v.scriptIcon }, this.ImageInit);  --����sprite
		end 
    end  
end


function SelectTranScriptCtrl.ImageInit(objs) --����sprite
	--print(nowImageIndex);

	local go = SelectTranScriptPanel.Sprites[nowImageIndex].gameObject;
	go:GetComponent("Image").sprite = objs[0]; --Ҫ��customsetting.cs������ _GT(typeof(Image)),_GT(typeof(Sprite)),
	go.transform:FindChild("Text"):GetComponent('Text').text = SelectTranScriptPanel.Sprites[nowImageIndex].data.scriptName;
	nowImageIndex = nowImageIndex + 1; 
end

function SelectTranScriptCtrl.ImageClick(go)
	print('lua click trigger! from GameObject:'.. go.name);
	for index,value in ipairs(SelectTranScriptPanel.Sprites) do   
		if(value.gameObject == go) then
			local v = value.data;

			if(v ~= nil and v ~= 0) then
				print(v.id..v.areaName..v.scriptName..v.scriptIcon..v.scriptTable..v.scriptScene);
			end
		end
	end
end

-------------------------------------------------------------------------------
function SelectTranScriptCtrl.Open(areaID,SelectTranScriptPanel)
	--nowAreaID = areaID;

	--if(TranScriptInfoList.length > 0) then SelectTranScriptCtrl.Refresh(nowAreaID); end
	
	--print(nowAreaID.."   "..TranScriptInfoList.length)
	
	--if gameObject == nil then panelMgr:CreatePanel('SelectTranScript', this.OnCreate); 
	if gameObject == nil then
		SelectTranScriptPanel.Awake(gameObject);
	else gameObject:SetActive(true);
	end
end

function SelectTranScriptCtrl.Close(go)
	gameObject:SetActive(false);
end