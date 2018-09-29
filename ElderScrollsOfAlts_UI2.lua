-- GUI Elements (Setup and View Data)


--Sort
local categorySortKeys =
  {
    ["MAIN"]          = { },
  }
--Sort
function ElderScrollsOfAlts.SortCategoriesData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, "MAIN", categorySortKeys, ZO_SORT_ORDER_DOWN )
end
--
function ElderScrollsOfAlts:ListOfCategories(forDisplayOnly)
  ElderScrollsOfAlts.debugMsg("ListOfCategories: Called" )
  local validChoices =  {}
  if(forDisplayOnly~=nil and forDisplayOnly==true)then
    table.insert(validChoices, "All")
  end
  
  local tCount = 0
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
    if k ~= nil then
      --d("List: players " .. k)
      local catP = ElderScrollsOfAlts.altData.players[k].category
      if ( catP~=nil and not ElderScrollsOfAlts:has_value(validChoices, catP) ) then 
        table.insert(validChoices, catP)	
        ElderScrollsOfAlts.debugMsg("List: added cat=" .. catP)
        tCount = tCount+1
      end
    end
  end
  --Default Values
  ElderScrollsOfAlts.debugMsg("List: tCount= " .. tCount)
  if(tCount==0)then
    table.insert(validChoices, "A")
    table.insert(validChoices, "B")
  end  
  --Sort
  --local validChoicesS = table.sort( validChoices,  ElderScrollsOfAlts.SortCategoriesData )  
   --Return
  return validChoices
end


--
function ElderScrollsOfAlts:GuiSetupCategoryButton(self)  
  local validChoices = ElderScrollsOfAlts:ListOfCategories(true)
  ESOA_GUI2_Header_CategorySelect:SetText("All")  
    --selected? --else all
  local categoryS = ElderScrollsOfAlts.savedVariables.selected.category
  if(categoryS==nil) then
    ElderScrollsOfAlts.savedVariables.selected.category = "All"
  end
  ESOA_GUI2_Header_CategorySelect:SetText(categoryS)  
end

--
function ElderScrollsOfAlts:SelectCategoryOnRotation(self) 
  local validChoices =  ElderScrollsOfAlts:ListOfCategories(true)
  local categoryS = ElderScrollsOfAlts.savedVariables.selected.category
  if(categoryS==nil)then
    categoryS = "All"
  end
  --ElderScrollsOfAlts:debugMsg
  ElderScrollsOfAlts:debugMsg("categoryS="..tostring(categoryS) )
  local foundC = false
  local nextC = false
  for i = 1, #validChoices do
		local entry = validChoices[i]
    ElderScrollsOfAlts:debugMsg("entry="..tostring(entry) )
    if(nextC)then
      ElderScrollsOfAlts.savedVariables.selected.category = entry
      ElderScrollsOfAlts:debugMsg("setting selected per nextC as "..entry )
      nextC = false
      break
    end
    if(entry==categoryS)then
      nextC  = true
      foundC = true
      ElderScrollsOfAlts:debugMsg("found categoryS")
    end
	end
  if(not foundC or nextC or categoryS==ElderScrollsOfAlts.savedVariables.selected.category) then
    ElderScrollsOfAlts:debugMsg("reset category to All")
    ElderScrollsOfAlts.savedVariables.selected.category = "All"
  end
  ElderScrollsOfAlts:GuiSetupCategoryButton(self)  
  ElderScrollsOfAlts:SetupGui2(self)
end

--
function ElderScrollsOfAlts:GuiSetupDropdownA(self)
  ElderScrollsOfAlts.debugMsg("GuiSetupDropdownA Called!")
	ESOA_GUI2_Header_DropdownSelA.comboBox = ESOA_GUI2_Header_DropdownSelA.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_Header_DropdownSelA)
	local comboBox = ESOA_GUI2_Header_DropdownSelA.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
  
  local function OnItemSelect(_, choiceText, choice)
		--ElderScrollsOfAlts:doCharacterSelected(choiceText, choice) --getQualityDict()[choiceText])
		--PlaySound(SOUNDS.POSITIVE_CLICK)
	end
  
  local validChoices =  ElderScrollsOfAlts:ListOfCategories(true)
  --table.insert(validChoices, "All")
  --table.insert(validChoices, "A")
  --table.insert(validChoices, "B")
  
  local categoryS = ElderScrollsOfAlts.savedVariables.selected.category
  --local selNum = nil
  for i = 1, #validChoices do
		local entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect)
		comboBox:AddItem(entry)
	end
  comboBox:SelectFirstItem()
  --ESOA_GUI2_Header_DropdownSelA:SetHidden(false)
  if(categoryS~=nil) then
    comboBox:SetSelectedItem(categoryS)
  end
end

--ESOA_GUI2
-- Setup Display of addon data 
function ElderScrollsOfAlts:SetupGui2(self)
  ElderScrollsOfAlts:debugMsg("SetupGui2 Called!")
  
  ESOATooltip:SetParent(PopupTooltipTopLevel)
  ESOACraftTooltip:SetParent(PopupTooltipTopLevel)
  ESOAEquipTooltip:SetParent(PopupTooltipTopLevel)
  --ElderScrollsOfAlts:GuiSetupDropdownA()
  
  local pName = GetUnitName("player")
  local sVal = zo_strformat("(<<C:1>>)", pName )
  ESOA_GUI2_Header_WhoAmI:SetText(sVal)

  if( not ElderScrollsOfAlts.altData.beta ) then 
    ESOA_GUI2_Header_View_Misc2:SetHidden(true)
  end
  ElderScrollsOfAlts:GuiSetupCategoryButton(self)
  
  ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI2_Body_CharList)
  ElderScrollsOfAlts:SetupGuiEquipListing(self, ESOA_GUI2_Body_List_EQUIP)
  ElderScrollsOfAlts:SetupGuiResearchListing(self, ESOA_GUI2_Body_List_Research)
  ElderScrollsOfAlts:SetupGuiMisc2Listing(self, ESOA_GUI2_Body_List_Misc2)
end

--SetupGui2
function ElderScrollsOfAlts:SetupGuiResearchListing(self, dataListing)
  local NOTE_TYPE = 3
  local scroll_data = ZO_ScrollList_GetDataList(dataListing)
	ZO_ScrollList_Clear(dataListing) --#scroll_data)
	--ZO_ClearNumericallyIndexedTable(scroll_data)
	ZO_ScrollList_AddDataType(dataListing, NOTE_TYPE, "ESOA_RowTemplate_Research", 20,
		function(control, data)
			ElderScrollsOfAlts:SetupRowControlResearch(control, data)
		end
	)
	ZO_ScrollList_AddCategory(dataListing, 1, nil)
	ZO_ScrollList_AddResizeOnScreenResize(dataListing)
  
  ZO_ScrollList_EnableSelection(dataListing, "ESOA_RowTemplate_Highlight")
  --ElderScrollsOfAlts.SelectCharacterRowCallback )  
  ZO_ScrollList_EnableHighlight(dataListing, "ESOA_RowTemplate_Highlight")
  --ZO_ScrollList_SetTypeSelectable(dataListing, NOTE_TYPE, true)
  --ZO_ScrollList_SetAutoSelect(dataListing, true)
  ZO_ScrollList_SetDeselectOnReselect(dataListing, true)
  
	local playerLines = ElderScrollsOfAlts:SetupGuiResearchPlayerLines()
  ElderScrollsOfAlts:createAndSetupScrollData(scroll_data,playerLines,NOTE_TYPE)
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	--dataListing:SetHidden(false)
end

--SetupGui2
function ElderScrollsOfAlts:SetupGuiMisc2Listing(self, dataListing)
  local NOTE_TYPE = 4
  local scroll_data = ZO_ScrollList_GetDataList(dataListing)
	ZO_ScrollList_Clear(dataListing) --#scroll_data)
	--ZO_ClearNumericallyIndexedTable(scroll_data)
	ZO_ScrollList_AddDataType(dataListing, NOTE_TYPE, "ESOA_RowTemplate_Misc2", 20,
		function(control, data)
			ElderScrollsOfAlts:SetupRowControlMisc2(control, data)
		end
	)
	ZO_ScrollList_AddCategory(dataListing, 1, nil)
	ZO_ScrollList_AddResizeOnScreenResize(dataListing)
  
  ZO_ScrollList_EnableSelection(dataListing, "ESOA_RowTemplate_Highlight")
  --ElderScrollsOfAlts.SelectCharacterRowCallback )  
  ZO_ScrollList_EnableHighlight(dataListing, "ESOA_RowTemplate_Highlight")
  --ZO_ScrollList_SetTypeSelectable(dataListing, NOTE_TYPE, true)
  --ZO_ScrollList_SetAutoSelect(dataListing, true)
  ZO_ScrollList_SetDeselectOnReselect(dataListing, true)
  
	local playerLines = ElderScrollsOfAlts:SetupGuiMisc2PlayerLines()
  
	for k, v in pairs(playerLines) do
		--ElderScrollsOfAlts:debugMsg(" playerLines k " .. tostring(k)  )
		--ElderScrollsOfAlts:debugMsg(" playerLines v " .. tostring(v)  )	
    scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, v )
	end
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	--dataListing:SetHidden(false)
end

--SetupGui2
function ElderScrollsOfAlts:SetupGuiEquipListing(self, dataListing)
  local NOTE_TYPE = 2
  local scroll_data = ZO_ScrollList_GetDataList(dataListing)
	ZO_ScrollList_Clear(dataListing) --#scroll_data)
	--ZO_ClearNumericallyIndexedTable(scroll_data)
	ZO_ScrollList_AddDataType(dataListing, NOTE_TYPE, "ESOA_RowTemplate_EQUIP", 20,
		function(control, data)
			ElderScrollsOfAlts:SetupRowControlEquip(control, data)
		end
	)
	ZO_ScrollList_AddCategory(dataListing, 1, nil)
	ZO_ScrollList_AddResizeOnScreenResize(dataListing)
  
  ZO_ScrollList_EnableSelection(dataListing, "ESOA_RowTemplate_Highlight")
  --ElderScrollsOfAlts.SelectCharacterRowCallback )  
  ZO_ScrollList_EnableHighlight(dataListing, "ESOA_RowTemplate_Highlight")
  --ZO_ScrollList_SetTypeSelectable(dataListing, NOTE_TYPE, true)
  --ZO_ScrollList_SetAutoSelect(dataListing, true)
  ZO_ScrollList_SetDeselectOnReselect(dataListing, true)
  
	local playerLines = ElderScrollsOfAlts:SetupGuiEquipPlayerLines()
  ElderScrollsOfAlts:createAndSetupScrollData(scroll_data,playerLines,NOTE_TYPE)
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	--dataListing:SetHidden(false)
end

function ElderScrollsOfAlts:createAndSetupScrollData(scroll_data, playerLines, NOTE_TYPE)
	for k, v in pairs(playerLines) do
    local categoryS = ElderScrollsOfAlts.savedVariables.selected.category
    if(categoryS==nil)then
      categoryS="All"
    end
    if(categoryS~=nil and categoryS~="All") then
      local catP = v.category
      if(categoryS==catP) then
        scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, v )
      end
    else
		--ElderScrollsOfAlts:debugMsg(" playerLines k " .. tostring(k)  )
		--ElderScrollsOfAlts:debugMsg(" playerLines v " .. tostring(v)  )	
      scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, v )
    end
	end
  return scroll_data
end

--SetupGui2
function ElderScrollsOfAlts:SetupGuiCharListing(self, dataListing)
	local NOTE_TYPE = 1
	--local indexContainer = window:GetNamedChild("ESOA_GUI_PAGE1_List")
	local scroll_data = ZO_ScrollList_GetDataList(dataListing)
	ZO_ScrollList_Clear(dataListing) --#scroll_data)
	--ZO_ClearNumericallyIndexedTable(scroll_data)
	ZO_ScrollList_AddDataType(dataListing, NOTE_TYPE, "ESOA_RowTemplate", 20,
		function(control, data)
			ElderScrollsOfAlts:SetupRowControl(control, data)
		end
	)
	ZO_ScrollList_AddCategory(dataListing, 1, nil)
	ZO_ScrollList_AddResizeOnScreenResize(dataListing)
  
  ZO_ScrollList_EnableSelection(dataListing, "ESOA_RowTemplate_Highlight")
  --ElderScrollsOfAlts.SelectCharacterRowCallback )  
  ZO_ScrollList_EnableHighlight(dataListing, "ESOA_RowTemplate_Highlight")
  --ZO_ScrollList_SetTypeSelectable(dataListing, NOTE_TYPE, true)
  --ZO_ScrollList_SetAutoSelect(dataListing, true)
  ZO_ScrollList_SetDeselectOnReselect(dataListing, true)
  
	local playerLines = ElderScrollsOfAlts:SetupGuiPlayerLines()
  ElderScrollsOfAlts:createAndSetupScrollData(scroll_data,playerLines,NOTE_TYPE)
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	--dataListing:SetHidden(false)
end

--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControlSunk(row_control, row_data, uiname, rowname, sunk, sunk2)
  if row_control == nil then
    ElderScrollsOfAlts:debugMsg("SetupRowControlSunk: row_control is nil!")
    return
  end
  if row_data == nil then
    ElderScrollsOfAlts:debugMsg("SetupRowControlSunk: row_data is nil!")
    return
  end
  --d("SetupRowControlSunk: uiname="..tostring(uiname).." rowname="..tostring(rowname).." sunk="..tostring(sunk) )
  local rdval = row_data[rowname]
  if rdval == nil then
    ElderScrollsOfAlts:debugMsg("SetupRowControlSunk: row_data val is nil!")
    return
  end
  row_control:GetNamedChild(uiname).data_val   = rdval
  row_control:GetNamedChild(uiname).data_sunk  = sunk  
  row_control:GetNamedChild(uiname).data_sunk2 = sunk2
  if sunk ~=nil and sunk > 0 then
    row_control:GetNamedChild(uiname):SetText(rdval.."("..sunk..")" )      
  else
    row_control:GetNamedChild(uiname):SetText(rdval .. "  ")
  end
end

--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControlResearch(row_control, row_data, scrollList)    
  local pName = GetUnitName("player")
  local rName = row_data["name"]
  row_control:GetNamedChild('Name'):SetText(row_data["name"])
  if(pName==rName) then
    row_control:GetNamedChild('Name').isMe = true
  else
    row_control:GetNamedChild('Name').isMe = false
  end
  
  local rTypes = {
    ["Cloth"] = "clothier",
    ["Wood"]  = "woodworking",
    ["Smith"] = "blacksmithing",
    ["Jewel"] = "jewelcrafting",
  }
  for rtK,rtV in pairs(rTypes) do
    local mKint = 1
    for mKint = 1, 3 do
      local mKye0 = string.format("%s%s",rtK,mKint)
      local mKye1 = string.format("%s%s%s%s","r",rtV,mKint,"time")
      local mKye2 = string.format("%s%s%s%s","r",rtV,mKint,"name")
      local mKye3 = string.format("%s%s%s%s","r",rtV,mKint,"TraitType")
      local mKye4 = string.format("%s%s%s%s","r",rtV,mKint,"TraitDesc")
      local mKye5 = string.format("%s%s%s%s","r",rtV,mKint,"Traitknown")
      row_control:GetNamedChild(mKye0):SetText(row_data[mKye1])
      row_control:GetNamedChild(mKye0).name       = row_data[mKye2]
      row_control:GetNamedChild(mKye0).traitType  = row_data[mKye3]
      row_control:GetNamedChild(mKye0).traitDesc  = row_data[mKye4]
      row_control:GetNamedChild(mKye0).traitknown = row_data[mKye5]
    end
  end  
end

--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControlMisc2(row_control, row_data, scrollList)  
  --
end

--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControlEquip(row_control, row_data, scrollList)    
  local pName = GetUnitName("player")
  local rName = row_data["name"]
  row_control:GetNamedChild('Name'):SetText(row_data["name"])
  if(pName==rName) then
    row_control:GetNamedChild('Name').isMe = true
  else
    row_control:GetNamedChild('Name').isMe = false
  end
    
  row_control:GetNamedChild('Head'):SetText(row_data["Head"])
  row_control:GetNamedChild('Head').itemlink = row_data["Head_Link"]
  row_control:GetNamedChild('Shoulders'):SetText(row_data["Shoulders"])
  row_control:GetNamedChild('Shoulders').itemlink = row_data["Shoulders_Link"]  
  row_control:GetNamedChild('Chest'):SetText(row_data["Chest"])
  row_control:GetNamedChild('Chest').itemlink = row_data["Chest_Link"]
  row_control:GetNamedChild('Waist'):SetText(row_data["Waist"])
  row_control:GetNamedChild('Waist').itemlink = row_data["Waist_Link"]
  row_control:GetNamedChild('Legs'):SetText(row_data["Legs"])
  row_control:GetNamedChild('Legs').itemlink = row_data["Legs_Link"]
  row_control:GetNamedChild('Hands'):SetText(row_data["Hands"])
  row_control:GetNamedChild('Hands').itemlink = row_data["Hands_Link"]
  row_control:GetNamedChild('Feet'):SetText(row_data["Feet"])
  row_control:GetNamedChild('Feet').itemlink = row_data["Feet_Link"]
  
  row_control:GetNamedChild('Neck'):SetText(row_data["Neck"])
  row_control:GetNamedChild('Neck').itemlink = row_data["Neck_Link"]
  row_control:GetNamedChild('Ring1'):SetText(row_data["Ring1"])
  row_control:GetNamedChild('Ring1').itemlink = row_data["Ring1_Link"]
  row_control:GetNamedChild('Ring2'):SetText(row_data["Ring2"])
  row_control:GetNamedChild('Ring2').itemlink = row_data["Ring2_Link"]
  
  row_control:GetNamedChild('M1'):SetText(row_data["M1"])
  row_control:GetNamedChild('M1').itemlink = row_data["M1_Link"]
  row_control:GetNamedChild('M2'):SetText(row_data["M2"])
  row_control:GetNamedChild('M2').itemlink = row_data["M2_Link"]
  row_control:GetNamedChild('Mp'):SetText(row_data["Mp"])
  row_control:GetNamedChild('Mp').itemlink = row_data["Mp_Link"]
  
  row_control:GetNamedChild('O1'):SetText(row_data["O1"])
  row_control:GetNamedChild('O1').itemlink = row_data["O1_Link"]
  row_control:GetNamedChild('O2'):SetText(row_data["O2"])
  row_control:GetNamedChild('O2').itemlink = row_data["O2_Link"]
  row_control:GetNamedChild('Op'):SetText(row_data["Op"])
  row_control:GetNamedChild('Op').itemlink = row_data["Op_Link"]
  
  row_control:GetNamedChild('Heavy' ):SetText(row_data["heavy"])
  row_control:GetNamedChild('Medium'):SetText(row_data["medium"])
  row_control:GetNamedChild('Light' ):SetText(row_data["light"])
end

--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControl(row_control, row_data, scrollList)
  local pName = GetUnitName("player")
  local rName = row_data["name"]
  row_control:GetNamedChild('Name'):SetText(row_data["name"])
  if(pName==rName) then
    row_control:GetNamedChild('Name').isMe = true
  else
    row_control:GetNamedChild('Name').isMe = false
  end
  
  row_control:GetNamedChild('Gender'):SetText(ElderScrollsOfAlts:GetGenderText(row_data["gender"]))    
  if row_data["champion"] == nil then
    row_control:GetNamedChild('Level'):SetText(row_data["level"])
  else
    row_control:GetNamedChild('Level'):SetText( row_data["level"] .."("..row_data["champion"]..")" )      
  end
  
  row_control:GetNamedChild('Class'):SetText( ElderScrollsOfAlts:GetClassText(row_data["class"]) )
  row_control:GetNamedChild('Race'):SetText(  ElderScrollsOfAlts:GetRaceText1(row_data["race"]) )    
  --ElderScrollsOfAlts:GetAllianceIcon(alliance)
  --local pAlliance = GetUnitAlliance("player")
  --ElderScrollsOfAlts.altData.players[pName].bio.allianceId = pAlliance    
  local pAlliance = row_data["alliance"]
  row_control:GetNamedChild('Alliance').alliance = pAlliance
  if pAlliance ~= nil then
    local pAllIcon = ElderScrollsOfAlts:GetAllianceIcon(pAlliance);
    row_control:GetNamedChild('Alliance'):SetTexture(pAllIcon)      
  end
 
  local sunk2 = nil
  local sunk = row_data["alchemy_sunk"]
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Alchemy',"alchemy",sunk)
  sunk = row_data["blacksmithing_sunk"]
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Blacksmithing',"blacksmithing",sunk)
  sunk = row_data["clothing_sunk"]
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Clothing',"clothing",sunk)
  sunk = row_data["enchanting_sunk"]
  sunk2 = row_data["enchanting_sunk2"]
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Enchanting',"enchanting",sunk,sunk2)
  sunk = row_data["jewelry_sunk"]
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Jewelry',"jewelry",sunk)
  sunk = row_data["provisioning_sunk"]    
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Provisioning',"provisioning",sunk)
  sunk = row_data["woodworking_sunk"]        
  ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Woodworking',"woodworking",sunk)    
  --Werewolf / Vampire
  local werewolf = row_data["Werewolf"]
  local vampire  = row_data["Vampire"] 
  row_control:GetNamedChild("_Super").super = 0
  row_control:GetNamedChild("_Super"):SetHidden(true)
  if werewolf then
    row_control:GetNamedChild("_Super"):SetHidden(false)
    row_control:GetNamedChild("_Super").super = 1
    row_control:GetNamedChild("_Super"):SetTexture("/esoui/art/icons/store_werewolfbite_01.dds")
  end
  if vampire then
    row_control:GetNamedChild("_Super"):SetHidden(false)
    row_control:GetNamedChild("_Super"):SetTexture("/esoui/art/icons/store_vampirebite_01.dds")
    row_control:GetNamedChild("_Super").super = 2
  end
    
  --Misc
  local bu = row_data["backpackUsed"] 
  local bs = row_data["backpackSize"] 
  if bs == nil then bs = "---" end
  local bagText = bu .."/".. bs .."("..bs-bu..")"
  row_control:GetNamedChild('BagSpace'):SetText(bagText)
  --playerLines[k].backpackSize = 0
  --playerLines[k].backpackUsed = 0
    
  --row_control:GetNamedChild("Name"):SetText(GetMoneyName(data))
  --local fieldColor = STATUS_COLORS[data.key] or defaultColor
  --sKey:SetColor(fieldColor:UnpackRGBA())
  --ZO_SortFilterList.SetupRow(self, control, data)
end

--ESOACraftTooltip MAIN Tooltip
function ElderScrollsOfAlts:TooltipEnter(mySelf,tooltipName)  
  ElderScrollsOfAlts.debugMsg("TooltipEnter: tooltipName='"..tostring(tooltipName).."'")
  if( tooltipName == nil ) then return end 
  local tooltipDesc  = nil
  local tooltipTitle = nil
  if(tooltipName=="Alliance") then
    local nAliance = tonumber(mySelf.alliance)
    if( nAliance == nil ) then return end
    local aName = GetAllianceName(nAliance)
    tooltipDesc  = aName
    --tooltipTitle = ""
    --local hdrStr = string.format("%s (%s)", craftName, nVal)
  elseif(tooltipName=="Super") then
    local nSuper = tonumber(mySelf.super)
    --d("TooltipEnter: nSuper='"..tostring(nSuper).."'")
    if( nSuper == nil or nSuper == 0 ) then return end
    if( nSuper == 1 ) then
      tooltipDesc  = "Werewolf"  
    elseif( nSuper == 2 ) then
      tooltipDesc  = "Vampire"
    end
  end
  ElderScrollsOfAlts.debugMsg("TooltipEnter: tooltipDesc='"..tostring(tooltipDesc).."' tooltipTitle='"..tostring(tooltipTitle).."'")
  if( tooltipDesc == nil and tooltipTitle == nil) then return end 
  InitializeTooltip(ESOATooltip, mySelf, TOPLEFT, 5, -66, TOPRIGHT)
  if tooltipTitle ~= nil then
    ESOATooltip:AddLine(tooltipTitle, "ZoFontGameBold")
  end
  ESOATooltip:AddLine(tooltipDesc, "ZoFontGame")
end

function ElderScrollsOfAlts:TooltipExit(myLabel,craftName)  
  ClearTooltip(ESOATooltip)
end
--ESOACraftTooltip CRAFT Tooltip
function ElderScrollsOfAlts:CraftTipEnter(myLabel,craftName)  
  if( craftName == nil ) then return end 
  local nVal = tonumber(myLabel.data_sunk)
  if( nVal == nil ) then return end 
  local nVal2 = nil  
  if( myLabel.data_sunk ~= nil ) then
    nVal2 = tonumber(myLabel.data_sunk2)
  end
  
  local tDesc = "Unknown"
  local tCraft = ElderScrollsOfAlts.Sunk_Tooltip[craftName]
  if(tCraft ~= nil) then
    tDesc = tCraft[nVal]
  end
  local tDesc2 = nil
  local craftName2 = string.format("%s%s",craftName,"2")
  local tCraft2 = ElderScrollsOfAlts.Sunk_Tooltip[craftName2]
  if(tCraft2 ~= nil) then
    tDesc2 = tCraft2[nVal]
  end

  --ElderScrollsOfAlts.debugMsg("tVal=" .. tostring(tVal) .." craftName=" .. tostring(craftName))  
  local hdrStr = string.format("%s (%s)", craftName, nVal)
  if( nVal2 ~= nil ) then
    hdrStr = string.format("%s (%s,%s)", craftName, nVal, nVal2)
  end
  
  InitializeTooltip(ESOATooltip, myLabel, TOPLEFT, 5, -66, TOPRIGHT)
  
  ESOATooltip:AddLine(hdrStr, "ZoFontGameBold")
  ESOATooltip:AddLine(tDesc, "ZoFontGame")
  if( tDesc2 ~= nil ) then
    ESOATooltip:AddLine(tDesc2, "ZoFontGame")
  end
end

--UI
function ElderScrollsOfAlts:CraftTipExit(myLabel)  
  ClearTooltip(ESOATooltip)
end

--UI
function ElderScrollsOfAlts:EquipShowTip(myLabel,equipName)
  local itemLink = myLabel.itemlink
  if(itemLink~=nil) then
    --d("EquipShowTip itemLink is set")
    ZO_PopupTooltip_SetLink(itemLink)
  else
    --d("EquipShowTip itemLink is nil")
  end
  --[[
  --Sends a link to chat
  --ZO_LinkHandler_InsertLink(zo_strformat(SI_TOOLTIP_ITEM_NAME, itemLink)) 
  ]]
end

--UI
function ElderScrollsOfAlts:ResearchTipEnter(myLabel,equipName)
  local itemLink = myLabel.name
  if(itemLink==nil) then
    return
  end
  InitializeTooltip(InformationTooltip, myLabel, TOPLEFT, 5, -56, TOPRIGHT)
  InformationTooltip:AddLine(string.format("(%s)",itemLink), "ZoFontGame")
  
  if(myLabel.traitType~=nil) then
    InformationTooltip:AddLine(string.format("(%s)"     , myLabel.traitType), "ZoFontGame")
    InformationTooltip:AddLine(string.format("Trait: %s", myLabel.traitDesc), "ZoFontGame")
    InformationTooltip:AddLine(string.format("(Known? %s)"     , tostring(myLabel.traitknown)), "ZoFontGame")
  end
end

--UI
function ElderScrollsOfAlts:ResearchTipExit(myLabel)  
  ClearTooltip(InformationTooltip)
end

--UI
function ElderScrollsOfAlts:ResearchShowTip(myLabel,equipName)
end

--ESOACraftTooltip EQUIP Tooltip
function ElderScrollsOfAlts:EquipTipEnter(myLabel,equipName)    
  local itemLink = myLabel.itemlink
  if(itemLink==nil) then
    return
  end
  --d("nVal=" .. tostring(nVal) .." equipName=" .. tostring(craftName))  
  local traitType, traitDescription = GetItemLinkTraitInfo(itemLink)
  local requiredLevel = GetItemLinkRequiredLevel(itemLink)
  local requiredCp = GetItemLinkRequiredChampionPoints(itemLink)
  local hasCharges, enchantHeader, enchantDescription = GetItemLinkEnchantInfo(itemLink)
  --hasAbility, abilityHeader, abilityDescription, cooldown, hasScaling, minLevel, maxLevel, isChampionPoints, remainingCooldown = GetItemLinkOnUseAbilityInfo(string itemLink)
  --hasAbility, abilityDescription, cooldown, hasScaling, minLevel, maxLevel, isChampionPoints  = GetItemLinkTraitOnUseAbilityInfo(string itemLink, number index)
  local hasSet, setName, numBonuses, numEquipped, maxEquipped, setId = GetItemLinkSetInfo(itemLink, true)
  --boolean hasSet, string setName, number numBonuses, number numEquipped, number maxEquipped, number setId  
  local flavorText  = GetItemLinkFlavorText(itemLink)

  InitializeTooltip(InformationTooltip, myLabel, TOPLEFT, 5, -56, TOPRIGHT)
  if( equipName ~= nil ) then
    InformationTooltip:AddLine(string.format("(%s)",equipName), "ZoFontGame")
  end
  --as equipName is the same in this context InformationTooltip:AddLine(itemLink, "ZoFontGame")
  if( traitType ~= nil) then
    local traitName = GetString("SI_ITEMTRAITTYPE", traitType)
    InformationTooltip:AddLine(itemLink, "ZoFontGame")    
    if(requiredCp>0) then
      InformationTooltip:AddLine(string.format("Level: %s CP:%s",requiredLevel,requiredCp), "ZoFontGame")
    else
      InformationTooltip:AddLine(string.format("Requires: %s",requiredLevel,requiredCp), "ZoFontGame")
    end
    if(enchantHeader ~= nil and enchantDescription ~= nil) then
      InformationTooltip:AddLine(enchantHeader, "ZoFontGame")
      InformationTooltip:AddLine(enchantDescription, "ZoFontGameSmall")
    end
    InformationTooltip:AddLine(traitName, "ZoFontGame")
    InformationTooltip:AddLine(traitDescription, "ZoFontGame")
    InformationTooltip:AddLine(flavorText, "ZoFontGameSmall")
    if(hasSet) then
      InformationTooltip:AddLine(string.format("Part of the: %s set (%s/%s items)",setName,numEquipped,maxEquipped), "ZoFontGame")
    end    
  end
  --InformationTooltip:AddItemTags(itemLink)
end

--UI
function ElderScrollsOfAlts:EquipTipExit(myLabel)  
  ClearTooltip(InformationTooltip)
end

--ESOATooltip EQUIP HEADER Tooltip
function ElderScrollsOfAlts:EquipHeaderTipEnter(sender,key)
  --InitializeTooltip(InformationTooltip, resultButton, TOPRIGHT, 0, 0, BOTTOMLEFT)
  InitializeTooltip(ESOATooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  --InitializeTooltip(ESOATooltip, sender, TOPLEFT, -10, -10, BOTTOMLEFT)
  ElderScrollsOfAlts:TraitTipLookupDesc(ESOATooltip,key)
  ESOATooltip:AddLine(key, "ZoFontHeader3")
  --SetTooltipText(ESOATooltip, "Test123" ZO_NORMAL_TEXT)
end

--UI
function ElderScrollsOfAlts:EquipHeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(ESOATooltip)
end

--UI
function ElderScrollsOfAlts:ResearchHeaderTipEnter(sender,key)
  InitializeTooltip(ESOATooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  --InitializeTooltip(ESOATooltip, sender, TOPLEFT, -10, -10, BOTTOMLEFT)
  --ElderScrollsOfAlts:TraitTipLookupDesc(ESOATooltip,key)
  ESOATooltip:AddLine(key, "ZoFontHeader3")
  --SetTooltipText(ESOATooltip, "Test123" ZO_NORMAL_TEXT)
end

--UI
function ElderScrollsOfAlts:ResearchHeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(ESOATooltip)
end

--UI
function ElderScrollsOfAlts:TraitTipLookupDesc(lTooltip,key)  
  --lTooltip:AddVerticalPadding(14)
  local ttld = {
    --["name"] = "Name",
    --["head"] = "Head",
  }
  if( ttld[key] ~= nil) then
    lTooltip:AddHeaderLine(ttld[key], "ZoFontGameLarge", 1, TOOLTIP_HEADER_SIDE_LEFT, ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())  
    --AddLineTitle(lTooltip, "test line 134", ZO_NORMAL_TEXT)
    --lTooltip:AddVerticalPadding(-9)
  end
end

--
function ElderScrollsOfAlts:SelectCharacterFromDropdown(dropdown)  
  local charname = dropdown.comboBox:GetSelectedItem()
  ElderScrollsOfAlts:debugMsg(" charname=" .. tostring(charname))
  ElderScrollsOfAlts.savedVariables.selected.charactername = charname
end

--
function ElderScrollsOfAlts:doCharacterSelected(choiceText, choice)
	ElderScrollsOfAlts:debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
  ElderScrollsOfAlts.savedVariables.selected.charactername = choiceText -- or choice??
end


--Row Select
function ElderScrollsOfAlts:SelectCharacterRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_CharList, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_CharList)  
  if selectedData ~= nil then
    ElderScrollsOfAlts:debugMsg("SelectCharacterRow: Name=" .. tostring(selectedData.name))
  else
    ElderScrollsOfAlts:debugMsg("SelectCharacterRow: selectedData is nil")
  end
end

--Row Select
function ElderScrollsOfAlts:SelectEquipRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_EQUIP, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_EQUIP)
  if selectedData ~= nil then
    ElderScrollsOfAlts:debugMsg("SelectEquipRow: Name=" .. tostring(selectedData.name))
  else
    ElderScrollsOfAlts:debugMsg("SelectEquipRow: selectedData= nil")
  end  
end

--Row Select
function ElderScrollsOfAlts:SelectResearchRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_Research, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_Research)
  if selectedData ~= nil then
    ElderScrollsOfAlts:debugMsg("SelectResearchRow: Name=" .. tostring(selectedData.name))
  else
    ElderScrollsOfAlts:debugMsg("SelectResearchRow: selectedData= nil")
  end  
end

--Row Select
function ElderScrollsOfAlts:SelectOtherRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_Research, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_Research)
  if selectedData ~= nil then
    ElderScrollsOfAlts:debugMsg("SelectResearchRow: Name=" .. tostring(selectedData.name))
  else
    ElderScrollsOfAlts:debugMsg("SelectResearchRow: selectedData= nil")
  end  
end
