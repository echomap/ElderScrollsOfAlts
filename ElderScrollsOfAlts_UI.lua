-- GUI Elements

function ElderScrollsOfAlts:SetupGui()

end

function ElderScrollsOfAlts:ShowGuiByChoice()
  local sMode = ElderScrollsOfAlts.GetUIMode()
   --Update Me
    ElderScrollsOfAlts.loadPlayerData()
  
  if sMode == nil or sMode == "LMM" then
    ElderScrollsOfAlts:ToggleShowing()
  elseif sMode == "Show2" or sMode == "show2" then
    ElderScrollsOfAlts:ShowGui2()
  end
end

--Gui1
function ElderScrollsOfAlts:SetupGuiPage1(self)
  ElderScrollsOfAlts.debugMsg("SetupGuiPage1 Called!")
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
  ElderScrollsOfAlts.settings.window.top    = ESOA_GUI2:GetTop()
  ElderScrollsOfAlts.settings.window.left   = ESOA_GUI2:GetLeft()
  ElderScrollsOfAlts:debugMsg("Saved top and left")
  if not ElderScrollsOfAlts.settings.window.minimized and not ElderScrollsOfAlts.settings.window.iconify then
    ElderScrollsOfAlts.settings.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.settings.window.height = ESOA_GUI2:GetHeight()  
    ElderScrollsOfAlts:debugMsg("Saved width and height")
  end
end

--Gui2
function ElderScrollsOfAlts:onResizeStart() 
  --
end

--Gui2
function ElderScrollsOfAlts:onResizeStop()
  --XX:GuiResizeScroll()
  --XX:UpdateInventoryScroll()
  if not ElderScrollsOfAlts.settings.window.minimized and not ElderScrollsOfAlts.settings.window.iconify then
    ElderScrollsOfAlts.settings.window.top    = ESOA_GUI2:GetTop()
    ElderScrollsOfAlts.settings.window.left   = ESOA_GUI2:GetLeft()
    ElderScrollsOfAlts.settings.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.settings.window.height = ESOA_GUI2:GetHeight()
    ElderScrollsOfAlts:debugMsg("Saved width and height, top and left")
  end
end

--Gui2
function ElderScrollsOfAlts:GUI2Iconify(bIconify)
  ElderScrollsOfAlts.settings.window.iconify = bIconify

  if bIconify then    
    ElderScrollsOfAlts:GUI2Minimize(false)    
    
    ESOA_GUI2_IconifyHeader:SetHidden(false)        
    
    ESOA_GUI2_BG:SetHidden(true)
    ESOA_GUI2_Header:SetHidden(true)
    ESOA_GUI2_CharListHeader:SetHidden(true)
    ESOA_GUI2_CharList:SetHidden(true)    
    if not ElderScrollsOfAlts.settings.window.minimized then
      ElderScrollsOfAlts.settings.window.height = ESOA_GUI2:GetHeight()
      ElderScrollsOfAlts.settings.window.width  = ESOA_GUI2:GetWidth()
    end
    ESOA_GUI2:SetHeight(40)
    ESOA_GUI2:SetWidth(70)
    
    ESOA_GUI2_IconifyHeader:ClearAnchors()
    ESOA_GUI2_IconifyHeader:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
      ElderScrollsOfAlts.settings.window.left, ElderScrollsOfAlts.settings.window.top)    

    ESOA_GUI2_IconifyHeader_BG:ClearAnchors()
    ESOA_GUI2_IconifyHeader_BG:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
      ElderScrollsOfAlts.settings.window.left, ElderScrollsOfAlts.settings.window.top)    
    ESOA_GUI2_IconifyHeader_BG:SetHeight(40)
    ESOA_GUI2_IconifyHeader_BG:SetWidth(70)
    
    --ESOA_GUI2_IconifyUn:SetHidden(false)
    --ESOA_GUI2_IconifyUn_Label:SetHidden(false)
		--ESOA_GUI2:SetResizeHandleSize(0) 
    --ESOA_GUI2:SetMovable(false)
  else    
    ESOA_GUI2_IconifyHeader:SetHidden(true)
    
    ESOA_GUI2_BG:SetHidden(false)
    ESOA_GUI2_Header:SetHidden(false)
    ESOA_GUI2_CharListHeader:SetHidden(false)
    ESOA_GUI2_CharList:SetHidden(false)    
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.settings.window.height)
    ESOA_GUI2:SetWidth(ElderScrollsOfAlts.settings.window.width)
    
    --ESOA_GUI2:SetResizeHandleSize(10)
    --ESOA_GUI2:SetMovable(true)
  end  
  
end

--Gui2
function ElderScrollsOfAlts:GUI2Minimize(bMin)
  ElderScrollsOfAlts.settings.window.minimized = bMin
  ESOA_GUI2_CharListHeader:SetHidden(bMin)
  ESOA_GUI2_CharList:SetHidden(bMin)
  ESOA_GUI2_Header_Minimize:SetHidden(bMin)
  ESOA_GUI2_Header_Maximize:SetHidden(not bMin)
  if bMin then
    ESOA_GUI2:SetHeight(40)
  else
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.settings.window.height)
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
    if ElderScrollsOfAlts.settings.window.minimized then
      ElderScrollsOfAlts:GUI2Minimize(false)  
    end  
    if ElderScrollsOfAlts.settings.window.iconify then
      --todo
    end    
  end
	--local settings = IIfA:GetSceneSettings()
	--settings.hidden = true
  if ElderScrollsOfAlts.settings.window.top ~= nil then
    local left = ElderScrollsOfAlts.settings.window.left
    local top = ElderScrollsOfAlts.settings.window.top
    ESOA_GUI2:ClearAnchors()
    ESOA_GUI2:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.settings.window.height)
    ESOA_GUI2:SetWidth( ElderScrollsOfAlts.settings.window.width )
  else 
    ElderScrollsOfAlts.settings.window.iconify = false
    ElderScrollsOfAlts.settings.window.top    = ESOA_GUI2:GetTop()
    ElderScrollsOfAlts.settings.window.left   = ESOA_GUI2:GetLeft()
    ElderScrollsOfAlts.settings.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.settings.window.height = ESOA_GUI2:GetHeight()
  end
end

--Gui2
function ElderScrollsOfAlts:SetupGui2(self)
  ElderScrollsOfAlts.debugMsg("SetupGui2 Called!")
	ESOA_GUI2_Header_Dropdown.comboBox = ESOA_GUI2_Header_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_Header_Dropdown)
	local comboBox = ESOA_GUI2_Header_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
	--ESOA_GUI_PAGE1_Dropdown:SetHidden(false)  
  
  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI2_Header_Dropdown)
  ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI2_CharList)
end

--Sort
local serverSortKeys =
  {
    ["name"]          = { }, 
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
local currentSortKey = "name"
local currentSortOrder = ZO_SORT_ORDER_UP --ZO_SORT_ORDER_DOWN
  
--Sort
local function SortServers(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, currentSortKey, serverSortKeys, currentSortOrder)
end

--Sort
function ElderScrollsOfAlts:GuiSortBase(newKey)
  local sameKey = false
  if currentSortKey == newKey then
    sameKey = true
  end
  
  if sameKey then
    if currentSortOrder == ZO_SORT_ORDER_UP then 
      currentSortOrder = ZO_SORT_ORDER_DOWN 
    else
        currentSortOrder = ZO_SORT_ORDER_UP
    end
  else
    currentSortKey = newKey
    currentSortOrder = ZO_SORT_ORDER_UP
  end
  
  local scroll_data = ZO_ScrollList_GetDataList(ESOA_GUI_PAGE1_List)  
  local dataLines   = table.sort( scroll_data,  SortServers )   
  ZO_ScrollList_Commit(ESOA_GUI_PAGE1_List, dataLines)
  --ElderScrollsOfAlts:RefreshCharacterScroll()
  
  --
  local scroll_data2 = ZO_ScrollList_GetDataList(ESOA_GUI2_CharList)  
  local dataLines2   = table.sort( scroll_data2,  SortServers )   
  ZO_ScrollList_Commit(ESOA_GUI2_CharList, dataLines2)
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
function ElderScrollsOfAlts:SetupGuiCharListing(dataListing, dataListing)
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
		ElderScrollsOfAlts.debugMsg(" playerLines k " .. tostring(k)  )
		ElderScrollsOfAlts.debugMsg(" playerLines v " .. tostring(v)  )	
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
  ElderScrollsOfAlts.debugMsg(" SetupRowControl=" .. tostring(row_control) .. " row_data=" .. tostring(row_data) )
  for k, v in pairs(row_data) do
    ElderScrollsOfAlts.debugMsg(" key= " .. k)
    --d(ElderScrollsOfAlts.name .. " v1_ " .. tostring(v["_Name"]))
    --d(ElderScrollsOfAlts.name .. " v1  " .. tostring(v["Name"]))
  end
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

    --local sName = GetControl(control, "_Name")
    --local sKey  = GetControl(control, "_Key")
    --sName:SetText(data.name)
    --sKey:SetText(data.key)

    --local fieldColor = STATUS_COLORS[data.key] or defaultColor
    --sKey:SetColor(fieldColor:UnpackRGBA())
    --ZO_SortFilterList.SetupRow(self, control, data)
end

--Shared Gui
function ElderScrollsOfAlts:doCharacterSelected(choiceText, choice)
	ElderScrollsOfAlts.debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
  --ElderScrollsOfAlts:SetupGui3()
  ElderScrollsOfAlts.ShowGui3()
end

--Gui2
function ElderScrollsOfAlts:SelectCharacterRow(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_CharList, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_CharList)
  if selectedData ~= nil then
    ElderScrollsOfAlts.debugMsg("SelectCharacterRow: Name=" .. tostring(selectedData.name))
    ElderScrollsOfAlts:ShowGui3(selectedData)
  else
    ElderScrollsOfAlts.debugMsg("SelectCharacterRow: selectedData= nil")
  end  
end
