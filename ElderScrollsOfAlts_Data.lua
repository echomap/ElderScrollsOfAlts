--

--
--
function ElderScrollsOfAlts:ListOfPlayers()
  	--for k, v in pairs(ElderScrollsOfAlts.altData.players) do
      --d(ElderScrollsOfAlts.name .. " k " .. k)
     -- table.insert(validChoices, ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k ))
    --end
    return ElderScrollsOfAlts.altData.players
end

--
--
function ElderScrollsOfAlts:SetupGuiPage1(self)
  ElderScrollsOfAlts.debugMsg("SetupGuiPage1 Called!")
	ESOA_GUI_PAGE1_Dropdown.comboBox = ESOA_GUI_PAGE1_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI_PAGE1_Dropdown)
	local comboBox = ESOA_GUI_PAGE1_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)

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
	ESOA_GUI_PAGE1_Dropdown:SetHidden(false)

	-- LIST
	--ESOA_GUI_PAGE1_List = ESOA_GUI_PAGE1_List or ZO_ComboBox_ObjectFromContainer(ESOA_GUI_PAGE1_List)
	--comboBox:ClearItems()
	--ZO_ScrollList_Clear(ESOA_GUI_PAGE1_List)

	--local function InitializeRow(control, data)
		--d("Initialize row")
		--control:SetText(data.key)
	--end

	local NOTE_TYPE = 1
	--local indexContainer = window:GetNamedChild("ESOA_GUI_PAGE1_List")
	local scroll_data = ZO_ScrollList_GetDataList(ESOA_GUI_PAGE1_List)
	ZO_ScrollList_Clear(ESOA_GUI_PAGE1_List) --#scroll_data)
	--ZO_ClearNumericallyIndexedTable(scroll_data)
	ZO_ScrollList_AddDataType(ESOA_GUI_PAGE1_List, NOTE_TYPE, "ESOA_RowTemplate", 20,
		function(control, data)
			ElderScrollsOfAlts:SetupRowControl(control, data)
		end
	)
	ZO_ScrollList_AddCategory(ESOA_GUI_PAGE1_List, 1, nil)
	ZO_ScrollList_AddResizeOnScreenResize(ESOA_GUI_PAGE1_List)
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
    else 
      playerLines[k].gender = "gender"
			playerLines[k].level = "level"
			playerLines[k].race = "race"
      playerLines[k].class = "class"
		end
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
  
	ZO_ScrollList_Commit(ESOA_GUI_PAGE1_List, scroll_data)
	ESOA_GUI_PAGE1_List:SetHidden(false)
end

--
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

function ElderScrollsOfAlts:formatRowData(type,text)
  if type == 1 then
    if text == nil then
      text = 0;
    end
  end
  return text;
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
--
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
    row_control:GetNamedChild('Level'):SetText(row_data["level"])
    row_control:GetNamedChild('Class'):SetText(row_data["class"])
    row_control:GetNamedChild('Race'):SetText(row_data["race"])
    

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
       
    --row_control:GetNamedChild("Name"):SetText(GetMoneyName(data))

    --local sName = GetControl(control, "_Name")
    --local sKey  = GetControl(control, "_Key")
    --sName:SetText(data.name)
    --sKey:SetText(data.key)

    --local fieldColor = STATUS_COLORS[data.key] or defaultColor
    --sKey:SetColor(fieldColor:UnpackRGBA())
    --ZO_SortFilterList.SetupRow(self, control, data)
end
