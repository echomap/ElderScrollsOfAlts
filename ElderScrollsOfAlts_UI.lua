-- GUI Elements (Control/Show/Hide/View)

--On Load, restore or hide button
function ElderScrollsOfAlts.RestoreUI()
  if ElderScrollsOfAlts.savedVariables.uibutton.shown then
    ElderScrollsOfAlts.ShowUIButton()
  else
    ElderScrollsOfAlts.HideUIButton()
  end
end

--Button
function ElderScrollsOfAlts.DoUiButtonClicked()
  local isShown = ElderScrollsOfAlts.GetUIShown()
  if not isShown then
    ElderScrollsOfAlts:ShowGuiByChoice()    
  else
    ElderScrollsOfAlts:HideGuiByChoice()
  end  
end

-- HIDE All
function ElderScrollsOfAlts.HideAll()
  ESOA_ButtonFrame:SetHidden(true)
  --ElderScrollsOfAlts:HideGui1()
  ElderScrollsOfAlts:HideGuiByChoice()  
end

--UIButton
function ElderScrollsOfAlts.ShowUIButton()
  --d("ShowUIButton called. left="..tostring(ElderScrollsOfAlts.savedVariables.uibutton.left))
  ESOA_ButtonFrame:SetHidden(false)
  ESOA_ButtonFrame:ClearAnchors()
  ESOA_ButtonFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
      ElderScrollsOfAlts.savedVariables.uibutton.left, ElderScrollsOfAlts.savedVariables.uibutton.top)
end

--UIButton
function ElderScrollsOfAlts.HideUIButton()
  ESOA_ButtonFrame:SetHidden(true)
end

--UIButton
function ElderScrollsOfAlts.GetUIButtonShown()
  return ElderScrollsOfAlts.savedVariables.uibutton.shown
end

--UIButton
function ElderScrollsOfAlts.SetUIButtonShown(value)
  ElderScrollsOfAlts.savedVariables.uibutton.shown = value
  if not value then
    ElderScrollsOfAlts.HideUIButton()
  else
    ElderScrollsOfAlts.ShowUIButton()
  end  
end

--UIButton
function ElderScrollsOfAlts:ButtonFrameOnMoveStop()
  ElderScrollsOfAlts.savedVariables.uibutton.top    = ESOA_ButtonFrame:GetTop()
  ElderScrollsOfAlts.savedVariables.uibutton.left   = ESOA_ButtonFrame:GetLeft()
  --d("ButtonFrameOnMoveStop called. left="..tostring(ElderScrollsOfAlts.savedVariables.uibutton.left))
end

--Shared
function ElderScrollsOfAlts.GetUIShown()
  return not ESOA_GUI2:IsHidden()
end

--Show the View previously shown
function ElderScrollsOfAlts:ShowGuiByChoice()
  ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  ElderScrollsOfAlts:Gui2SortRefresh()
  ElderScrollsOfAlts:GuiEquipSortRefresh()
  
  if(ElderScrollsOfAlts.savedVariables.currentView == "Research") then     
    ElderScrollsOfAlts:GUIShowViewResearch()
  elseif(ElderScrollsOfAlts.savedVariables.currentView == "Other") then     
    ElderScrollsOfAlts:GUIShowViewMisc2()
  elseif(ElderScrollsOfAlts.savedVariables.currentView == "Equip") then     
    ElderScrollsOfAlts:GUIShowViewEquip()
  elseif(ElderScrollsOfAlts.savedVariables.currentView == "Skills") then     
    ElderScrollsOfAlts:GUIShowViewMisc2()
  else
    ElderScrollsOfAlts:GUIShowViewHome()
  end
end

--Hide GUI
function ElderScrollsOfAlts:HideGuiByChoice()
  ElderScrollsOfAlts:HideGui2() 
end

--View, Setup and Show
function ElderScrollsOfAlts:ShowGuiEquip()
  ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  ElderScrollsOfAlts:Gui2SortRefresh()
  
  ElderScrollsOfAlts.savedVariables.currentView = "Equip"
  ElderScrollsOfAlts:GUIShowViewEquip()
end

--View, Setup and Show
function ElderScrollsOfAlts:ShowGuiHome()
  ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  ElderScrollsOfAlts:Gui2SortRefresh()
  
  ElderScrollsOfAlts.savedVariables.currentView = "Home"
  ElderScrollsOfAlts:GUIShowViewHome()
end


--View, switch (not setup, just switched to if UI already shown)
function ElderScrollsOfAlts:GUIShowViewHome()
  ESOA_GUI2_Body_CharListHeader:SetHidden(false)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  ESOA_GUI2_Body_ResearchListHeader:SetHidden(true)
  ESOA_GUI2_Body_Misc2ListHeader:SetHidden(true)
  ESOA_GUI2_Body_CharList:SetHidden(false)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(true)  	
  ESOA_GUI2_Body_List_Research:SetHidden(true)
  ESOA_GUI2_Body_List_Misc2:SetHidden(true)
  ElderScrollsOfAlts:Gui2SortRefresh()
  ElderScrollsOfAlts.savedVariables.currentView = "Home"
end

--View, switch (not setup, just switched to if UI already shown)
function ElderScrollsOfAlts:GUIShowViewEquip()  
  ESOA_GUI2_Body_CharListHeader:SetHidden(true)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(false)
  ESOA_GUI2_Body_ResearchListHeader:SetHidden(true)
  ESOA_GUI2_Body_Misc2ListHeader:SetHidden(true)
  ESOA_GUI2_Body_CharList:SetHidden(true)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(false)
  ESOA_GUI2_Body_List_Research:SetHidden(true)
  ESOA_GUI2_Body_List_Misc2:SetHidden(true)
  ElderScrollsOfAlts:GuiEquipSortRefresh()
  ElderScrollsOfAlts.savedVariables.currentView = "Equip"
end

--View, switch (not setup, just switched to if UI already shown)
function ElderScrollsOfAlts:GUIShowViewResearch()  
  ESOA_GUI2_Body_CharListHeader:SetHidden(true)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  ESOA_GUI2_Body_ResearchListHeader:SetHidden(false)
  ESOA_GUI2_Body_Misc2ListHeader:SetHidden(true)
  ESOA_GUI2_Body_CharList:SetHidden(true)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(true)
  ESOA_GUI2_Body_List_Research:SetHidden(false)
  ESOA_GUI2_Body_List_Misc2:SetHidden(true)
  ElderScrollsOfAlts:GuiResearchSortRefresh()
  ElderScrollsOfAlts.savedVariables.currentView = "Research"
end

--View, switch (not setup, just switched to if UI already shown)
function ElderScrollsOfAlts:GUIShowViewMisc2()  
  ESOA_GUI2_Body_CharListHeader:SetHidden(true)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  ESOA_GUI2_Body_ResearchListHeader:SetHidden(true)
  ESOA_GUI2_Body_Misc2ListHeader:SetHidden(false)
  ESOA_GUI2_Body_CharList:SetHidden(true)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(true)
  ESOA_GUI2_Body_List_Research:SetHidden(true)
  ESOA_GUI2_Body_List_Misc2:SetHidden(false)
  ElderScrollsOfAlts.savedVariables.currentView = "Research"
end

--ESOA_GUI2
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

--ESOA_GUI2
function ElderScrollsOfAlts:onResizeStart() 
  --
end

--ESOA_GUI2
function ElderScrollsOfAlts:onResizeStop()
  --d("Resize start")
  --TODO XX:GuiResizeScroll()
  --TODO XX:UpdateInventoryScroll()
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

--ESOA_GUI2
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
  ESOA_GUI2_Body_Divider:SetHidden(bMin)

  --Sizing
  if bMin then
    --ElderScrollsOfAlts.savedVariables.window.restoreheight = ESOA_GUI2:GetHeight()
    ESOA_GUI2:SetHeight(20)
    --ElderScrollsOfAlts:HideGuiByChoice()
    --Hdr
    ESOA_GUI2_Body_CharListHeader:SetHidden(bMin)
    ESOA_GUI2_Body_EquipListHeader:SetHidden(bMin)
    ESOA_GUI2_Body_ResearchListHeader:SetHidden(bMin)
    ESOA_GUI2_Body_Misc2ListHeader:SetHidden(bMin)
    --Body  
    ESOA_GUI2_Body_CharList:SetHidden(bMin)
    ESOA_GUI2_Body_List_EQUIP:SetHidden(bMin)
    ESOA_GUI2_Body_List_Research:SetHidden(bMin)
    ESOA_GUI2_Body_List_Misc2:SetHidden(bMin)
  else
    ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
    ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data   
    ElderScrollsOfAlts:Gui2SortRefresh()

    if(ElderScrollsOfAlts.savedVariables.currentView == "Research") then     
      ESOA_GUI2_Body_ResearchListHeader:SetHidden(bMin)
      ESOA_GUI2_Body_List_Research:SetHidden(bMin)
    elseif(ElderScrollsOfAlts.savedVariables.currentView == "Equip") then     
      ESOA_GUI2_Body_EquipListHeader:SetHidden(bMin)
      ESOA_GUI2_Body_List_EQUIP:SetHidden(bMin)
    elseif(ElderScrollsOfAlts.savedVariables.currentView == "Other1") then     
      ESOA_GUI2_Body_Misc2ListHeader:SetHidden(bMin)
      ESOA_GUI2_Body_List_Misc2:SetHidden(bMin)
    else
      ESOA_GUI2_Body_CharListHeader:SetHidden(bMin)
      ESOA_GUI2_Body_CharList:SetHidden(bMin)
    end
  
    --local rHt = ElderScrollsOfAlts.savedVariables.window.restoreheight
    --if rHt == nil then
    --  rHt = ElderScrollsOfAlts.savedVariables.window.height
    --end    
    ESOA_GUI2:SetHeight(ElderScrollsOfAlts.savedVariables.window.height)
    --ElderScrollsOfAlts:ShowGuiByChoice()
  end  
end

--ESOA_GUI2
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

--ESOA_GUI2
function ElderScrollsOfAlts.HideGui2()
    ESOA_GUI2:SetHidden(true)
    ESOA_GUI2_Notes:SetHidden(true)
end

--ESOA_GUI2
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

--SETTINGS For use by Settings dropdown
function ElderScrollsOfAlts:SelectCharacterName(choiceText)
  ElderScrollsOfAlts.savedVariables.selected.charactername = choiceText
end

--SETTINGS selects this category
function ElderScrollsOfAlts:SelectCategory(choiceText)
  ElderScrollsOfAlts.savedVariables.selected.category = choiceText  
end

--SETTINGS For use by Settings dropdown
function ElderScrollsOfAlts:DoCategoryForSelectedCharacter()
  local charname = ElderScrollsOfAlts.savedVariables.selected.charactername
  ElderScrollsOfAlts:debugMsg("DoCategoryForSelectedCharacter: Name=" .. tostring(charname)) 

  local categoryS = ElderScrollsOfAlts.savedVariables.selected.category
  ElderScrollsOfAlts:debugMsg("DoCategoryForSelectedCharacter: Category=" .. tostring(categoryS))  
 
  ElderScrollsOfAlts.altData.players[charname].category = categoryS
end

--SETTINGS For use by Settings dropdown
function ElderScrollsOfAlts:DoDeleteSelectedCharacter()
  local charname = ElderScrollsOfAlts.savedVariables.selected.charactername
  ElderScrollsOfAlts:debugMsg("DoDeleteSelectedCharacter: Name=" .. tostring(charname))
  ElderScrollsOfAlts.altData.players[charname] = nil
end


-----Character Details Screen

function ElderScrollsOfAlts:ToggleGuiCharacterDetails(self)
  ElderScrollsOfAlts:debugMsg("ToggleGuiCharacterDetails: Called")
  if(ESOA_CharDetails:IsHidden())then
    ElderScrollsOfAlts:CloseGuiCharacterDetails(self)    
  else
    ElderScrollsOfAlts:ShowGuiCharacterDetails(self)
  end
end

--
--if already being shown, close and reopen for this character
function ElderScrollsOfAlts:ShowGuiCharacterDetails(self)
  ElderScrollsOfAlts:debugMsg("ShowGuiCharacterDetails: Called") 
  
  --
  ElderScrollsOfAlts:HideGuiCharacterNote(self)
  ElderScrollsOfAlts:CloseGuiCharacterDetails(self)
  
  --
  local selectedData = ElderScrollsOfAlts.view.SelectedDataNode
  if selectedData == nil then
    ElderScrollsOfAlts:debugMsg("ShowGuiCharacterDetails: selectedData is nil")
    return
  end    
  ElderScrollsOfAlts:debugMsg("ShowGuiCharacterDetails: Req  Name="..tostring(selectedData.name))
  
  --Populate with Selected Data  
  --TODO
  --ElderScrollsOfAlts:ShowGuiCharacterNote(self, selectedData)
  --TODO ElderScrollsOfAlts.savedVariables.selected.charactername = selectedData.name
  
  --Show
  ESOA_CharDetails:SetHidden(false)
  --ShowGuiCharacterDetails
end

function ElderScrollsOfAlts:CloseGuiCharacterDetails(self)
  ESOA_CharDetails:SetHidden(true)
  --ElderScrollsOfAlts.view.SelectedDataNode = nil
  --ESOA_GUI2_Notes_Index_Note:SetText("")
  --ESOA_GUI2_Notes_Category_Edit:SetText("")
  --ESOA_GUI2_Notes:SetHidden(true)
end
 

