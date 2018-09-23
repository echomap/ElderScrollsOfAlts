-----------
-- SORT --
-----------


--Sort
local charSortKeys =
  {
    ["name"]          = { }, 
    ["super"]         = { tiebreaker = "name" }, 
    ["alliance"]      = { tiebreaker = "name" },        
    ["class"]         = { tiebreaker = "name" },    
    ["level"]         = { tiebreaker = "name", isNumeric = true },    
    ["gender"]        = { tiebreaker = "name" },    
    ["race"]          = { tiebreaker = "name" },    
    ["alchemy"]       = { tiebreaker = "name", isNumeric = true },    
    ["blacksmithing"] = { tiebreaker = "name", isNumeric = true },    
    ["clothing"]      = { tiebreaker = "name", isNumeric = true },    
    ["enchanting"]    = { tiebreaker = "name", isNumeric = true },    
    ["provisioning"]  = { tiebreaker = "name", isNumeric = true },    
    ["jewelry"]       = { tiebreaker = "name", isNumeric = true },    
    ["woodworking"]   = { tiebreaker = "name", isNumeric = true },    
    ["backpackSize"]  = { tiebreaker = "name", isNumeric = true },        
    
    ["head"]         = { tiebreaker = "name", isNumeric = true }, 
    
    ["heavy"]         = { tiebreaker = "name", isNumeric = true },    
    ["medium"]        = { tiebreaker = "name", isNumeric = true },    
    ["light"]         = { tiebreaker = "name", isNumeric = true },    
  }
--local currentSortKey = "name"
--local currentSortOrder = ZO_SORT_ORDER_UP --ZO_SORT_ORDER_DOWN
  
--Sort
function ElderScrollsOfAlts.SortCharData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentSortKey, charSortKeys, ElderScrollsOfAlts.savedVariables.currentSortOrder)
end
function ElderScrollsOfAlts.SortEquipData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentEquipSortKey, charSortKeys, ElderScrollsOfAlts.savedVariables.currentEquipSortOrder)
end
--Sort
function ElderScrollsOfAlts:Gui2SortRefresh()
  ElderScrollsOfAlts:GuiSortBase(ElderScrollsOfAlts.savedVariables.currentSortKey,true)
end

--Sort
function ElderScrollsOfAlts:GuiEquipSortRefresh()
  ElderScrollsOfAlts:GuiSortEquip(ElderScrollsOfAlts.savedVariables.currentEquipSortKey,true)
end

function ElderScrollsOfAlts:GuiSortResearch(newKey,refreshOnly)
  
end

--Sort Generalized
function ElderScrollsOfAlts:GuiSortEquip(newKey,refreshOnly)
  local currentSortKey   = ElderScrollsOfAlts.savedVariables.currentEquipSortKey
  local currentSortOrder = ElderScrollsOfAlts.savedVariables.currentEquipSortOrder
  local dataList         = ESOA_GUI2_Body_List_EQUIP
  ElderScrollsOfAlts:debugMsg("GuiSortEquip newKey=" ..tostring(newKey)
    .." currentSortKey="..tostring(currentSortKey)
    .." currentSortOrder="..tostring(currentSortOrder)
  )
  currentSortKey, currentSortOrder = ElderScrollsOfAlts:GuiSortEquipBase(newKey,currentSortKey,currentSortOrder,dataList,refreshOnly)
  ElderScrollsOfAlts:debugMsg("GuiSortEquip Key=" ..tostring(newKey)
    .." newSortKey="..tostring(currentSortKey)
    .." newSortOrder="..tostring(currentSortOrder)
  )
  ElderScrollsOfAlts.savedVariables.currentEquipSortKey   = currentSortKey
  ElderScrollsOfAlts.savedVariables.currentEquipSortOrder = currentSortOrder
  --
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_Body_List_EQUIP)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortEquipData )   
  ZO_ScrollList_Commit(ESOA_GUI2_Body_List_EQUIP, dataLines2)
end

--Sort Generalized
--Returns: newSortKey, newSortOrder
function ElderScrollsOfAlts:GuiSortEquipBase(newKey,currentSortKey,currentSortOrder,dataList,refreshOnly)
  ElderScrollsOfAlts:debugMsg("GuiSortEquipBase newKey=" ..tostring(newKey)
    .." currentSortKey="..tostring(currentSortKey)
    .." currentSortOrder="..tostring(currentSortOrder)
    .." refreshOnly="..tostring(refreshOnly)
    )
  local sameKey = false  
  if currentSortKey == newKey then
    sameKey = true
  end
  if refreshOnly == nil then
    refreshOnly = false
  end
  --ElderScrollsOfAlts:debugMsg("GuiSortEquipBase refreshOnly="..tostring(refreshOnly) )
  
  if not refreshOnly then
    if sameKey then
      if currentSortOrder==nil or currentSortOrder == ZO_SORT_ORDER_UP then 
        currentSortOrder   = ZO_SORT_ORDER_DOWN 
      else
        currentSortOrder = ZO_SORT_ORDER_UP
      end
    else
      currentSortKey   = newKey
      currentSortOrder = ZO_SORT_ORDER_UP
    end
  end  
  ElderScrollsOfAlts:debugMsg("GuiSortEquipBase"
      .." key="..tostring(currentSortKey) 
      .." order="..tostring(currentSortOrder) 
    )
  --
  local scroll_data2 = ZO_ScrollList_GetDataList(dataList)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortEquipData )   
  ZO_ScrollList_Commit(dataList, dataLines2)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  --Arrows (TODO)
  --
  return currentSortKey, currentSortOrder
end

--Sort
function ElderScrollsOfAlts:GuiSortBase(newKey,refreshOnly,sender)
  ElderScrollsOfAlts:debugMsg("GuiSortBase newKey="..tostring(newKey) )
  local sameKey = false
  if ElderScrollsOfAlts.savedVariables.currentSortKey == newKey then
    sameKey = true
  end
  if refreshOnly == nil then
    refreshOnly = false
  end
  ElderScrollsOfAlts:debugMsg("GuiSortBase refreshOnly="..tostring(refreshOnly) )
  
  if not refreshOnly then
    if sameKey then
      if ElderScrollsOfAlts.savedVariables.currentSortOrder == ZO_SORT_ORDER_UP then 
        ElderScrollsOfAlts.savedVariables.currentSortOrder   = ZO_SORT_ORDER_DOWN 
      else
        ElderScrollsOfAlts.savedVariables.currentSortOrder = ZO_SORT_ORDER_UP
      end
    else
      ElderScrollsOfAlts.savedVariables.currentSortKey   = newKey
      ElderScrollsOfAlts.savedVariables.currentSortOrder = ZO_SORT_ORDER_UP
    end
  end  
  ElderScrollsOfAlts:debugMsg("GuiSortBase key  ="..tostring(ElderScrollsOfAlts.savedVariables.currentSortKey) )
  ElderScrollsOfAlts:debugMsg("GuiSortBase order="..tostring(ElderScrollsOfAlts.savedVariables.currentSortOrder) )
  
  --G1 local scroll_data = ZO_ScrollList_GetDataList(ESOA_GUI_PAGE1_List)  
  --G1 local dataLines   = table.sort( scroll_data,  ElderScrollsOfAlts.SortCharData )   
  --G1 ZO_ScrollList_Commit(ESOA_GUI_PAGE1_List, dataLines)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  
  --
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_Body_CharList)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortCharData )   
  ZO_ScrollList_Commit(ESOA_GUI2_Body_CharList, dataLines2)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", ElderScrollsOfAlts.savedVariables.currentSortKey )
  ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  if( not ElderScrollsOfAlts.savedVariables.currentSortOrder ) then
    ESOA_GUI2_Header_SortUp:SetHidden(false)
    ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    ESOA_GUI2_Header_SortUp:SetHidden(true)
    ESOA_GUI2_Header_SortDown:SetHidden(false)
  end
  
  --Arrows (TODO)
  if(ElderScrollsOfAlts.lastSortIcon ~= nil) then
    ElderScrollsOfAlts.lastSortIcon:SetHidden(true)
  end  
  if( sender ~= nil) then
    local lUp = sender:GetNamedChild('_SortUp')
    local lDown = sender:GetNamedChild('_SortDown')
    if(lUp~=nil and lDown~=nil) then
      if ElderScrollsOfAlts.savedVariables.currentSortOrder == ZO_SORT_ORDER_UP then 
        lUp:SetHidden(true)
        lDown:SetHidden(false)
        ElderScrollsOfAlts.lastSortIcon = lUp
      else
        lUp:SetHidden(false)
        lDown:SetHidden(true)
        ElderScrollsOfAlts.lastSortIcon = lDown
      end
    end
    --local fObj = sender:GetFont()
    --fObj:SetTextColor(1,0,0,1.0)
    --sender.font.color = (1,0,0,0)
    --sender:SetColor(1,0,0,0)
    --ElderScrollsOfAlts.lastSortIcon = 
  end
end

--Sort
function ElderScrollsOfAlts:GuiSortChar(sender,keyname)
  ElderScrollsOfAlts:GuiSortBase(keyname,false,sender)
end
--Sort
function ElderScrollsOfAlts:GuiSort(keyname)
  ElderScrollsOfAlts:GuiSortBase(keyname)
end
