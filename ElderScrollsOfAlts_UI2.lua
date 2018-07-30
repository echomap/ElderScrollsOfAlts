-- GUI Elements (Setup and View Data)

--Gui1
function ElderScrollsOfAlts:SetupGuiPage1(self)
  ElderScrollsOfAlts:debugMsg("SetupGuiPage1 Called!")
	ESOA_GUI_PAGE1_Dropdown.comboBox = ESOA_GUI_PAGE1_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI_PAGE1_Dropdown)
	local comboBox = ESOA_GUI_PAGE1_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
	--ESOA_GUI_PAGE1_Dropdown:SetHidden(false)  
  
  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI_PAGE1_Dropdown)
  ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI_PAGE1_List)
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
end

--Gui2
-- Setup Display of addon data 
function ElderScrollsOfAlts:SetupGui2(self)
  ElderScrollsOfAlts:debugMsg("SetupGui2 Called!")
	ESOA_GUI2_Header_Dropdown.comboBox = ESOA_GUI2_Header_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_Header_Dropdown)
	local comboBox = ESOA_GUI2_Header_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
	--ESOA_GUI_PAGE1_Dropdown:SetHidden(false)  
  
  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI2_Header_Dropdown)
  ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI2_Body_CharList)
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
  }
--local currentSortKey = "name"
--local currentSortOrder = ZO_SORT_ORDER_UP --ZO_SORT_ORDER_DOWN
  
--Sort
function ElderScrollsOfAlts.SortCharData(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, ElderScrollsOfAlts.savedVariables.currentSortKey, charSortKeys, ElderScrollsOfAlts.savedVariables.currentSortOrder)
end

--Sort
function ElderScrollsOfAlts:Gui2SortRefresh()
  ElderScrollsOfAlts:GuiSortBase(ElderScrollsOfAlts.savedVariables.currentSortKey,true)
end

--Sort
function ElderScrollsOfAlts:GuiSortBase(newKey,refreshOnly)
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
  
  local scroll_data = ZO_ScrollList_GetDataList(ESOA_GUI_PAGE1_List)  
  local dataLines   = table.sort( scroll_data,  ElderScrollsOfAlts.SortCharData )   
  ZO_ScrollList_Commit(ESOA_GUI_PAGE1_List, dataLines)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  
  --
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_Body_CharList)  
  local dataLines2   = table.sort( scroll_data2,  ElderScrollsOfAlts.SortCharData )   
  ZO_ScrollList_Commit(ESOA_GUI2_Body_CharList, dataLines2)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
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
  if sunk ~=nil and sunk > 0 then
      row_control:GetNamedChild(uiname):SetText(row_data[rowname].."("..sunk..")" )
  else
    row_control:GetNamedChild(uiname):SetText(row_data[rowname] .. "  ")
  end
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
    --row_control:GetNamedChild('Gender'):SetText(row_data["gender"])    
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
    row_control:GetNamedChild('Provisioning'):SetText(row_data["provisioning"])
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

function ElderScrollsOfAlts:SelectCharacterFromDropdown(dropdown)  
  local charname = dropdown.comboBox:GetSelectedItem()
  ElderScrollsOfAlts:debugMsg(" charname=" .. tostring(charname))
  ElderScrollsOfAlts.selected.charactername = charname
end

--Shared Gui
function ElderScrollsOfAlts:doCharacterSelected(choiceText, choice)
	ElderScrollsOfAlts:debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
  --ElderScrollsOfAlts:SetupGui3()
  ElderScrollsOfAlts.selected.charactername = choiceText -- or choice??
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

--For use by Settings dropdown
function ElderScrollsOfAlts:SelectCharacterName(choiceText)
  ElderScrollsOfAlts.selected.charactername = choiceText
end

--
function ElderScrollsOfAlts:DoDeleteSelectedCharacter()
  local charname = ElderScrollsOfAlts.selected.charactername 
    ElderScrollsOfAlts:debugMsg("DoDeleteSelectedCharacter: Name=" .. tostring(charname))
end
