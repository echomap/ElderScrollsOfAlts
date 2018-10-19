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
  }
local equipSortKeys =
  {
    ["name"]          = { }, 
    ["armortype"]     = { tiebreaker = "name", isNumeric = true }, 
    ["Head_Type"]      = { tiebreaker = "name", isNumeric = true }, 
    ["Shoulders_Type"] = { tiebreaker = "name", isNumeric = true }, 
    ["Chest_Type"]     = { tiebreaker = "name", isNumeric = true }, 
    ["Hands_Type"]     = { tiebreaker = "name", isNumeric = true }, 
    ["Waist_Type"]     = { tiebreaker = "name", isNumeric = true }, 
    ["Legs_Type"]      = { tiebreaker = "name", isNumeric = true }, 
    ["Feet_Type"]      = { tiebreaker = "name", isNumeric = true }, 
        
    ["Neck_Quality"]   = { tiebreaker = "name", isNumeric = true }, 
    ["Ring1_Quality"]  = { tiebreaker = "name", isNumeric = true }, 
    ["Ring2_Quality"]  = { tiebreaker = "name", isNumeric = true }, 

    ["Main1_WeaponType"] = { tiebreaker = "name", isNumeric = true }, 
    ["Main2_WeaponType"] = { tiebreaker = "name", isNumeric = true }, 
    ["Mainp_Type"]       = { tiebreaker = "name", isNumeric = true }, 
    ["Off1_WeaponType"]  = { tiebreaker = "name", isNumeric = true },
    ["Off2_WeaponType"]  = { tiebreaker = "name", isNumeric = true }, 
    ["Offp_Type"]     = { tiebreaker = "name", isNumeric = true },
    
    ["Mp"]         = { tiebreaker = "name" },    
    ["Op"]         = { tiebreaker = "name" },    
    
    ["heavy"]         = { tiebreaker = "name", isNumeric = true },    
    ["medium"]        = { tiebreaker = "name", isNumeric = true },    
    ["light"]         = { tiebreaker = "name", isNumeric = true },    
  }
local researchSortKeys =
  {
    ["name"]          = { }, 
    ["Jewelcrafting"] = { tiebreaker = "name" }, 
    ["Woodworking"]   = { tiebreaker = "name" }, 
    ["Smithing"]      = { tiebreaker = "name" }, 
    ["Clothing"]      = { tiebreaker = "name" }, 
    ["rclothier1"]    = { tiebreaker = "name" }, 
    ["rclothier2"]    = { tiebreaker = "name" }, 
    ["rclothier3"]    = { tiebreaker = "name" }, 
    
    ["rclothier1time"]    = { tiebreaker = "name" }, 
    ["rclothier2time"]    = { tiebreaker = "name" }, 
    ["rclothier3time"]    = { tiebreaker = "name" }, 
    
    ["rblacksmithing1time"]    = { tiebreaker = "name" }, 
    ["rblacksmithing2time"]    = { tiebreaker = "name" }, 
    ["rblacksmithing3time"]    = { tiebreaker = "name" }, 
    
    ["rwoodworking1time"]    = { tiebreaker = "name" }, 
    ["rwoodworking2time"]    = { tiebreaker = "name" }, 
    ["rwoodworking3time"]    = { tiebreaker = "name" }, 
      
    ["rjewelcrafting1time"]    = { tiebreaker = "name" }, 
    ["rjewelcrafting2time"]    = { tiebreaker = "name" }, 
    ["rjewelcrafting3time"]    = { tiebreaker = "name" }, 
  }

local misc2SortKeys =
  {
    ["name"]              = { }, 
    
    ["AssaultR"]          = { tiebreaker = "name" }, 
    ["SupportR"]          = { tiebreaker = "name" }, 
    ["LegerdemainR"]      = { tiebreaker = "name" }, 
    ["Soul MagicR"]       = { tiebreaker = "name" }, 
    ["WerewolfR"]         = { tiebreaker = "name" }, 
    ["VampireR"]          = { tiebreaker = "name" }, 
    ["Fighters GuildR"]   = { tiebreaker = "name" }, 
    ["Mages GuildR"]      = { tiebreaker = "name" }, 
    ["UndauntedR"]        = { tiebreaker = "name" }, 
    ["Thieves GuildR"]    = { tiebreaker = "name" }, 
    ["Dark BrotherhoodR"] = { tiebreaker = "name" }, 
    ["Psijic OrderR"]     = { tiebreaker = "name" }, 
    
    ["Assault_Rank"]          = { tiebreaker = "name", isNumeric = true }, 
    ["Support_Rank"]          = { tiebreaker = "name", isNumeric = true }, 
    ["Legerdemain_Rank"]      = { tiebreaker = "name", isNumeric = true }, 
    ["Soul Magic_Rank"]       = { tiebreaker = "name", isNumeric = true }, 
    ["Werewolf_Rank"]         = { tiebreaker = "name", isNumeric = true }, 
    ["Vampire_Rank"]          = { tiebreaker = "name", isNumeric = true }, 
    ["Fighters Guild_Rank"]   = { tiebreaker = "name", isNumeric = true }, 
    ["Mages Guild_Rank"]      = { tiebreaker = "name", isNumeric = true }, 
    ["Undaunted_Rank"]        = { tiebreaker = "name", isNumeric = true }, 
    ["Thieves Guild_Rank"]    = { tiebreaker = "name", isNumeric = true }, 
    ["Dark Brotherhood_Rank"] = { tiebreaker = "name", isNumeric = true }, 
    ["Psijic Order_Rank"]     = { tiebreaker = "name", isNumeric = true }, 
    
    ["riding_inventory"]   = { tiebreaker = "name", isNumeric = true }, 
    ["riding_speed"]       = { tiebreaker = "name", isNumeric = true }, 
    ["riding_stamina"]     = { tiebreaker = "name", isNumeric = true }, 
    ["riding_timeDisplay"] = { tiebreaker = "name" }, 
    ["riding_timeMs"]      = { tiebreaker = "name", isNumeric = true }, 
    ["riding_timer"]       = { tiebreaker = "riding_timeMs" }, 
  }

--Sort
function ElderScrollsOfAlts.SortCharData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentSortKey, charSortKeys, ElderScrollsOfAlts.savedVariables.currentSortOrder)
end
function ElderScrollsOfAlts.SortEquipData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentEquipSortKey, equipSortKeys, ElderScrollsOfAlts.savedVariables.currentEquipSortOrder)
end
function ElderScrollsOfAlts.SortResearchData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentResearchSortKey, researchSortKeys, ElderScrollsOfAlts.savedVariables.currentResearchSortOrder)
end
function ElderScrollsOfAlts.SortMisc2Data(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentMisc2SortKey, misc2SortKeys, ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder)
end

--Sort
function ElderScrollsOfAlts:Gui2SortRefresh()
  ElderScrollsOfAlts:GuiSortCharBase(ElderScrollsOfAlts.savedVariables.currentSortKey,true)
end

--Sort
function ElderScrollsOfAlts:GuiEquipSortRefresh()
  ElderScrollsOfAlts:GuiSortEquip(nil,ElderScrollsOfAlts.savedVariables.currentEquipSortKey,ElderScrollsOfAlts.savedVariables.currentEquipDisplayKey,true)
end

--Sort
function ElderScrollsOfAlts:GuiResearchSortRefresh()
  ElderScrollsOfAlts:GuiSortResearch(nil,ElderScrollsOfAlts.savedVariables.currentResearchSortKey,ElderScrollsOfAlts.savedVariables.currentResearchDisplayKey,true)
end
--
function ElderScrollsOfAlts:GuiSortResearch(sender,newKey,displayKey,refreshOnly)
  ElderScrollsOfAlts:debugMsg("GuiSortResearch newKey="..tostring(newKey) )
  local sameKey = false
  if ElderScrollsOfAlts.savedVariables.currentResearchSortKey == newKey then
    sameKey = true
  end
  if refreshOnly == nil then
    refreshOnly = false
  end
  ElderScrollsOfAlts:debugMsg("GuiSortResearch refreshOnly="..tostring(refreshOnly) )
  
  if not refreshOnly then
    if sameKey then
      if ElderScrollsOfAlts.savedVariables.currentResearchSortOrder == ZO_SORT_ORDER_UP then 
        ElderScrollsOfAlts.savedVariables.currentResearchSortOrder   = ZO_SORT_ORDER_DOWN 
      else
        ElderScrollsOfAlts.savedVariables.currentResearchSortOrder = ZO_SORT_ORDER_UP
      end
    else
      ElderScrollsOfAlts.savedVariables.currentResearchSortKey   = newKey
      ElderScrollsOfAlts.savedVariables.currentResearchSortOrder = ZO_SORT_ORDER_UP
      if(displayKey~=nil)then
        ElderScrollsOfAlts.savedVariables.currentResearchDisplayKey = displayKey
      else
        ElderScrollsOfAlts.savedVariables.currentResearchDisplayKey = newKey
      end
    end
  end  
  ElderScrollsOfAlts:debugMsg("GuiSortResearch key  ="..tostring(ElderScrollsOfAlts.savedVariables.currentResearchSortKey) )
  ElderScrollsOfAlts:debugMsg("GuiSortResearch order="..tostring(ElderScrollsOfAlts.savedVariables.currentResearchSortOrder) )
  
  --Data Sort
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_Body_List_Research)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortResearchData )   
  ZO_ScrollList_Commit(ESOA_GUI2_Body_List_Research, dataLines2)
  
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", ElderScrollsOfAlts.savedVariables.currentResearchDisplayKey )
  ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  if( not ElderScrollsOfAlts.savedVariables.currentResearchSortOrder ) then
    ESOA_GUI2_Header_SortUp:SetHidden(false)
    ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    ESOA_GUI2_Header_SortUp:SetHidden(true)
    ESOA_GUI2_Header_SortDown:SetHidden(false)
  end

end


--Sort
function ElderScrollsOfAlts:GuiMisc2SortRefresh()
  ElderScrollsOfAlts:GuiSortMisc2(nil,ElderScrollsOfAlts.savedVariables.currentMisc2SortKey,ElderScrollsOfAlts.savedVariables.currentMisc2DisplayKey,true)
end
--
function ElderScrollsOfAlts:GuiSortMisc2(sender,newKey,displayKey,refreshOnly)
  ElderScrollsOfAlts:debugMsg("GuiSortMisc2 newKey="..tostring(newKey) )
  local sameKey = false
  if ElderScrollsOfAlts.savedVariables.currentMisc2SortKey == newKey then
    sameKey = true
  end
  if refreshOnly == nil then
    refreshOnly = false
  end
  ElderScrollsOfAlts:debugMsg("GuiSortMisc2 refreshOnly="..tostring(refreshOnly) )
  
  if not refreshOnly then
    if sameKey then
      if ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder == ZO_SORT_ORDER_UP then 
        ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder   = ZO_SORT_ORDER_DOWN 
      else
        ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder = ZO_SORT_ORDER_UP
      end
    else
      ElderScrollsOfAlts.savedVariables.currentMisc2SortKey   = newKey
      ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder = ZO_SORT_ORDER_UP
      if(displayKey~=nil)then
        ElderScrollsOfAlts.savedVariables.currentMisc2DisplayKey = displayKey
      else
        ElderScrollsOfAlts.savedVariables.currentMisc2DisplayKey = newKey
      end
    end
  end  
  ElderScrollsOfAlts:debugMsg("GuiSortMisc2 key  ='"..tostring(ElderScrollsOfAlts.savedVariables.currentMisc2SortKey) .."'")
  ElderScrollsOfAlts:debugMsg("GuiSortMisc2 order='"..tostring(ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder).."'" )
  
  --Data Sort
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_Body_List_Misc2)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortMisc2Data )   
  ZO_ScrollList_Commit(ESOA_GUI2_Body_List_Misc2, dataLines2)
  
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", ElderScrollsOfAlts.savedVariables.currentMisc2DisplayKey )
  ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  if( not ElderScrollsOfAlts.savedVariables.currentMisc2SortOrder ) then
    ESOA_GUI2_Header_SortUp:SetHidden(false)
    ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    ESOA_GUI2_Header_SortUp:SetHidden(true)
    ESOA_GUI2_Header_SortDown:SetHidden(false)
  end

end




--Sort Generalized
function ElderScrollsOfAlts:GuiSortEquip(sender,newKey,displayKey,refreshOnly)
  local currentSortKey   = ElderScrollsOfAlts.savedVariables.currentEquipSortKey
  local currentSortOrder = ElderScrollsOfAlts.savedVariables.currentEquipSortOrder
  ElderScrollsOfAlts:debugMsg("GuiSortEquip newKey=" ..tostring(newKey)
    .." currentSortKey="..tostring(currentSortKey)
    .." currentSortOrder="..tostring(currentSortOrder)
  )
  --local dataList         = ESOA_GUI2_Body_List_EQUIP
  currentSortKey, currentSortOrder = ElderScrollsOfAlts:GuiSortBase(sender,displayKey,newKey,currentSortKey,currentSortOrder)
  ElderScrollsOfAlts:debugMsg("GuiSortEquip Key=" ..tostring(newKey)
    .." newSortKey="..tostring(currentSortKey)
    .." newSortOrder="..tostring(currentSortOrder)
  )
  ElderScrollsOfAlts.savedVariables.currentEquipSortKey   = currentSortKey
  ElderScrollsOfAlts.savedVariables.currentEquipSortOrder = currentSortOrder
  if(displayKey~=nil)then
    ElderScrollsOfAlts.savedVariables.currentEquipDisplayKey = displayKey
  else
    ElderScrollsOfAlts.savedVariables.currentEquipDisplayKey = currentSortKey
  end
  --Data Sort
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_Body_List_EQUIP)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortEquipData )   
  ZO_ScrollList_Commit(ESOA_GUI2_Body_List_EQUIP, dataLines2)
  
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", ElderScrollsOfAlts.savedVariables.currentEquipDisplayKey )
  ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  if( not ElderScrollsOfAlts.savedVariables.currentEquipSortOrder ) then
    ESOA_GUI2_Header_SortUp:SetHidden(false)
    ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    ESOA_GUI2_Header_SortUp:SetHidden(true)
    ESOA_GUI2_Header_SortDown:SetHidden(false)
  end
end

--Sort Generalized
--Returns: newSortKey, newSortOrder
function ElderScrollsOfAlts:GuiSortBase(sender,displayKey,newKey,currentSortKey,currentSortOrder)
  ElderScrollsOfAlts:debugMsg("GuiSortBase newKey=" ..tostring(newKey)
    .." displayKey="..tostring(displayKey)
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
  --
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
  ElderScrollsOfAlts:debugMsg("GuiSortBase"
      .." key="..tostring(currentSortKey) 
      .." order="..tostring(currentSortOrder) 
    )
  --
  --local scroll_data2 = ZO_ScrollList_GetDataList(dataList)  
  --local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortEquipData )   
  --ZO_ScrollList_Commit(dataList, dataLines2)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  --Arrows (TODO)
  --
  return currentSortKey, currentSortOrder
end

--Sort
function ElderScrollsOfAlts:GuiSortCharBase(newKey,refreshOnly,sender)
  ElderScrollsOfAlts:debugMsg("GuiSortCharBase newKey="..tostring(newKey) )
  local sameKey = false
  if ElderScrollsOfAlts.savedVariables.currentSortKey == newKey then
    sameKey = true
  end
  if refreshOnly == nil then
    refreshOnly = false
  end
  ElderScrollsOfAlts:debugMsg("GuiSortCharBase refreshOnly="..tostring(refreshOnly) )
  
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
  ElderScrollsOfAlts:debugMsg("GuiSortCharBase key  ="..tostring(ElderScrollsOfAlts.savedVariables.currentSortKey) )
  ElderScrollsOfAlts:debugMsg("GuiSortCharBase order="..tostring(ElderScrollsOfAlts.savedVariables.currentSortOrder) )
  
  --G1 local scroll_data = ZO_ScrollList_GetDataList(ESOA_GUI_PAGE1_List)  
  --G1 local dataLines   = table.sort( scroll_data,  ElderScrollsOfAlts.SortCharData )   
  --G1 ZO_ScrollList_Commit(ESOA_GUI_PAGE1_List, dataLines)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  
  --Data Sort
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
end

--Sort
function ElderScrollsOfAlts:GuiSortChar(sender,keyname)
  ElderScrollsOfAlts:GuiSortCharBase(keyname,false,sender)
end
--Sort
function ElderScrollsOfAlts:GuiSort(keyname)
  ElderScrollsOfAlts:GuiSortCharBase(keyname)
end
