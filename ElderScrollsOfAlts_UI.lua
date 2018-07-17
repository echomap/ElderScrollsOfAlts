-- GUI Elements

function ElderScrollsOfAlts:SetupGUI()

end

--
function ElderScrollsOfAlts:onMoveStop()
  --
end

function ElderScrollsOfAlts:onResizeStart() 
  --
end

function ElderScrollsOfAlts:onResizeStop()
  --XX:GuiResizeScroll()
  --XX:UpdateInventoryScroll()
  ElderScrollsOfAlts.settings.window.top    = ESOA_GUI2:GetTop()
  ElderScrollsOfAlts.settings.window.left   = ESOA_GUI2:GetLeft()
  ElderScrollsOfAlts.settings.window.width  = ESOA_GUI2:GetWidth()
  ElderScrollsOfAlts.settings.window.height = ESOA_GUI2:GetHeight()
end

function ElderScrollsOfAlts:GUI2Minimize(bMin)
  ESOA_GUI2_CharListHeader:SetHidden(bMin)
  ESOA_GUI2_CharList:SetHidden(bMin)
  ESOA_GUI2_Header_Minimize:SetHidden(bMin)
  ESOA_GUI2_Header_Maximize:SetHidden(not bMin)
  if bMin then
    ESOA_GUI2:SetHeight(50)
  else
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.settings.window.height)
  end
    
end

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

function ElderScrollsOfAlts.HideGui2()
    ESOA_GUI2:SetHidden(true)
end

function ElderScrollsOfAlts.ShowGui2()
  if not ESOA_GUI2:IsHidden() then 
    ESOA_GUI2:SetHidden(true)
  else
    ESOA_GUI2:SetHidden(false)
  end
	--local settings = IIfA:GetSceneSettings()
	--settings.hidden = true
  ElderScrollsOfAlts.settings.window.top    = ESOA_GUI2:GetTop()
  ElderScrollsOfAlts.settings.window.left   = ESOA_GUI2:GetLeft()
  ElderScrollsOfAlts.settings.window.width  = ESOA_GUI2:GetWidth()
  ElderScrollsOfAlts.settings.window.height = ESOA_GUI2:GetHeight()
end

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

--
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
  
local function SortServers(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, currentSortKey, serverSortKeys, currentSortOrder)
end

--
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

function ElderScrollsOfAlts:GuiSort(keyname)
  ElderScrollsOfAlts:GuiSortBase(keyname)
end

-- dropdown
function ElderScrollsOfAlts:GuiSetupDropdown(dropdown)
	--local selectedItem = ElderScrollsOfAlts:GetInventoryListFilter()
	--dropdown.comboBox:SetSelectedItem(selectedItem)
end

--
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

function ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, dropDown)
	local function OnItemSelect(_, choiceText, choice)
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


function ElderScrollsOfAlts:SetupGuiPlayerLines()
	local playerLines =  {}
	--table.insert(playerLines, "Select")
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
    if k == nil then return end
		ElderScrollsOfAlts.debugMsg(" players " .. k)
		playerLines[k] = {}
		playerLines[k].name = ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k )
    playerLines[k].rawname = k
		local bio = ElderScrollsOfAlts.altData.players[k].bio
		if bio ~=nil then
			playerLines[k].gender = bio.gender
      playerLines[k].level  = bio.level
			playerLines[k].race   = bio.race
      playerLines[k].class  = bio.class
      if bio.Werewolf then
        playerLines[k].Werewolf = true
      end
      if bio.Vampire then
        playerLines[k].Vampire = true
      end
    else 
      playerLines[k].gender = -1
			playerLines[k].level = -1
			playerLines[k].race = "Unk"
      playerLines[k].class = "Unk"
      playerLines[k].Werewolf = false
      playerLines[k].Vampire = false
		end
    if playerLines[k].level == nil or playerLines[k].level < 1 then
      ElderScrollsOfAlts.altData.players[k]  = nil
      return
    end
    --
    if bio.CanChampPts then
      playerLines[k].champion = bio.champion
    else 
      playerLines[k].champion = nil
    end

    --
    local misc = ElderScrollsOfAlts.altData.players[k].misc
    if misc ~=nil then
      playerLines[k].backpackSize = misc.backpackSize
      playerLines[k].backpackUsed = misc.backpackUsed
    else
      playerLines[k].backpackSize = 0
      playerLines[k].backpackUsed = 0
    end
    --
    local trade = ElderScrollsOfAlts.altData.players[k].skills.trade
    if trade ~=nil then
      local tradeL = ElderScrollsOfAlts.altData.players[k].skills.trade.typelist    
      if trade ~=nil then
        local alchemy  = tradeL["Alchemy"]
        if alchemy ~=nil then
          playerLines[k].alchemy         = alchemy.rank
          playerLines[k].alchemy_sunk    = alchemy.sunk
          playerLines[k].alchemy_sinkmax = alchemy.sinkmax
        else
          playerLines[k].alchemy = 0
          playerLines[k].alchemy_sunk    = 0
          playerLines[k].alchemy_sinkmax = 0          
        end
        local blacksmithing = tradeL["Blacksmithing"] 
        if blacksmithing ~=nil then
          playerLines[k].blacksmithing = blacksmithing.rank   
          playerLines[k].blacksmithing_sunk    = blacksmithing.sunk
          playerLines[k].blacksmithing_sinkmax = blacksmithing.sinkmax
        else
          playerLines[k].blacksmithing = 0
          playerLines[k].blacksmithing_sunk    = 0
          playerLines[k].blacksmithing_sinkmax = 0   
        end
        local clothing = tradeL["Clothing"] 
        if clothing ~=nil then
          playerLines[k].clothing = clothing.rank   
          playerLines[k].clothing_sunk    = clothing.sunk
          playerLines[k].clothing_sinkmax = clothing.sinkmax
        else
           playerLines[k].clothing = 0
          playerLines[k].clothing_sunk    = 0
          playerLines[k].clothing_sinkmax = 0   
        end
        local enchanting = tradeL["Enchanting"] 
        if enchanting ~=nil then
          playerLines[k].enchanting = enchanting.rank 
          playerLines[k].enchanting_sunk    = enchanting.sunk
          playerLines[k].enchanting_sinkmax = enchanting.sinkmax
        else
          playerLines[k].enchanting = 0
          playerLines[k].enchanting_sunk    = 0
          playerLines[k].enchanting_sinkmax = 0             
        end         
        local jewelry = tradeL["Jewelry Crafting"] 
        if jewelry ~=nil then
          playerLines[k].jewelry = jewelry.rank   
          playerLines[k].jewelry_sunk    = jewelry.sunk
          playerLines[k].jewelry_sinkmax = jewelry.sinkmax
        else
          playerLines[k].jewelry = 0
          playerLines[k].jewelry_sunk    = 0
          playerLines[k].jewelry_sinkmax = 0 
        end          
        local provisioning = tradeL["Provisioning"]          
        if provisioning ~=nil then
          playerLines[k].provisioning = provisioning.rank   
          playerLines[k].provisioning_sunk    = provisioning.sunk
          playerLines[k].provisioning_sinkmax = provisioning.sinkmax
        else
          playerLines[k].provisioning = 0
          playerLines[k].provisioning_sunk    = 0
          playerLines[k].provisioning_sinkmax = 0              
         end              
         local woodworking = tradeL["Woodworking"] 
         if woodworking ~=nil then
          playerLines[k].woodworking = woodworking.rank   
          playerLines[k].woodworking_sunk    = woodworking.sunk
          playerLines[k].woodworking_sinkmax = woodworking.sinkmax
         else
          playerLines[k].woodworking = 0
          playerLines[k].woodworking_sunk    = 0
          playerLines[k].woodworking_sinkmax = 0              
         end
        end
    else
      --
    end
  end

  -- PlayerLines to table
  table.sort(playerLines)  
  return playerLines
end

  
function ElderScrollsOfAlts:SetupGuiDropDown(self,comboBox, dropDown, dataListing)
  --
	local function OnItemSelect(_, choiceText, choice)
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

	-- LIST
	--dataListing = dataListing or ZO_ComboBox_ObjectFromContainer(dataListing)
	--comboBox:ClearItems()
	--ZO_ScrollList_Clear(dataListing)

	--local function InitializeRow(control, data)
		--d("Initialize row")
		--control:SetText(data.key)
	--end

	local NOTE_TYPE = 1
	--local indexContainer = window:GetNamedChild("dataListing")
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
	--IIfA:GuiResizeScroll()
	--IIfA:RefreshInventoryScroll()
	--local TYPE_ID = NOTE_TYPE
	--local entries = storage:GetKeys()
	--for i=1, #entries do
	--    scrollData[#scrollData + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, {key = entries[i]})
	--end
	local playerLines =  {}
	--table.insert(playerLines, "Select")
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
    if k == nil then return end
		ElderScrollsOfAlts.debugMsg(" players " .. k)
		playerLines[k] = {}
		playerLines[k].name = ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k )
    playerLines[k].rawname = k
		local bio = ElderScrollsOfAlts.altData.players[k].bio
		if bio ~=nil then
			playerLines[k].gender = bio.gender
      playerLines[k].level  = bio.level
			playerLines[k].race   = bio.race
      playerLines[k].class  = bio.class
      if bio.Werewolf then
        playerLines[k].Werewolf = true
      end
      if bio.Vampire then
        playerLines[k].Vampire = true
      end
    else 
      playerLines[k].gender = -1
			playerLines[k].level = -1
			playerLines[k].race = "Unk"
      playerLines[k].class = "Unk"
      playerLines[k].Werewolf = false
      playerLines[k].Vampire = false
		end
    if playerLines[k].level == nil or playerLines[k].level < 1 then
      ElderScrollsOfAlts.altData.players[k]  = nil
      return
    end
    --
    if bio.CanChampPts then
      playerLines[k].champion = bio.champion
    else 
      playerLines[k].champion = nil
    end

    --
    local misc = ElderScrollsOfAlts.altData.players[k].misc
    if misc ~=nil then
      playerLines[k].backpackSize = misc.backpackSize
      playerLines[k].backpackUsed = misc.backpackUsed
    else
      playerLines[k].backpackSize = 0
      playerLines[k].backpackUsed = 0
    end
    --
    local trade = ElderScrollsOfAlts.altData.players[k].skills.trade
    if trade ~=nil then
      local tradeL = ElderScrollsOfAlts.altData.players[k].skills.trade.typelist    
      if trade ~=nil then
        local alchemy  = tradeL["Alchemy"]
        if alchemy ~=nil then
          playerLines[k].alchemy         = alchemy.rank
          playerLines[k].alchemy_sunk    = alchemy.sunk
          playerLines[k].alchemy_sinkmax = alchemy.sinkmax
        else
          playerLines[k].alchemy = "0"
          playerLines[k].alchemy_sunk    = 0
          playerLines[k].alchemy_sinkmax = 0          
        end
        local blacksmithing = tradeL["Blacksmithing"] 
        if blacksmithing ~=nil then
          playerLines[k].blacksmithing = blacksmithing.rank   
          playerLines[k].blacksmithing_sunk    = blacksmithing.sunk
          playerLines[k].blacksmithing_sinkmax = blacksmithing.sinkmax
        else
          playerLines[k].blacksmithing = "0"
          playerLines[k].blacksmithing_sunk    = 0
          playerLines[k].blacksmithing_sinkmax = 0   
        end
        local clothing = tradeL["Clothing"] 
        if clothing ~=nil then
          playerLines[k].clothing = clothing.rank   
          playerLines[k].clothing_sunk    = clothing.sunk
          playerLines[k].clothing_sinkmax = clothing.sinkmax
        else
           playerLines[k].clothing = "0"
          playerLines[k].clothing_sunk    = 0
          playerLines[k].clothing_sinkmax = 0   
        end
        local enchanting = tradeL["Enchanting"] 
        if enchanting ~=nil then
          playerLines[k].enchanting = enchanting.rank 
          playerLines[k].enchanting_sunk    = enchanting.sunk
          playerLines[k].enchanting_sinkmax = enchanting.sinkmax
        else
          playerLines[k].enchanting = "0"
          playerLines[k].enchanting_sunk    = 0
          playerLines[k].enchanting_sinkmax = 0             
        end         
        local jewelry = tradeL["Jewelry Crafting"] 
        if jewelry ~=nil then
          playerLines[k].jewelry = jewelry.rank   
          playerLines[k].jewelry_sunk    = jewelry.sunk
          playerLines[k].jewelry_sinkmax = jewelry.sinkmax
        else
          playerLines[k].jewelry = "0"
          playerLines[k].jewelry_sunk    = 0
          playerLines[k].jewelry_sinkmax = 0 
        end          
        local provisioning = tradeL["Provisioning"]          
        if provisioning ~=nil then
          playerLines[k].provisioning = provisioning.rank   
          playerLines[k].provisioning_sunk    = provisioning.sunk
          playerLines[k].provisioning_sinkmax = provisioning.sinkmax
        else
          playerLines[k].provisioning = "0"
          playerLines[k].provisioning_sunk    = 0
          playerLines[k].provisioning_sinkmax = 0              
         end              
         local woodworking = tradeL["Woodworking"] 
         if woodworking ~=nil then
          playerLines[k].woodworking = woodworking.rank   
          playerLines[k].woodworking_sunk    = woodworking.sunk
          playerLines[k].woodworking_sinkmax = woodworking.sinkmax
         else
          playerLines[k].woodworking = "0"
          playerLines[k].woodworking_sunk    = 0
          playerLines[k].woodworking_sinkmax = 0              
         end
        end
    else
      --
    end
    
    --
    --local headers = WINDOW_MANAGER:CreateControlFromVirtual(
    --"ESOA_RowHeader", fragment.win, "ESOA_RowHeader")
    --headers:SetAnchor(TOPRIGHT, fragment.win, TOPRIGHT, 0, 0)
    
		--table.insert(playerLines, getColoredString(ITEM_QUALITY_TRASH, k ))
	end
  
  table.sort(playerLines)
  --for i=1, #playerLines do
	for k, v in pairs(playerLines) do
		ElderScrollsOfAlts.debugMsg(" playerLines k " .. tostring(k)  )
		ElderScrollsOfAlts.debugMsg(" playerLines v " .. tostring(v)  )
	    --scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, {Key = playerLines[i], Name=playerLines[i], Message="msg", key2="key22" })
      
	   scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, v )
	   --scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, {Key = v.name, Name=v.name, Message=v.msg, key2=v.key2, Gender=v.gender, Class=v.class })      
      
	    --scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, {validChoices[i], validChoices[i], "msg", "key22" })
	    --table.insert( scroll_data, ZO_ScrollList_CreateDataEntry(TYPE_ID, validChoices[i]))
	end
  
	ZO_ScrollList_Commit(dataListing, scroll_data)
	dataListing:SetHidden(false)
end

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

--
function ElderScrollsOfAlts:doCharacterSelected(choiceText, choice)
	--ElderScrollsOfAlts.loadPlayerData()
	ElderScrollsOfAlts.debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )
	--TODO
	--choice:GetNamedChild('Name'):SetText(row_data["Name"])
	--choice:GetNamedChild('Name'):SetText(row_data["Name"])
	ZO_ScrollList_Clear(ESOA_GUI_PAGE1_List) --#scroll_data)
	local dataList =  {}
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
		ElderScrollsOfAlts.debugMsg(" k " .. k)
	end
	local basePlayerElem = ElderScrollsOfAlts.altData.players[choiceText]
  if basePlayerElem == nil then
    ElderScrollsOfAlts.debugMsg("Can't find player data")
    return
  end  
	ElderScrollsOfAlts.debugMsg(" basePlayerElem=" .. basePlayerElem)
	--ElderScrollsOfAlts.altData.players[pName].skills
	local b2 = basePlayerElem.skills
	local b3 = basePlayerElem.skills.trade
	local b4 = basePlayerElem.skills.trade.typelist
	for k, v in pairs(basePlayerElem) do
		--d(ElderScrollsOfAlts.name .. " k " .. k)
		table.insert(dataList, getColoredString(ITEM_QUALITY_TRASH, k ) )
	end
	--local validChoices =  {}
	--table.insert(validChoices, "Select")
	--for k, v in pairs(ElderScrollsOfAlts.altData.players) do
	--	--d(ElderScrollsOfAlts.name .. " k " .. k)
	--	table.insert(validChoices, getColoredString(ITEM_QUALITY_TRASH, k ))
	--end
	for i=1, #dataList do
	    scroll_data[#scroll_data + 1] = ZO_ScrollList_CreateDataEntry(NOTE_TYPE, {Key = choiceText, Name=choiceText, Message="msg", key2=dataList[i] })
	end
end
