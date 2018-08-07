-- GUI Elements (Setup and View Data)


--Switch to Home VIEW
function ElderScrollsOfAlts:GUIShowViewHome()
  ESOA_GUI2_Body_CharListHeader:SetHidden(false)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  ESOA_GUI2_Body_CharList:SetHidden(false)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(true)  	
  ElderScrollsOfAlts.savedVariables.currentView = "Home"
end
--Switch to Equip VIEW
function ElderScrollsOfAlts:GUIShowViewEquip()  
  ESOA_GUI2_Body_CharListHeader:SetHidden(true)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(false)
  ESOA_GUI2_Body_CharList:SetHidden(true)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(false)
  ElderScrollsOfAlts.savedVariables.currentView = "Equip"
end

--Gui2
function ElderScrollsOfAlts:onMoveStop()  
  ElderScrollsOfAlts.savedVariables.window.top    = ESOA_GUI2:GetTop()
  ElderScrollsOfAlts.savedVariables.window.left   = ESOA_GUI2:GetLeft()
  ElderScrollsOfAlts:debugMsg("Saved top and left")
  if not ElderScrollsOfAlts.savedVariables.window.minimized and not ElderScrollsOfAlts.savedVariables.window.justone then
    ElderScrollsOfAlts.savedVariables.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.savedVariables.window.height = ESOA_GUI2:GetHeight()  
    ElderScrollsOfAlts:debugMsg("Saved width and height")
  end
end

--Gui2
function ElderScrollsOfAlts:onResizeStart() 
  --
end

--Gui2
function ElderScrollsOfAlts:onResizeStop()
  --d("Resize start")
  --XX:GuiResizeScroll()
  --XX:UpdateInventoryScroll()
  if not ElderScrollsOfAlts.savedVariables.window.minimized and not ElderScrollsOfAlts.savedVariables.window.justone then
    ElderScrollsOfAlts.savedVariables.window.top    = ESOA_GUI2:GetTop()
    ElderScrollsOfAlts.savedVariables.window.left   = ESOA_GUI2:GetLeft()
    ElderScrollsOfAlts.savedVariables.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.savedVariables.window.height = ESOA_GUI2:GetHeight()
    ElderScrollsOfAlts:debugMsg("Saved width and height, top and left")
    --
    --update scroll height/width (has to be done manually?)
    --ESOA_GUI2_Body
    --<Anchor point="TOPLEFT"     relativeTo="$(parent)_Header" relativePoint="BOTTOMLEFT" />
    --<Anchor point="BOTTOMRIGHT" relativeTo="$(parent)" relativePoint="BOTTOMRIGHT" />
    --TODO ESOA_GUI2_Body:ClearAnchors()
    --ESOA_GUI2_Body:SetAnchor(TOPLEFT, "ESOA_GUI2_Header", TOPLEFT, 
    --  ElderScrollsOfAlts.savedVariables.window.left, ElderScrollsOfAlts.savedVariables.window.top)
    --TODO ESOA_GUI2_Body:SetAnchor(BOTTOMRIGHT, "ESOA_GUI2", BOTTOMRIGHT)    
    --ESOA_GUI2_Body_CharList
    
    -- Test2
    --ESOA_GUI2_Body:SetAnchor(BOTTOMRIGHT, "$(parent)", BOTTOMRIGHT)    
    --ESOA_GUI2_Body_CharList:SetAnchor(BOTTOMRIGHT, "$(parent)", 0,200 )    
    -- Test3
    ESOA_GUI2_Header:SetWidth( ESOA_GUI2:GetWidth() )
    ZO_ScrollList_SetHeight(ESOA_GUI2_Body_CharList, ESOA_GUI2_Body:GetHeight())
    ZO_ScrollList_UpdateScroll(ESOA_GUI2_Body_CharList)
    ZO_ScrollList_Commit(ESOA_GUI2_Body_CharList)  
    --d("Resize done")
  end
end

--Gui2
function ElderScrollsOfAlts:GUI2Minimize(bMin)
  ElderScrollsOfAlts:debugMsg("GUI2Minimize Called, bMin="..tostring(bMin) )
  ElderScrollsOfAlts.savedVariables.window.minimized = bMin
  
  if ElderScrollsOfAlts.savedVariables.window.minlevel == nil then
    ElderScrollsOfAlts.savedVariables.window.minlevel = 0
  end
  
  if bMin then
    ElderScrollsOfAlts.savedVariables.window.minlevel = ElderScrollsOfAlts.savedVariables.window.minlevel + 1
  else
    ElderScrollsOfAlts.savedVariables.window.minlevel = ElderScrollsOfAlts.savedVariables.window.minlevel - 1
  end
  --d("MinLevel=" .. tostring(ElderScrollsOfAlts.savedVariables.window.minlevel) )
  
  if ElderScrollsOfAlts.savedVariables.window.minlevel == nil or ElderScrollsOfAlts.savedVariables.window.minlevel == 0 then
    --
  else
    --
  end  
  
  --Header
  ESOA_GUI2_Header_Minimize:SetHidden(bMin)
  ESOA_GUI2_Header_Maximize:SetHidden(not bMin)  
  --Body
  ESOA_GUI2_Body_CharListHeader:SetHidden(bMin)
  ESOA_GUI2_Body_Divider:SetHidden(bMin)
  ESOA_GUI2_Body_CharList:SetHidden(bMin)
  --Sizing
  if bMin then
    --ElderScrollsOfAlts.savedVariables.window.restoreheight = ESOA_GUI2:GetHeight()
    ESOA_GUI2:SetHeight(20)
  else
    ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
    ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data   
    ElderScrollsOfAlts:Gui2SortRefresh()

    --local rHt = ElderScrollsOfAlts.savedVariables.window.restoreheight
    --if rHt == nil then
    --  rHt = ElderScrollsOfAlts.savedVariables.window.height
    --end    
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.savedVariables.window.height)
  end  
end

--Gui2
function ElderScrollsOfAlts:GUI2Lock(bLock)
  --d("GUI2Lock bLock: "..tostring(bLock) )
	ESOA_GUI2_Header_Locked:SetHidden(not bLock)
	ESOA_GUI2_Header_Unlocked:SetHidden(bLock)
	ESOA_GUI2:SetMovable(not bLock)

	if bLock then
		ESOA_GUI2:SetResizeHandleSize(0)
	else
		ESOA_GUI2:SetResizeHandleSize(10)
	end
end

--Gui2
function ElderScrollsOfAlts.HideGui2()
    ESOA_GUI2:SetHidden(true)
end

--Gui2
function ElderScrollsOfAlts.ShowGui2()
  if not ESOA_GUI2:IsHidden() then 
    ESOA_GUI2:SetHidden(true)
  else
    ESOA_GUI2:SetHidden(false)
    if ElderScrollsOfAlts.savedVariables.window.minimized then
      ElderScrollsOfAlts:GUI2Minimize(false)  
    end  
    if ElderScrollsOfAlts.savedVariables.window.justone then
      --ElderScrollsOfAlts:GUI2Iconify(false)
    end    
  end
	--local settings = IIfA:GetSceneSettings()
	--settings.hidden = true
  if ElderScrollsOfAlts.savedVariables.window.top ~= nil then
    local left = ElderScrollsOfAlts.savedVariables.window.left
    local top = ElderScrollsOfAlts.savedVariables.window.top
    ESOA_GUI2:ClearAnchors()
    ESOA_GUI2:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.savedVariables.window.height)
    ESOA_GUI2:SetWidth( ElderScrollsOfAlts.savedVariables.window.width )
  else 
    ElderScrollsOfAlts.savedVariables.window.justone = false  
    ElderScrollsOfAlts.savedVariables.window.top    = ESOA_GUI2:GetTop()
    ElderScrollsOfAlts.savedVariables.window.left   = ESOA_GUI2:GetLeft()
    ElderScrollsOfAlts.savedVariables.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.savedVariables.window.height = ESOA_GUI2:GetHeight()
  end
  
  --TODO view
  ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(true)
  --ESOA_GUI2_Body_CharListHeader:SetHidden(bMin)
  --ESOA_GUI2_Body_CharList:SetHidden(bMin)
end

--Gui2
-- Setup Display of addon data 
function ElderScrollsOfAlts:SetupGui2(self)
  ElderScrollsOfAlts:debugMsg("SetupGui2 Called!")
  
  ESOATooltip:SetParent(PopupTooltipTopLevel)
  ESOACraftTooltip:SetParent(PopupTooltipTopLevel)
  ESOAEquipTooltip:SetParent(PopupTooltipTopLevel)
  --if( ElderScrollsOfAlts.altData.beta) then
  --  ESOA_GUI2_Header_Dropdown.comboBox = ESOA_GUI2_Header_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_Header_Dropdown)
  --  local comboBox = ESOA_GUI2_Header_Dropdown.comboBox
  --  comboBox:ClearItems()
  --  comboBox:SetSortsItems(false)
  --  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI2_Header_Dropdown)
  --end
  ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI2_Body_CharList)
  ElderScrollsOfAlts:SetupGuiEquipListing(self, ESOA_GUI2_Body_List_EQUIP)
end

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

-- dropdown USED?
function ElderScrollsOfAlts:GuiSetupDropdown(dropdown)
	--local selectedItem = ElderScrollsOfAlts:GetInventoryListFilter()
	--dropdown.comboBox:SetSelectedItem(selectedItem)
end

--Shared Gui
function ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, dropDown)
	local function OnItemSelect(_, choiceText, choice)
    --d("SetupGuiCharDropDown called")
		ElderScrollsOfAlts:doCharacterSelected(choiceText, choice) --getQualityDict()[choiceText])
		PlaySound(SOUNDS.POSITIVE_CLICK)
	end
	--local firstName = ElderScrollsOfAlts.altData.players[1]
	local validChoices =  {}
	table.insert(validChoices, "Select")
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
		--d(ElderScrollsOfAlts.name .. " k " .. k)
		table.insert(validChoices, ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k ))
	end
	--table.insert(validChoices, getColoredString(ITEM_QUALITY_TRASH, "Junk"))
	--table.insert(validChoices, getColoredString(ITEM_QUALITY_NORMAL, "Normal"))
	for i = 1, #validChoices do
		local entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect)
		--d(ElderScrollsOfAlts.name .. "entry ".. tostring(entry) ) -- Prints to chat.
		comboBox:AddItem(entry)
		--if qualityDict[validChoices[i]] == IIfA:GetInventoryListFilterQuality() then
		--	comboBox:SetSelectedItem(validChoices[i])
		--end
	end
	comboBox:SetSelectedItem("Select")
	dropDown:SetHidden(false)
end

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
  
	for k, v in pairs(playerLines) do
		--ElderScrollsOfAlts:debugMsg(" playerLines k " .. tostring(k)  )
		--ElderScrollsOfAlts:debugMsg(" playerLines v " .. tostring(v)  )	
    scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, v )
	end
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	dataListing:SetHidden(false)
end

--Shared Gui
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
  
	--IIfA:GuiResizeScroll()
	--IIfA:RefreshInventoryScroll()
	--local TYPE_ID = NOTE_TYPE
	--local entries = storage:GetKeys()
	--for i=1, #entries do
	--    scrollData[#scrollData + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, {key = entries[i]})
	--end
	local playerLines = ElderScrollsOfAlts:SetupGuiPlayerLines()
  
	for k, v in pairs(playerLines) do
		--ElderScrollsOfAlts:debugMsg(" playerLines k " .. tostring(k)  )
		--ElderScrollsOfAlts:debugMsg(" playerLines v " .. tostring(v)  )	
    scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, v )
	end
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	dataListing:SetHidden(false)
end

--Shared Gui
function ElderScrollsOfAlts:SetupRowControlSunk(row_control, row_data, uiname, rowname, sunk)
  if row_control == nil then
    d("SetupRowControlSunk: row_control is nil!")
    return
  end
  if row_data == nil then
    d("SetupRowControlSunk: row_data is nil!")
    return
  end
  --d("SetupRowControlSunk: uiname=".. tostring(uiname) .. " rowname=".. tostring(rowname) .. " sunk=".. tostring(sunk) )
  row_control:GetNamedChild(uiname).data_val = row_data[rowname]
  row_control:GetNamedChild(uiname).data_sunk = sunk  
  if sunk ~=nil and sunk > 0 then
      row_control:GetNamedChild(uiname):SetText(row_data[rowname].."("..sunk..")" )      
  else
    row_control:GetNamedChild(uiname):SetText(row_data[rowname] .. "  ")
  end
end


--Shared Gui
--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControlEquip(row_control, row_data, scrollList)    
  row_control:GetNamedChild('Name'):SetText(row_data["name"])
  
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

--Shared Gui
--For each row in the SCROLLLIST
function ElderScrollsOfAlts:SetupRowControl(row_control, row_data, scrollList)
  --ElderScrollsOfAlts:debugMsg(" SetupRowControl=" .. tostring(row_control) .. " row_data=" .. tostring(row_data) )
  --for k, v in pairs(row_data) do
    --ElderScrollsOfAlts:debugMsg(" key= " .. k)
    ----d(ElderScrollsOfAlts.name .. " v1_ " .. tostring(v["_Name"]))
    ----d(ElderScrollsOfAlts.name .. " v1  " .. tostring(v["Name"]))
  --end
    --d(ElderScrollsOfAlts.name .. " tbl: " ..ElderScrollsOfAlts:dump(row_data) )
    --row_control.row_data = row_data

    --if (row_data[1] == nil) then
    --    d("just starting up so just bail out")
    --    return
    --end
    --d("process row data...")

    row_control:GetNamedChild('Name'):SetText(row_data["name"])
    row_control:GetNamedChild('Gender'):SetText(ElderScrollsOfAlts:GetGenderText(row_data["gender"]))    
    if row_data["champion"] == nil then
      row_control:GetNamedChild('Level'):SetText(row_data["level"])
    else
      row_control:GetNamedChild('Level'):SetText( row_data["level"] .."("..row_data["champion"]..")" )      
    end
    
    row_control:GetNamedChild('Class'):SetText( ElderScrollsOfAlts:GetClassText(row_data["class"]) )
    row_control:GetNamedChild('Race'):SetText(  ElderScrollsOfAlts:GetRaceText1(row_data["race"]) )
          ElderScrollsOfAlts:GetAllianceIcon(alliance)
    --local pAlliance = GetUnitAlliance("player")
    --ElderScrollsOfAlts.altData.players[pName].bio.allianceId = pAlliance    
    local pAlliance = row_data["alliance"]
    if pAlliance == nil then
      --
    else 
      local pAllIcon = ElderScrollsOfAlts:GetAllianceIcon(pAlliance);
      row_control:GetNamedChild('Alliance'):SetTexture(pAllIcon)      
    end
 
    local sunk = row_data["alchemy_sunk"]
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Alchemy',"alchemy",sunk)
    sunk = row_data["blacksmithing_sunk"]
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Blacksmithing',"blacksmithing",sunk)
    sunk = row_data["clothing_sunk"]
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Clothing',"clothing",sunk)
    sunk = row_data["enchanting_sunk"]
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Enchanting',"enchanting",sunk)
    sunk = row_data["jewelry_sunk"]
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Jewelry',"jewelry",sunk)
    sunk = row_data["provisioning_sunk"]    
    --row_control:GetNamedChild('Provisioning'):SetText(row_data["provisioning"])
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Provisioning',"provisioning",sunk)
    sunk = row_data["woodworking_sunk"]        
    ElderScrollsOfAlts:SetupRowControlSunk(row_control,row_data,'Woodworking',"woodworking",sunk)    
    --Werewolf / Vampire
    local werewolf = row_data["Werewolf"]
    local vampire  = row_data["Vampire"] 
    if werewolf then
      row_control:GetNamedChild("_Icon2"):SetHidden(false)
      --row_control:GetNamedChild("_Icon2"):SetTextureFile(
      --"/esoui/art/icons/store_werewolfbite_01.dds")
    else
      row_control:GetNamedChild("_Icon2"):SetHidden(true)
    end
    if vampire then
      row_control:GetNamedChild("_Icon1"):SetHidden(false)
    else
      row_control:GetNamedChild("_Icon1"):SetHidden(true)
    end
    
    --Misc
    local bu = row_data["backpackUsed"] 
    local bs = row_data["backpackSize"] 
    if bs == nil then bs = "---" end
    local bagText = bu .."/".. bs
    row_control:GetNamedChild('BagSpace'):SetText(bagText)
    --playerLines[k].backpackSize = 0
    --playerLines[k].backpackUsed = 0
      
    --row_control:GetNamedChild("Name"):SetText(GetMoneyName(data))
    --local fieldColor = STATUS_COLORS[data.key] or defaultColor
    --sKey:SetColor(fieldColor:UnpackRGBA())
    --ZO_SortFilterList.SetupRow(self, control, data)
end

--ESOACraftTooltip CRAFT Tooltip
function ElderScrollsOfAlts:CraftTipEnter(myLabel,craftName)  
  if( craftName == nil ) then return end 
  local nVal = tonumber(myLabel.data_sunk)
  local tDesc = "Unknown"
  local tCraft = ElderScrollsOfAlts.Sunk_Tooltip[craftName]
  if(tCraft ~= nil) then
    tDesc = tCraft[nVal]
  end
  if( nVal == nil ) then return end 
  --ElderScrollsOfAlts.debugMsg("tVal=" .. tostring(tVal) .." craftName=" .. tostring(craftName))  
  local hdrStr = string.format("%s (%s)", craftName, nVal)
  InitializeTooltip(ESOATooltip, myLabel, TOPLEFT, 5, -66, TOPRIGHT)
  
  ESOATooltip:AddLine(hdrStr, "ZoFontGameBold")
  ESOATooltip:AddLine(tDesc, "ZoFontGame")
end
function ElderScrollsOfAlts:CraftTipExit(myLabel)  
  ClearTooltip(ESOATooltip)
end

function ElderScrollsOfAlts:EquipShowTip(myLabel,equipName)
  local itemLink = myLabel.itemlink
  if(itemLink~=nil) then
    d("EquipShowTip itemLink is set")
    ZO_PopupTooltip_SetLink(itemLink)
  else
    d("EquipShowTip itemLink is nil")
  end
  --[[
  --Sends a link to chat
  --ZO_LinkHandler_InsertLink(zo_strformat(SI_TOOLTIP_ITEM_NAME, itemLink)) 
  ]]
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
  InformationTooltip:AddLine(eLink, "ZoFontGame")
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
function ElderScrollsOfAlts:EquipHeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(ESOATooltip)
end
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

--Shared Gui
function ElderScrollsOfAlts:doCharacterSelected(choiceText, choice)
	ElderScrollsOfAlts:debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
  --ElderScrollsOfAlts:SetupGui3()
  ElderScrollsOfAlts.savedVariables.selected.charactername = choiceText -- or choice??
  ElderScrollsOfAlts.ShowGui3()
end

--Gui2
function ElderScrollsOfAlts:SelectCharacterRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_CharList, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_CharList)
  if selectedData ~= nil then
    ElderScrollsOfAlts:debugMsg("SelectCharacterRow: Name=" .. tostring(selectedData.name))
    ElderScrollsOfAlts:ShowGui3(selectedData)
  else
    ElderScrollsOfAlts:debugMsg("SelectCharacterRow: selectedData= nil")
  end  
end

--Gui2
function ElderScrollsOfAlts:SelectEquipRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_EQUIP, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_EQUIP)
  if selectedData ~= nil then
    ElderScrollsOfAlts:debugMsg("SelectEquipRow: Name=" .. tostring(selectedData.name))
    ElderScrollsOfAlts:ShowGui3(selectedData)
  else
    ElderScrollsOfAlts:debugMsg("SelectEquipRow: selectedData= nil")
  end  
end

--For use by Settings dropdown
function ElderScrollsOfAlts:SelectCharacterName(choiceText)
  ElderScrollsOfAlts.savedVariables.selected.charactername = choiceText
end

--
function ElderScrollsOfAlts:DoDeleteSelectedCharacter()
  local charname = ElderScrollsOfAlts.selected.charactername 
    ElderScrollsOfAlts:debugMsg("DoDeleteSelectedCharacter: Name=" .. tostring(charname))
end

