
-----------
-- VIEWS -- 

--View, Setup and Show
function ElderScrollsOfAlts:ShowGuiByChoice()
  --TODO
  if( ESOA_GUI2:IsHidden()) then
    ElderScrollsOfAlts:ShowSetView()
  else
    ESOA_GUI2:SetHidden(true)
  end
end

--
function ElderScrollsOfAlts:HideAll()
  ElderScrollsOfAlts.HideUIButton()
  ESOA_GUI2:SetHidden(true)
end

--UIButton
function ElderScrollsOfAlts.ShowUIButton()
  if(not ElderScrollsOfAlts.GetUIButtonShown()) then
    return
  end  
  --debugMsg("ShowUIButton called. left="..tostring(ElderScrollsOfAlts.savedVariables.uibutton.left))
  ESOA_ButtonFrame:SetHidden(false)
  ESOA_ButtonFrame:ClearAnchors()
  ESOA_ButtonFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
    ElderScrollsOfAlts.savedVariables.uibutton.left, ElderScrollsOfAlts.savedVariables.uibutton.top)
end

--UIButton
function ElderScrollsOfAlts.HideUIButton()
  ESOA_ButtonFrame:SetHidden(true)
end

function ElderScrollsOfAlts:getViewDataByName(viewNameFind)
  if(viewNameFind==nil) then
    return nil
  end
  for viewIdx, guiLine in pairs(ElderScrollsOfAlts.savedVariables.gui) do
    local viewName = guiLine.name
    if(viewName==viewNameFind) then
      return guiLine
    end
  end
  return nil
end

function ElderScrollsOfAlts:ShowAndSetView(viewName,viewIdx,buttonCalled)
  ElderScrollsOfAlts.savedVariables.lastView       = ElderScrollsOfAlts.savedVariables.currentView
  ElderScrollsOfAlts.savedVariables.currentView    = viewName
  ElderScrollsOfAlts.savedVariables.currentViewIdx = viewIdx
  for _, btnLine in pairs(ElderScrollsOfAlts.view.viewButtons) do
    --btnLine:SetFont(ZoFontGameLarge)--TODO
  end
  if(buttonCalled~=nil)then
    --buttonCalled:SetFont(ZoFontGameLargeBold)--TODO
  end
  ElderScrollsOfAlts:ShowSetView()
end

--View, Setup and Show
function ElderScrollsOfAlts:ShowNextView()
  --TODO
  if(ElderScrollsOfAlts.view.viewButtons==nil)then
    return
  end
  if(ElderScrollsOfAlts.savedVariables.currentViewIdx==nil)then
    ElderScrollsOfAlts.savedVariables.currentViewIdx = 1
  end
  
  ElderScrollsOfAlts.savedVariables.currentViewIdx = ElderScrollsOfAlts.savedVariables.currentViewIdx + 1
  if(ElderScrollsOfAlts.savedVariables.currentViewIdx > #ElderScrollsOfAlts.view.viewButtons)then
    ElderScrollsOfAlts.savedVariables.currentViewIdx = 1
  end
  if(ElderScrollsOfAlts.view.viewButtons~=nil)then
    local cItem = ElderScrollsOfAlts.view.viewButtons[ElderScrollsOfAlts.savedVariables.currentViewIdx]
    if(cItem~=nil)then
      ElderScrollsOfAlts.savedVariables.currentView = cItem.viewName
    else
      ElderScrollsOfAlts.savedVariables.currentView    = ElderScrollsOfAlts.view.viewButtons[1]["viewName"]
      ElderScrollsOfAlts.savedVariables.currentViewIdx = 1
    end
  end  
      
  --ElderScrollsOfAlts.savedVariables.currentView = 
  --ElderScrollsOfAlts.savedVariables.currentViewIdx = 

  ElderScrollsOfAlts:RefreshView()
  
end

function ElderScrollsOfAlts:RefreshView()
  -- Setup common GUI
  ElderScrollsOfAlts.ShowGuiBase()
  --
  -- Setup Header 
  ElderScrollsOfAlts:SetupGuiHeaderListing() 
  
  --Setup Data lines
  ElderScrollsOfAlts:SetupGuiCharListing()  
  --ElderScrollsOfAlts.ShowGuiBase()  
end


function ElderScrollsOfAlts:ShowSetView()
  if(ElderScrollsOfAlts.savedVariables.currentView == nil) then
    ElderScrollsOfAlts.savedVariables.currentView = "Home"
  end
  ElderScrollsOfAlts.debugMsg("ShowSetView: currentSavedView=",ElderScrollsOfAlts.savedVariables.currentView)
  --TODO
  ElderScrollsOfAlts:SavePlayerDataForGui()
  
  --Setup Data
  if( ElderScrollsOfAlts.view.needToLoadGuiData ) then
    ElderScrollsOfAlts:LoadPlayerDataForGui()
  end
  
  --ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  --ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  --ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  --ElderScrollsOfAlts:Gui2SortRefresh()
  
  ESOA_GUI2_Body_CharListHeader:SetHidden(false)
  ESOA_GUI2_Body_ListHolder:SetHidden(false)
  --ElderScrollsOfAlts:Gui2SortRefresh()
  --ElderScrollsOfAlts:resetHomeButtons()
   --TODO fix for real button
  --TODO ESOA_GUI2_Header_View_Home:SetFont(ElderScrollsOfAlts.HOME_FONT_SEL)
  
  local viewPred = ESOA_GUI2_Header_Label
  local vParent  = ESOA_GUI2_Header
  --dropdown ESOA_GUI2_Header_Dropdown_Views TODO
  ESOA_GUI2_Header_Dropdown_Views.comboBox = ESOA_GUI2_Header_Dropdown_Views.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_Header_Dropdown_Views)
  local comboBox = ESOA_GUI2_Header_Dropdown_Views.comboBox
  comboBox:ClearItems()  
  comboBox:SetSortsItems(false)
  local function OnItemSelect1(_, choiceText, choice)
    --ElderScrollsOfAlts:debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
    PlaySound(SOUNDS.POSITIVE_CLICK)
  end
  local validChoices = {}
  --Setup View Buttons (ESOA_View_Template)
  -- IF ElderScrollsOfAlts.savedVariables.gui is large , make a dropdown instead
  if(ElderScrollsOfAlts.altData.maxViewButtons==nil)then
    ElderScrollsOfAlts.altData.maxViewButtons = ElderScrollsOfAlts.defaultMaxViewButtons
  end
  
  ElderScrollsOfAlts.view.viewButtons = {}
  local viewCnt = 0
  for viewIdx, guiLine in pairs(ElderScrollsOfAlts.savedVariables.gui) do
    local viewName = guiLine.name
    table.insert(validChoices,  viewName )
    --local viewData = guiLine.view
    if(viewCnt<=ElderScrollsOfAlts.altData.maxViewButtons) then
      local line = vParent:GetNamedChild('_ViewBtn_'..viewName )
      if(line==nil)then
        line = WINDOW_MANAGER:CreateControlFromVirtual("ESOA_GUI2_Header_ViewBtn_"..viewName, vParent, "ESOA_View_Template")
      end
      line:SetText( viewName ) --TODO get function to get display name
      line:SetHidden(false)
      line:SetWidth( (viewName:len()*10)+10 )
      line.viewName = viewName
      line.viewIdx  = viewIdx
      --line:SetDimensions(ElderScrollsOfAlts.GuiSortBarLookupDisplayWidth(entry),24)--TODO get function to get display 
      --line:SetAnchor(TOPLEFT, predecessor, TOPRIGHT, 0, 0)
      if(viewPred==nil)then
        line:SetAnchor(TOPLEFT, vParent, TOPLEFT, 10, 24)    
      else
        line:SetAnchor(TOPLEFT, viewPred, TOPRIGHT, 10, 0)    
      end
      --TODO add to min width
      table.insert(ElderScrollsOfAlts.view.viewButtons,line)      
      viewCnt = viewCnt+1
      viewPred = line
    end
  end
  --Dropdown
  for i = 1, #validChoices do
    local entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect1)
    comboBox:AddItem(entry)
  end
  --Clear OLD Data
  --[[
  if(ElderScrollsOfAlts.savedVariables.lastView~=nil)then    
    local playerLines = ElderScrollsOfAlts.view.playerLines
    local viewName    = ElderScrollsOfAlts.savedVariables.lastView
    --Hide Body items
    for k_entry, playerline in pairs(playerLines) do
       local charKey = k_entry
      --debugMsg("charKey='"+charKey+"'")
      --local lineName = "ESOA_GUI2_Body_ListHolder_Line_"..viewName.."_" ..charKey  
      local line = ESOA_GUI2_Body_ListHolder:GetNamedChild('_Line_'..viewName.."_"..charKey)
      if(line~=nil)then
        line:SetHidden(true)
      end
    end
  
    --Hide Header Things
    local viewTemplate = ElderScrollsOfAlts:getViewDataByName(ElderScrollsOfAlts.savedVariables.lastView)
    ElderScrollsOfAlts.debugMsg("ShowSetView: viewTemplate=",viewTemplate)
    if(viewTemplate~=nil)then
      local viewName = viewTemplate.name
      local viewData = viewTemplate.view
      local parent      = ESOA_GUI2_Body_CharListHeader
      for i = 1, #viewData do
        --local entry = viewTemplate[i]    
        local lineHdr = ESOA_GUI2_Body_CharListHeader:GetNamedChild('_SortHdrBtn_'..i )
        if(lineHdr~=nil)then
          lineHdr:SetHidden(true)
        end
      end
    end
  
  end--Clear OLD Data
  --]]

  -- Setup common GUI
  ElderScrollsOfAlts.ShowGuiBase()
  --
  -- Setup Header 
  ElderScrollsOfAlts:SetupGuiHeaderListing(ElderScrollsOfAlts.savedVariables.currentView) 
  
  --Setup Data lines
  ElderScrollsOfAlts:SetupGuiCharListing(ElderScrollsOfAlts.savedVariables.currentView)  
  --ElderScrollsOfAlts.ShowGuiBase()
end


--ESOA_GUI2 was:ShowGui2
function ElderScrollsOfAlts.ShowGuiBase()
  if not ESOA_GUI2:IsHidden() then 
    --ESOA_GUI2:SetHidden(true)
    ElderScrollsOfAlts:CloseNote(self)
  else
    ESOA_GUI2:SetHidden(false)
    if ElderScrollsOfAlts.savedVariables.window.minimized then
      ElderScrollsOfAlts:GUI2Minimize(false)  
    end  
    if ElderScrollsOfAlts.savedVariables.window.justone then
      --ElderScrollsOfAlts:GUI2Iconify(false)
    end    
  end

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
  --ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  --ESOA_GUI2_Body_List_EQUIP:SetHidden(true)
  --ESOA_GUI2_Body_CharListHeader:SetHidden(bMin)
  --ESOA_GUI2_Body_CharList:SetHidden(bMin)
  --NEED TO CALL A VIEW before or after this!
end

--
function ElderScrollsOfAlts:SetupGuiHeaderListing(viewName)  
  local viewTemplateL = ElderScrollsOfAlts:getViewDataByName(ElderScrollsOfAlts.savedVariables.lastView)
  local viewTemplateC = ElderScrollsOfAlts:getViewDataByName(ElderScrollsOfAlts.savedVariables.currentView)
  ElderScrollsOfAlts.debugMsg("SetupGuiHeaderListing: viewTemplate=",viewTemplateC)
  
  if(viewTemplateC~=nil)then
    local predecessor = Enil--ESOA_GUI2_Body_CharListHeader_SortName
    local parent      = ESOA_GUI2_Body_CharListHeader    
      
    --Clean Entries
    if(ESOA_GUI2_Body_CharListHeader.headerLineItems~=nil)then
      for hi, hentry in pairs(ESOA_GUI2_Body_CharListHeader.headerLineItems) do
       if(hentry~=nil)then
          ElderScrollsOfAlts.debugMsg("SetupGuiHeaderListing: Hid item=",hentry.entry)
          hentry:SetHidden(true)
        end
      end
    end
    ESOA_GUI2_Body_CharListHeader.headerLineItems = {}    
    --NAME ENTRY
    local entry = "Name"
    local line = parent:GetNamedChild('_SortHdrBtn_Name' )
    if(line==nil)then
      line = WINDOW_MANAGER:CreateControlFromVirtual("ESOA_GUI2_Body_CharListHeader_SortHdrBtn_Name", parent, "ESOA_SortBar_SortButton")
    end
    line:SetText( ElderScrollsOfAlts.GuiSortBarLookupDisplayText(entry) )--TODO get function to get display name
    line:SetHidden(false)
    line:SetDimensions(ElderScrollsOfAlts.GuiSortBarLookupDisplayWidth(entry),30)--TODO get function to get display 
    --line:SetAnchor(TOPLEFT, predecessor, TOPRIGHT, 0, 0)
    if(predecessor==nil)then
      line:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, 0)    
    else
      line:SetAnchor(TOPLEFT, predecessor, TOPRIGHT, 0, 0)    
    end
    line.entry = entry
    --TODO Perhaps a lookup for search params too/ = smithing->blacksmithing
    line.sortKey = ElderScrollsOfAlts.GuiSortBarLookupSortText(entry)
    line:SetHandler('OnMouseUp',function(self)
        ElderScrollsOfAlts:DoGuiSort(self,true,self.sortKey)
    end)
    --line:SetHandler('OnClicked',function(self)
      --PlaySound(SOUNDS.POSITIVE_CLICK)        
      --ElderScrollsOfAlts:DoGuiSort(self, self.entry )
    --end)
    predecessor = line
    --
    
    --for viewIdx, guiLine in pairs(ElderScrollsOfAlts.savedVariables.gui) do
    --local viewName = guiLine.name
    ESOA_GUI2_Body_CharListHeader.headerLineItems = {}
    local viewData = viewTemplateC.view
    for i = 1, #viewData do
      entry = viewData[i]    
      --ElderScrollsOfAlts.debugMsg("GUIShowViewHome:"," entry='", tostring(entry), "'")
      line = parent:GetNamedChild('_SortHdrBtn_'..i )
      if(line==nil)then
        line = WINDOW_MANAGER:CreateControlFromVirtual("ESOA_GUI2_Body_CharListHeader_SortHdrBtn_"..i, parent, "ESOA_SortBar_SortButton")
      end
      if(line==nil) then
        ElderScrollsOfAlts.debugMsg("Ack! Virtual control is nil?")
        --return
      else
        line:SetText( ElderScrollsOfAlts.GuiSortBarLookupDisplayText(entry) )--TODO get function to get display name
        line:SetHidden(false)
        line:SetDimensions(ElderScrollsOfAlts.GuiSortBarLookupDisplayWidth(entry),30)--TODO get function to get display 
        line:SetAnchor(TOPLEFT, predecessor, TOPRIGHT, 0, 0)
        --line:SetHandler('OnClicked',function(self)
          --PlaySound(SOUNDS.POSITIVE_CLICK)        
          --ElderScrollsOfAlts:DoGuiSort(self, self.entry )
        --end)
        line:SetHandler('OnMouseUp',function(self)
          ElderScrollsOfAlts:DoGuiSort(self,true,self.sortKey)
        end)
        line.entry = entry
        line.sortKey = ElderScrollsOfAlts.GuiSortBarLookupSortText(entry)
        ElderScrollsOfAlts.debugMsg("SetupGuiHeaderListing: set entry='",entry,"' sortKey='",line.sortKey,"'")
        ElderScrollsOfAlts.debugMsg("SetupGuiHeaderListing: Showed item=",entry)
        --TODO Perhaps a lookup for search params too/ = mithing->blacksmithing
        table.insert(ESOA_GUI2_Body_CharListHeader.headerLineItems, line)
        predecessor = line
      end
    end
  end
end
  
-- _Charlist->_ListHolder
function ElderScrollsOfAlts:SetupGuiCharListing(viewName)
  --ESOA_GUI2_Body_ListHolder
  if(viewName==nil)then
    viewName = ElderScrollsOfAlts.savedVariables.currentView
  end
  
  local viewTemplateL = ElderScrollsOfAlts:getViewDataByName(ElderScrollsOfAlts.savedVariables.lastView)
  local viewTemplateC = ElderScrollsOfAlts:getViewDataByName(ElderScrollsOfAlts.savedVariables.currentView)
  if(viewTemplateC==nil)then
    --log error!
    ElderScrollsOfAlts.errorMsg("No view template for this View: " .. viewName )
    return
  end
  
  --Hide Body Items
  if(ESOA_GUI2_Body_ListHolder.displayedLines~=nil)then
    for k, dLine in pairs(ESOA_GUI2_Body_ListHolder.displayedLines) do
      if(dLine~=nil) then
        --ElderScrollsOfAlts.debugMsg("SetupGuiCharListing: Hid item=",dLine.charKey)
        dLine:SetHidden(true)
      end
    end  
  end
  if(ESOA_GUI2_Body_ListHolder.displayedEntries~=nil)then
    for k, dLine in pairs(ESOA_GUI2_Body_ListHolder.displayedEntries) do
      if(dLine~=nil) then
        --ElderScrollsOfAlts.debugMsg("SetupGuiCharListing: Hid item=",dLine.entry)
        dLine:SetHidden(true)
      end
    end  
  end  
  
  -- Setup Cat
  local categoryS = ElderScrollsOfAlts.savedVariables.selected.category
  if(categoryS==nil)then
    categoryS="All"
    ElderScrollsOfAlts.savedVariables.selected.category = categoryS
  end
  
  ESOA_GUI2_Body_ListHolder.displayedLines   = {}
  ESOA_GUI2_Body_ListHolder.displayedEntries = {}
  ESOA_GUI2_Body_ListHolder.rowHeight = 22
  ESOA_GUI2_Body_ListHolder.maxLines = ElderScrollsOfAlts.view.playerLineCount
  ESOA_GUI2_Body_ListHolder.dataOffset = 0
  
  -- Sot Players to display
  local dataLines = {}
  local dataLinesCnt = 0
  --FOR EACH CHAR in category / in range
  local playerLines = ElderScrollsOfAlts.view.playerLines
  for k_entry, playerline in pairs(playerLines) do
    local catOk = false
    if(categoryS~=nil and categoryS~="All") then
      local catP = playerline.category
      if(categoryS==catP) then
        catOk = true
      end
    else
      catOk = true
    end    
    local offsetOk = true
    if(catOk) then
      --approved line per cat  
      if( ESOA_GUI2_Body_ListHolder.dataOffset > 0) then
        ElderScrollsOfAlts.debugMsg("offset="..tostring(ESOA_GUI2_Body_ListHolder.dataOffset) )
        if( idx< ESOA_GUI2_Body_ListHolder.dataOffset)then
          offsetOk = false
          ElderScrollsOfAlts.errorMsg("Line rejected per before offset")
        end
      end
      if(offsetOk) then
        playerline.k_entry = k_entry
        dataLinesCnt=dataLinesCnt+1
        table.insert(dataLines, playerline)
      end
    end
    --HIDE ALL existing lines
    local line = ESOA_GUI2_Body_ListHolder:GetNamedChild('_Line_'..viewName.."_"..k_entry)
    if(line~=nil)then
      line:SetHidden(true)
    end
  end--for
  
  ElderScrollsOfAlts.view.playerLineCount = dataLinesCnt
  ElderScrollsOfAlts.debugMsg("SetupGuiCharListing: dataLinesCnt=" , tostring(dataLinesCnt) )
  --for k_entry, playerline in pairs(dataLines) do
  --    ElderScrollsOfAlts.debugMsg("DL=" .. tostring(k_entry).."="..tostring(playerline) )
  --end
  ESOA_GUI2_Body_ListHolder.dataLines = dataLines
  ElderScrollsOfAlts:DoGuiSort(self)
  --
  ElderScrollsOfAlts:RefreshGuiCharListing(viewName)
end


-- _Charlist->_ListHolder
function ElderScrollsOfAlts:RefreshGuiCharListing(viewName)
  if(viewName==nil) then
    viewName = ElderScrollsOfAlts.savedVariables.currentView
  end
  local viewTemplateC = ElderScrollsOfAlts:getViewDataByName(ElderScrollsOfAlts.savedVariables.currentView)
  if(viewTemplateC==nil)then
    --log error!
    ElderScrollsOfAlts.errorMsg("No view template for this View: " .. viewName )
    return
  end
  
  local mainParent = nil
  local parent     = nil
  local idx = 0
  local builtWidth = 0
  --FOR EACH CHAR approved   
  for dli = 1, #ESOA_GUI2_Body_ListHolder.dataLines do
		local playerline = ESOA_GUI2_Body_ListHolder.dataLines[dli]
    local k_entry = playerline.k_entry
    local i = 1
    local builtWidthL = 0
    local charKey = k_entry
    local lineName = "ESOA_GUI2_Body_ListHolder_Line_"..viewName.."_" ..charKey  
    --create the line holder
    local line = ESOA_GUI2_Body_ListHolder:GetNamedChild('_Line_'..viewName.."_"..charKey)
    if(line==nil)then
      line = WINDOW_MANAGER:CreateControlFromVirtual(lineName, ESOA_GUI2_Body_ListHolder, "ESOA_RowTemplate")
    end
    line:SetHidden(false)
    if(mainParent==nil)then
      line:SetAnchor(TOPLEFT, ESOA_GUI2_Body_ListHolder, TOPLEFT, 0, 5)    
    else
      line:SetAnchor(TOPLEFT, mainParent, BOTTOMLEFT, 0, -10)    
    end
    line.charKey = charKey
    line:SetHandler("OnMouseEnter", function(self) ElderScrollsOfAlts:GuiLineOnMouseEnter(self) end )
    line:SetHandler("OnMouseExit", function(self) ElderScrollsOfAlts:GuiLineOnMouseExit(self) end )
    line:SetHandler("OnMouseDoubleClick", function(...) ElderScrollsOfAlts:GUILineDoubleClick(...) end )
    --
    mainParent = line
    parent = line
    table.insert( ESOA_GUI2_Body_ListHolder.displayedLines, line)
    
    -- create the base name entry
    local entry = "Name"
    --ESOA_GUI2_Body_ListHolder_Line_<NAME>_Name
    local eline = parent:GetNamedChild('_'..entry )    
    if(eline==nil)then
      eline = WINDOW_MANAGER:CreateControlFromVirtual(lineName.."_"..entry, parent, "ESOA_RowTemplate_Label")        
    end
    eline:SetText( playerline.name ) --TODO get function to get display name              
    eline:SetHidden(false) 
    eline:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, 0)
    --eline:SetDimensions(ElderScrollsOfAlts.GuiSortBarLookupDisplayWidth(entry),30)--TODO get function to get display         
    eline:SetDimensions(180,25)    
    eline:SetMaxLineCount(180)
    eline.tooltip = playerline.name.."("..k_entry..")"
    eline.entry   = entry
    eline.charKey = charKey
    eline:SetMouseEnabled(true)
    eline:SetHandler('OnMouseEnter',function(self)
        ElderScrollsOfAlts:TooltipEnter(self, self.entry)
    end)
    eline:SetHandler('OnMouseExit',function(self)
        ElderScrollsOfAlts:TooltipExit(self)
    end)
    builtWidthL = builtWidthL + eline:GetWidth()
    
    --create the other entries
    local predecessor = eline
    --parent      = ESOA_GUI2_Body_ListHolder
    local viewName = viewTemplateC.name
    local viewData = viewTemplateC.view
    for i = 1, #viewData do
      entry = viewData[i]    
      --ElderScrollsOfAlts.debugMsg("RefreshGuiCharListing:"," entry='", tostring(entry), "'")
      eline = ElderScrollsOfAlts.GuiCharLineLookupDisplayType(viewName,entry,lineName,parent)
      if(eline==nil) then
        ElderScrollsOfAlts.debugMsg("Ack! Virtual control is nil?")
        --return
      else
        eline:SetHidden(false)
        eline:SetDimensions(ElderScrollsOfAlts.GuiSortBarLookupDisplayWidth(entry),30)--TODO get function to get display         
        eline:SetAnchor(TOPLEFT, predecessor, TOPRIGHT, 0, 0)
        eline:SetMouseEnabled(true)
        eline:SetHandler('OnMouseEnter',function(self)
            ElderScrollsOfAlts:TooltipEnter(self, self.entry)
        end)
        eline:SetHandler('OnMouseExit',function(self)
            ElderScrollsOfAlts:TooltipExit(self)
        end)
        --eline:SetHandler('OnClicked',function(self)
         --PlaySound(SOUNDS.POSITIVE_CLICK)        
          --ElderScrollsOfAlts:DoGuiSort(self, entry )
        --end)        
        --eline:SetText( ElderScrollsOfAlts.GuiSortBarLookupDisplayText(entry) )--TODO get function to get display name        
        ElderScrollsOfAlts.GuiCharLineLookupPopulateData(viewName,entry,eline,playerline)
        eline.entry = entry
        eline.charKey=charKey
        table.insert(ESOA_GUI2_Body_ListHolder.displayedEntries, eline)
        builtWidthL = builtWidthL + eline:GetWidth()
        predecessor = eline
      end
    end--for viewTemplate viewData
    if(builtWidthL>builtWidth) then builtWidth = builtWidthL end
    --if(line:GetWidth() > builtWidth)then
    --  builtWidth = line:GetWidth()
    --end  
  end --FOR EACH CHAR in category 
  
  builtWidth = builtWidth + 20 --PADDINGgui
  --debugMsg("builtWidth="..tostring(builtWidth) )
  --unless locked reset window width
  if( ESOA_GUI2_Header_Locked:IsHidden() ) then
    ESOA_GUI2:SetWidth( builtWidth )
  end
  --TODO not working, need refresh??
  
  ElderScrollsOfAlts:GuiResizeScroll()
  ElderScrollsOfAlts:UpdateDataScroll()
  --ElderScrollsOfAlts:DoGuiSort(self,true) BROKEN here!!
  --TODO resize?
  --TODO Selection
  --TODO UnSelection
  --TODO ZO_ScrollList_SetDeselectOnReselect
end


-- VIEWS -- 
-----------

-----------
-- SETUP -- 

function ElderScrollsOfAlts.SetupDefaultColors()
  --
end

function ElderScrollsOfAlts.InitializeGui()
  ElderScrollsOfAlts.debugMsg("InitializeGui:"," Called!")
  
  --TODO
  --if(ElderScrollsOfAlts.savedVariables.gui==nil) then
    --ElderScrollsOfAlts.savedVariables.gui = ()
    ElderScrollsOfAlts.savedVariables.gui = {}
    ElderScrollsOfAlts.savedVariables.gui[1] = {
      ["name"] = "Home",
      ["view"] = {
        [1] = "Note",
        [2] = "Special",
        [3] = "Alliance",
        [4] = "Class",
        [5] = "Level",
        [6] = "Gender",
        [7] = "Race",
        [8] = "Alchemy",
        [9] = "Smithing",
        [10] = "Clothing",
        [11] = "Enchanting",
        [12] = "Jewelry",
        [13] = "Provisioning",
        [14] = "Woodworking",        
        [15] = "BagSpace",        
        [16] = "BagSpaceFree",        
        [17] = "Skillpoints",
      }
    }
    ElderScrollsOfAlts.savedVariables.gui[2] = {
      ["name"]="Equip",
      ["view"] = {
        [1] = "Head",
        [2] = "Shoulders",
        [3] = "Chest",
        [4] = "Hands",
        [5] = "Waist",
        [6] = "Legs",
        [7] = "Feet",
        [8] = "Neck",
        [9] = "Ring1",
        [10] = "Ring2",
        [11] = "M1",
        [12] = "M2",
        [13] = "Mp",
        [14] = "O1",
        [15] = "O2",
        [16] = "Op",
        [17] = "Heavy",
        [18] = "Medium",
        [19] = "Light",
      },
    }
    ElderScrollsOfAlts.savedVariables.gui[3] = {
      ["name"] = "Research",
      ["view"] = {
        [1] = "Clothier Research 1",
        [2] = "Clothier Research 2",
        [3] = "Clothier Research 3",
        [4] = "Blacksmithing Research 1",
        [5] = "Blacksmithing Research 2",
        [6] = "Blacksmithing Research 3",
        [7] = "Woodworking Research 1",
        [8] = "Woodworking Research 2",
        [9] = "Woodworking Research 3",
        [10] = "Jewelcrafting Research 1",
        [11] = "Jewelcrafting Research 2",
        [12] = "Jewelcrafting Research 3",
      },
    }
    ElderScrollsOfAlts.savedVariables.gui[4] = {
      ["name"] = "Skills",
      ["view"] = {
        [1] = "Assault",
        [2] = "Support",
        [3] = "Legerdemain",
        [4] = "Soul Magic",
        [5] = "Werewolf",
        [6] = "Vampire",
        [7] = "Fighters Guild",
        [8] = "Mages Guild",
        [9] = "Undaunted",
        [10] = "Thieves Guild",
        [11] = "Dark Brotherhood",
        [12] = "Psijic Order",
        
        [13] = "Riding Speed",
        [14] = "Riding Stamina",
        [15] = "Riding Inventory",
        [16] = "Riding Timer",
      },
    }
  --end
  if(ElderScrollsOfAlts.view.currentcategory==nil)then
    ElderScrollsOfAlts.view.currentcategory = "All"
  end
  
  -- Initialize 
  ESOATooltip:SetParent(PopupTooltipTopLevel)
  --ESOACraftTooltip:SetParent(PopupTooltipTopLevel)
  --ESOAEquipTooltip:SetParent(PopupTooltipTopLevel)
  --ElderScrollsOfAlts:GuiSetupDropdownA()
  
  --Setup Base GUI
  local pName = GetUnitName("player")
  local sVal = zo_strformat("(<<C:1>>)", pName )
  ESOA_GUI2_Header_WhoAmI:SetText(sVal)
  
  --Calc Upper Header Min Width
  local mainHdrMinWidth = ESOA_GUI2_Header_Locked:GetWidth() + 
    ESOA_GUI2_Header_Label:GetWidth() + 
    ESOA_GUI2_Header_Hide:GetWidth() + 
    ESOA_GUI2_Header_Minimize:GetWidth() + 
    ESOA_GUI2_Header_CategorySelect:GetWidth() + 
    ESOA_GUI2_Header_SortUp:GetWidth() + 
    ESOA_GUI2_Header_SortDown:GetWidth() + 
    ESOA_GUI2_Header_SortBy_Value:GetWidth() + 
    ESOA_GUI2_Header_WhoAmI:GetWidth()
  ElderScrollsOfAlts.debugMsg("mainHdrMinWidth=",tostring(mainHdrMinWidth))
  
  --ElderScrollsOfAlts.savedVariables.selected.category
  ElderScrollsOfAlts:GuiSetupCategoryButton(self)  
  --ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI2_Body_CharList)
end

--Called from Delayed Start
function ElderScrollsOfAlts:RestoreUI()
  if ElderScrollsOfAlts.savedVariables.uibutton.shown then
    ElderScrollsOfAlts.ShowUIButton()
  else
    ElderScrollsOfAlts.HideUIButton()
  end
end

-- SETUP -- 
-----------

-----------
--  VIEW-- 
--
function ElderScrollsOfAlts:DoGuiSort(control,newSort,sortText)
  ElderScrollsOfAlts.debugMsg("DoGuiSort: called w/sortText='", tostring(sortText), "'")
  --ElderScrollsOfAlts.debugMsg("DoGuiSort: called w/sortKey='"..tostring(control.sortKey).."'")
  --
	if ESOA_GUI2_Body_ListHolder.displayedLines == nil then 
    ElderScrollsOfAlts.debugMsg("DoGuiSort: no display to sort")
    return
  end
  if(ElderScrollsOfAlts.savedVariables.currentsort==nil)then
    ElderScrollsOfAlts.savedVariables.currentsort = {}
  end
  if(ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]==nil)then
    ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView] = {}
    ElderScrollsOfAlts.debugMsg("DoGuiSort: created struct for view=",ElderScrollsOfAlts.savedVariables.currentView)
  end
  
  --
  if(sortText~=nil and string.len(sortText) > 0 )then
    ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["key"] = (sortText)
    ElderScrollsOfAlts.debugMsg("DoGuiSort: set per sortText")
  end
  if(newSort~=nil and newSort) then
    ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["order"] = not ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["order"]
  end
  ElderScrollsOfAlts.debugMsg("DoGuiSort: current view=",ElderScrollsOfAlts.savedVariables.currentView )
  --ElderScrollsOfAlts.debugMsg("DoGuiSort: current key =", ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["key"] )
  if(ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["key"]==nil or string.len(ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["key"]) < 1 ) then
    ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["key"] = "name"
    ElderScrollsOfAlts.debugMsg("DoGuiSort: set key to default name")
  end
  
  --Easy vars
  local currentSortKey   = ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["key"]
  local currentSortOrder = ElderScrollsOfAlts.savedVariables.currentsort[ElderScrollsOfAlts.savedVariables.currentView]["order"]
  ElderScrollsOfAlts.view.currentSortKey   = currentSortKey
  ElderScrollsOfAlts.view.currentSortOrder = currentSortOrder
  ElderScrollsOfAlts.savedVariables.currentSortKey   = nil
  ElderScrollsOfAlts.savedVariables.currentSortOrder = nil
  ElderScrollsOfAlts.debugMsg("DoGuiSort: called w/currentSortKey='", ElderScrollsOfAlts.view.currentSortKey,"' currentSortOrder='", ElderScrollsOfAlts.view.currentSortOrder,"'")

  --setup function
  --1 normal
  --2 use Rank
  --3 use underscore replace spaces
  local gSearch = nil
  local gSearch1 = function (a,b)
    local aVal = a[ElderScrollsOfAlts.view.currentSortKey]
    local bVal = b[ElderScrollsOfAlts.view.currentSortKey]
    local value1Type = type(aVal)
    if(bVal == nil) then 
        if(value1Type=="string") then bVal = "nil"  end
    end
    ElderScrollsOfAlts.debugMsg("ESOA: aVal="..tostring(aVal).." bVal="..tostring(bVal))
    --debugMsg("ESOA: a.name="..a.name.." b.name="..b.name)
    if(currentSortOrder) then
      return bVal > aVal or bVal == aVal and b.name < a.name
    else
      return aVal > bVal or aVal == bVal and a.name < b.name
    end
  end
  local gSearch2 = function (a,b)
    local skey = ElderScrollsOfAlts.view.currentSortKey.."_Rank"
    local aVal = a[skey]
    local bVal = b[skey]
    local value1Type = type(aVal)
    if(bVal == nil) then 
        if(value1Type=="string") then bVal = "nil"  end
    end
    --if(aVal == nil) then aVal = "nil" end
    --if(bVal == nil) then bVal = "nil" end    
    if(ElderScrollsOfAlts.view.currentSortOrder) then
      return bVal > aVal or bVal == aVal and b.name < a.name
    else
      return aVal > bVal or aVal == bVal and a.name < b.name
    end
  end
  local gSearch3 = function (a,b)
    local skey = ElderScrollsOfAlts.view.currentSortKey:gsub(" ","_")
    local aVal = a[skey]
    local bVal = b[skey]
    if(aVal == nil) then aVal = "nil" end
    if(bVal == nil) then bVal = "nil" end
    if(ElderScrollsOfAlts.view.currentSortOrder) then
      return bVal > aVal or bVal == aVal and b.name < a.name
    else
      return aVal > bVal or aVal == bVal and a.name < b.name
    end
  end
  
  --
  gSearch =  gSearch1
  local testEntry1 = ESOA_GUI2_Body_ListHolder.dataLines[1]
  if(testEntry1==nil) then
    gSearch = nil
  elseif( testEntry1[ElderScrollsOfAlts.view.currentSortKey.."_Rank"] ~=nil ) then
    gSearch = gSearch2
  --elseif( testEntry1[ ElderScrollsOfAlts.view.currentSortKey:gsub(" ","_") ] ~=nil ) then
  --  gSearch = gSearch3
  end

  --local sortedData = 
  table.sort( ESOA_GUI2_Body_ListHolder.dataLines, gSearch )
 
  if(newSort~=nil and newSort) then
    ElderScrollsOfAlts:RefreshGuiCharListing(ElderScrollsOfAlts.savedVariables.currentView)  
  end
  --ElderScrollsOfAlts:RefreshGuiCharListing(ElderScrollsOfAlts.savedVariables.currentView)
  ElderScrollsOfAlts:GuiSetupCategoryButton(self)  
  
  
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", ElderScrollsOfAlts.view.currentSortKey )
  ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  
  -- Sort Arrows
  if( not ElderScrollsOfAlts.view.currentSortOrder ) then
    ESOA_GUI2_Header_SortUp:SetHidden(false)
    ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    ESOA_GUI2_Header_SortUp:SetHidden(true)
    ESOA_GUI2_Header_SortDown:SetHidden(false)
  end
  
	--ESOA_GUI2_Body_ListHolder.dataOffset = 0
end--DOGUISORT

-- returns true if it had to be resized, otherwise false
function ElderScrollsOfAlts:GuiResizeScroll()
	local regionHeight = ESOA_GUI2_Body_ListHolder:GetHeight()
  local rowHeight    = ESOA_GUI2_Body_ListHolder.rowHeight
	local newLines = math.floor(regionHeight / rowHeight)
  ElderScrollsOfAlts.debugMsg("GuiResizeScroll: newLines=", tostring(newLines) )
	if ESOA_GUI2_Body_ListHolder.maxLines == nil or ESOA_GUI2_Body_ListHolder.maxLines ~= newLines then
		ESOA_GUI2_Body_ListHolder.maxLines = newLines
		ElderScrollsOfAlts:GuiResizeLines()
	end
end

function ElderScrollsOfAlts:GuiResizeLines()
	--local lines
	if not ESOA_GUI2_Body_ListHolder.displayedLines then
    return
		--TODOlines = ElderScrollsOfAlts:CreateInventoryScroll()
	end
	--if ESOA_GUI2_Body_ListHolder.displayedLines ~= {} then
	--	lines = ESOA_GUI2_Body_ListHolder.lines
	--end

	for index, line in ipairs(ESOA_GUI2_Body_ListHolder.displayedLines) do
--		line.text:SetWidth(textwidth)
--		line:SetWidth(linewidth)
		line:SetHidden(index > ESOA_GUI2_Body_ListHolder.maxLines)
    --debugMsg("Hidden line index="..tostring(index > ESOA_GUI2_Body_ListHolder.maxLines))
	end
end

function ElderScrollsOfAlts:GuiOnScroll(control, delta)  
	if not delta then return end
  ElderScrollsOfAlts.debugMsg("GuiOnScroll: delta="..tostring(delta) )
	if delta == 0 then return end

	local slider = ESOA_GUI2_Body_ListHolder_Slider
	local value = (ESOA_GUI2_Body_ListHolder.dataOffset - delta)
  --TODO use ESOA_GUI2_Body_ListHolder.displayedLines?
	local total = #ESOA_GUI2_Body_ListHolder.displayedLines - ESOA_GUI2_Body_ListHolder.maxLines

	if value < 0 then value = 0 end
	if value > total then value = total end
	ESOA_GUI2_Body_ListHolder.dataOffset  = value
  ElderScrollsOfAlts.debugMsg("GuiOnScroll: set dataOffset="..tostring(value) )

	ElderScrollsOfAlts:UpdateDataScroll()

	slider:SetValue(ESOA_GUI2_Body_ListHolder.dataOffset)

	--ElderScrollsOfAlts:GuiLineOnMouseEnter(moc())
end

function ElderScrollsOfAlts:GuiOnSliderUpdate(slider, value)
	if not value or slider.locked then return end
	local relativeValue = math.floor(ESOA_GUI2_Body_ListHolder.dataOffset - value)
  ElderScrollsOfAlts.debugMsg("GuiOnSliderUpdate: relativeValue=" ..tostring(relativeValue) .. " value="..tostring(value) .. " offset="..tostring(ESOA_GUI2_Body_ListHolder.dataOffset)  )
	ElderScrollsOfAlts:GuiOnScroll(slider, relativeValue)
end

function ElderScrollsOfAlts:UpdateDataScroll()
  local index = 0
	if ESOA_GUI2_Body_ListHolder.dataOffset < 0 then ESOA_GUI2_Body_ListHolder.dataOffset = 0 end
	if ESOA_GUI2_Body_ListHolder.maxLines == nil then
		ESOA_GUI2_Body_ListHolder.maxLines = ESOA_GUI2_Body_ListHolder.defaultMaxLines
	end
	--TODO SetDataLinesData()--Fill in data from datalines
  --ElderScrollsOfAlts:SetupGuiCharListing(viewName)--??

	local total = #ESOA_GUI2_Body_ListHolder.dataLines - ESOA_GUI2_Body_ListHolder.maxLines
	ESOA_GUI2_Body_ListHolder_Slider:SetMinMax(0, total)
  
end

--ESOA_GUI2
function ElderScrollsOfAlts:onMoveStop()  
  ElderScrollsOfAlts.savedVariables.window.top    = ESOA_GUI2:GetTop()
  ElderScrollsOfAlts.savedVariables.window.left   = ESOA_GUI2:GetLeft()
  ElderScrollsOfAlts.debugMsg("Saved Moved top and left")
  if not ElderScrollsOfAlts.savedVariables.window.minimized and not ElderScrollsOfAlts.savedVariables.window.justone then
    ElderScrollsOfAlts.savedVariables.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.savedVariables.window.height = ESOA_GUI2:GetHeight()  
    ElderScrollsOfAlts.debugMsg("Saved Moved width and height")
  end
end

--ESOA_GUI2
function ElderScrollsOfAlts:onResizeStart() 
  	EVENT_MANAGER:RegisterForUpdate(ElderScrollsOfAlts.name.."OnWindowResize", 50,
      function() 
        ElderScrollsOfAlts:GuiResizeScroll() 
        ElderScrollsOfAlts:UpdateDataScroll()
      end
    )
end

--ESOA_GUI2
function ElderScrollsOfAlts:onResizeStop()
  
	-- if you resize the box, you need to resize the list to go with it
	-- local sceneName = :GetCurrentSceneName()
	EVENT_MANAGER:UnregisterForUpdate(ElderScrollsOfAlts.name.."OnWindowResize")
  --debugMsg("Resize start")
  --TODO ElderScrollsOfAlts:GuiResizeScroll()
  --TODO ElderScrollsOfAlts:UpdateDataScroll()
  if not ElderScrollsOfAlts.savedVariables.window.minimized and not ElderScrollsOfAlts.savedVariables.window.justone then
    ElderScrollsOfAlts.savedVariables.window.top    = ESOA_GUI2:GetTop()
    ElderScrollsOfAlts.savedVariables.window.left   = ESOA_GUI2:GetLeft()
    ElderScrollsOfAlts.savedVariables.window.width  = ESOA_GUI2:GetWidth()
    ElderScrollsOfAlts.savedVariables.window.height = ESOA_GUI2:GetHeight()
    ElderScrollsOfAlts.debugMsg("Saved resized width and height, top and left")
    --
    --TODO
    --update scroll height/width (has to be done manually?)
    --ESOA_GUI2_Body
    --<Anchor point="TOPLEFT"     relativeTo="$(parent)_Header" relativePoint="BOTTOMLEFT" />
    --<Anchor point="BOTTOMRIGHT" relativeTo="$(parent)" relativePoint="BOTTOMRIGHT" />
    --TODO ESOA_GUI2_Body:ClearAnchors()
    --ESOA_GUI2_Body:SetAnchor(TOPLEFT, "ESOA_GUI2_Header", TOPLEFT, 
    --  ElderScrollsOfAlts.savedVariables.window.left, ElderScrollsOfAlts.savedVariables.window.top)
    --TODO ESOA_GUI2_Body:SetAnchor(BOTTOMRIGHT, "ESOA_GUI2", BOTTOMRIGHT)    
    --ESOA_GUI2_Body_ListHolder
    
    --ESOA_GUI2_Body:SetAnchor(BOTTOMRIGHT, "$(parent)", BOTTOMRIGHT)    
    --ESOA_GUI2_Body_ListHolder:SetAnchor(BOTTOMRIGHT, "$(parent)", 0,200 )    
    
    ESOA_GUI2_Header:SetWidth( ESOA_GUI2:GetWidth() )
    --??ESOA_GUI2_Body_ListHolder:SetWidth( ESOA_GUI2:GetWidth() )   
    
    
    --ZO_ScrollList_SetHeight(ESOA_GUI2_Body_CharList, ESOA_GUI2_Body:GetHeight())
    --ZO_ScrollList_UpdateScroll(ESOA_GUI2_Body_CharList)
    --ZO_ScrollList_Commit(ESOA_GUI2_Body_CharList)  
    
    ElderScrollsOfAlts:GuiResizeScroll()
    ElderScrollsOfAlts:UpdateDataScroll()
    --debugMsg("Resize done")
  end
end

--Row Select
function ElderScrollsOfAlts:SelectCharacterRow(self)
  --TODO
  --Select the Row
  --local data = ZO_ScrollList_GetData(self) --rowControl)
  --ZO_ScrollList_SelectData(ESOA_GUI2_Body_CharList, data, self)
  
  --Get the selected row's data
  --local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_CharList)  
  --if selectedData ~= nil then
  --  ElderScrollsOfAlts.debugMsg("SelectCharacterRow: Name=" , tostring(selectedData.name))
  --else
  --  ElderScrollsOfAlts.debugMsg("SelectCharacterRow: selectedData:"," is nil")
  --end
end

function ElderScrollsOfAlts:ToggleGuiCharacterDetails(self)
  ElderScrollsOfAlts.debugMsg("ToggleGuiCharacterDetails:"," Called")
  if(ESOA_CharDetails:IsHidden())then
    ElderScrollsOfAlts:CloseGuiCharacterDetails(self)    
  else
    ElderScrollsOfAlts:ShowGuiCharacterDetails(self)
  end
end
function ElderScrollsOfAlts:CloseGuiCharacterDetails(self)
  ESOA_CharDetails:SetHidden(true)
end
function ElderScrollsOfAlts:ShowGuiCharacterDetails(self)
  ElderScrollsOfAlts.debugMsg("ShowGuiCharacterDetails:"," Called") 
end

function ElderScrollsOfAlts:GUI2Lock(bLock)
  --debugMsg("GUI2Lock bLock: "..tostring(bLock) )
	ESOA_GUI2_Header_Locked:SetHidden(not bLock)
	ESOA_GUI2_Header_Unlocked:SetHidden(bLock)
	ESOA_GUI2:SetMovable(not bLock)

	if bLock then
		ESOA_GUI2:SetResizeHandleSize(0)
	else
		ESOA_GUI2:SetResizeHandleSize(10)
	end
end
--ESOA_GUI2
function ElderScrollsOfAlts.HideGui2()
    ESOA_GUI2:SetHidden(true)
    ESOA_GUI2_Notes:SetHidden(true)
end

function ElderScrollsOfAlts:GUI2Minimize(bMin)
  ElderScrollsOfAlts.debugMsg("GUI2Minimize Called, bMin=",tostring(bMin) )
end


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
      --debugMsg("List: players " .. k)
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
  --ElderScrollsOfAlts.debugMsg
  ElderScrollsOfAlts.debugMsg("categoryS=",tostring(categoryS) )
  local foundC = false
  local nextC = false
  for i = 1, #validChoices do
		local entry = validChoices[i]
    ElderScrollsOfAlts.debugMsg("entry=",tostring(entry) )
    if(nextC)then
      ElderScrollsOfAlts.savedVariables.selected.category = entry
      ElderScrollsOfAlts.debugMsg("setting selected per nextC as ",entry )
      nextC = false
      break
    end
    if(entry==categoryS)then
      nextC  = true
      foundC = true
      ElderScrollsOfAlts.debugMsg("found categoryS")
    end
	end
  if(not foundC or nextC or categoryS==ElderScrollsOfAlts.savedVariables.selected.category) then
    ElderScrollsOfAlts.debugMsg("reset category to All")
    ElderScrollsOfAlts.savedVariables.selected.category = "All"
  end
  ElderScrollsOfAlts:GuiSetupCategoryButton(self)  
  ElderScrollsOfAlts:ShowSetView()
end



-- VIEW -- 
-----------


--------------
-- TOOLTIPS -- 

--UI
function ElderScrollsOfAlts:EquipShowTip(myLabel,equipName)
  local itemLink = myLabel.itemlink
  if(itemLink~=nil) then
    --debugMsg("EquipShowTip itemLink is set")
    ZO_PopupTooltip_SetLink(itemLink)
  else
    --debugMsg("EquipShowTip itemLink is nil")
  end
  --[[
  --Sends a link to chat
  --ZO_LinkHandler_InsertLink(zo_strformat(SI_TOOLTIP_ITEM_NAME, itemLink)) 
  ]]
end


function ElderScrollsOfAlts:GuiLineOnMouseEnter(control)
  if not control then return end
  --TODO
end

function ElderScrollsOfAlts:GuiLineOnMouseExit(self)
  --ClearTooltip(ESOATooltip)
  --TODO
end

function ElderScrollsOfAlts:GUILineDoubleClick(control, button)
  --ElderScrollsOfAlts.debugMsg("GUILineDoubleClick: Called")
  if button == MOUSE_BUTTON_INDEX_LEFT and control.itemLink then
		if control.itemLink ~= "" then
			ZO_ChatWindowTextEntryEditBox:SetText(ZO_ChatWindowTextEntryEditBox:GetText() .. zo_strformat(SI_TOOLTIP_ITEM_NAME, control.itemLink))
		end
    if(ESOA_GUI2_Body_ListHolder.selectedHighlight ~=nil) then
      --unselect
    end    
    --control:SetTexture(ESOA_RowTemplate_Highlight) TODO
    ESOA_GUI2_Body_ListHolder.selectedHighlight = control
  elseif button == MOUSE_BUTTON_INDEX_RIGHT and control.charKey then  
    ElderScrollsOfAlts.savedVariables.selected.charactername = control.charKey
    ElderScrollsOfAlts.view.selectedPlayerRow = control
    ElderScrollsOfAlts:ShowCharacterNote(control)
	end
end

function ElderScrollsOfAlts:ToolTipHeaderEnterSort(sender)
  local senderName = sender.entry 
  ElderScrollsOfAlts:Misc2HeaderTipEnter(sender,senderName)
end
function ElderScrollsOfAlts:ToolTipHeaderExitSort(sender)
  ElderScrollsOfAlts:Misc2HeaderTipExit(sender)
end

function ElderScrollsOfAlts:Misc2HeaderTipEnter(sender,key)
  InitializeTooltip(ESOATooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  ESOATooltip:AddLine(key, "ZoFontHeader3")
end

--UI
function ElderScrollsOfAlts:Misc2HeaderTipExit(sender)
  ClearTooltip(ESOATooltip)
end


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

--ESOACraftTooltip EQUIP Tooltip
function ElderScrollsOfAlts:EquipTipEnter(myLabel,equipName)    
  local itemLink = myLabel.itemlink
  if(itemLink==nil) then
    return
  end
  --debugMsg("nVal=" .. tostring(nVal) .." equipName=" .. tostring(craftName))  
  local traitType, traitDescription = GetItemLinkTraitInfo(itemLink)
  local requiredLevel = GetItemLinkRequiredLevel(itemLink)
  local requiredCp    = GetItemLinkRequiredChampionPoints(itemLink)
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

--ESOACraftTooltip CRAFT Tooltip
function ElderScrollsOfAlts:CraftTipEnter(myLabel,craftName)  
  --ElderScrollsOfAlts.debugMsg("CraftTipEnter: myLabel='",myLabel," craftName='", tostring(craftName).."'")
  if( craftName == nil ) then return end 
  local nVal = tonumber(myLabel.data_sunk)
  if( nVal == nil ) then return end 
  local nVal2 = nil  
  if( myLabel.data_sunk ~= nil ) then
    nVal2 = tonumber(myLabel.data_sunk2)
  end
  
  --ElderScrollsOfAlts.debugMsg("CraftTipEnter: nVal='",nVal," craftName='", (craftName).."'")
  local tDesc = "Unknown"
  tDesc = ElderScrollsOfAlts:GetCraftSunkText(craftName, nVal)  
  if(tDesc == nil) then
   tDesc = "Unknown"  
  end
  
  local tDesc2 = nil
  local craftName2 = string.format("%s%s",craftName,"2")
  tDesc2 = ElderScrollsOfAlts:GetCraftSunkText(craftName2, nVal2)  
  if(tDesc2 == nil) then
   tDesc2 = "Unknown"  
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

function ElderScrollsOfAlts:Misc2TipEnter(myLabel,equipName)
  local itemLink  = myLabel.name
  local hoverover = myLabel.hoverover 
  InitializeTooltip(InformationTooltip, myLabel, TOPLEFT, 5, -56, TOPRIGHT)  
  if(itemLink~=nil)then
    InformationTooltip:AddLine(string.format("(%s)",itemLink), "ZoFontGame")  
  end
  if(hoverover~=nil ) then
    InformationTooltip:AddLine(string.format("(%s)"     , myLabel.hoverover), "ZoFontGame")
    --InformationTooltip:AddLine(string.format("Trait: %s", myLabel.traitDesc), "ZoFontGame")
    --InformationTooltip:AddLine(string.format("(Known? %s)"     , tostring(myLabel.traitknown)), "ZoFontGame")
  end
  if(itemLink==nil and hoverover==nil ) then
    InformationTooltip:AddLine(string.format("(%s=%s)"   , equipName, myLabel:GetText() ), "ZoFontGame")
  end
end

--UI
function ElderScrollsOfAlts:Misc2TipExit(myLabel)  
  ClearTooltip(InformationTooltip)
end

function ElderScrollsOfAlts:TooltipEnter(mySelf,tooltipName)  
  --ElderScrollsOfAlts.debugMsg("TooltipEnter: tooltipName='"..tostring(tooltipName).."'")
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
  elseif(tooltipName=="Special") then
    local nSpecial = tonumber(mySelf.special)
    --debugMsg("TooltipEnter: nSpecial='"..tostring(nSpecial).."'")
    if( nSpecial == nil or nSpecial == 0 ) then return end
    if( nSpecial == 1 ) then
      tooltipDesc  = "Werewolf"  
    elseif( nSpecial == 2 ) then
      tooltipDesc  = "Vampire"
    end
  else
    if(mySelf.tooltip~=nil)then
      tooltipDesc = mySelf.tooltip
    else
      --tooltipDesc = tooltipName
    end
  end
  --ElderScrollsOfAlts.debugMsg("TooltipEnter: tooltipDesc='"..tostring(tooltipDesc).."' tooltipTitle='"..tostring(tooltipTitle).."'")
  if( tooltipDesc == nil and tooltipTitle == nil) then return end 
  InitializeTooltip(ESOATooltip, mySelf, TOPLEFT, 5, -76, TOPRIGHT)
  if tooltipTitle ~= nil then
    ESOATooltip:AddLine(tooltipTitle, "ZoFontGameBold")
  end
  if tooltipDesc ~= nil then
    ESOATooltip:AddLine(tooltipDesc, "ZoFontGame")
  end
end

function ElderScrollsOfAlts:TooltipExit(myLabel,craftName)  
  ClearTooltip(ESOATooltip)
end

-- TOOLTIPS --
--------------

----------
-- SORT -- 

function ElderScrollsOfAlts:GuiSortChar(sender,keyname)
  --ElderScrollsOfAlts:GuiSortCharBase(keyname,false,sender)
end
--Sort
function ElderScrollsOfAlts:GuiSort(keyname)
  --ElderScrollsOfAlts:GuiSortCharBase(keyname)
end

-- SORT --
----------



-----------
-----------

