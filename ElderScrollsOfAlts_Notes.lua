-----------
-- NOTES --
-----------

----------------
--NOTES UTILS --
----------------

function ElderScrollsOfAlts:ShowGuiCharacterNote(self, selectedData)
  ESOA_GUI2_Notes:SetHidden(false)
  ESOA_GUI2_Notes:ClearAnchors()
  ESOA_GUI2_Notes:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
    self:GetLeft(), self:GetTop()+100
    --ElderScrollsOfAlts.savedVariables.uibutton.left, 
    --ElderScrollsOfAlts.savedVariables.uibutton.top )
  )  
  ESOA_GUI2_Notes:SetHeight( 150 )
  ESOA_GUI2_Notes:SetWidth(  300 )
  
  --d("selectedData="..tostring(selectedData))
  if( ElderScrollsOfAlts.view.SelectedDataNode == nil ) then
    ElderScrollsOfAlts.view.SelectedDataNode = selectedData
  end
  local sVal = zo_strformat("(<<C:1>>)", ElderScrollsOfAlts.view.SelectedDataNode.name )
  ESOA_GUI2_Header_WhoAmI:SetText(sVal)
  ESOA_GUI2_Notes_WhoAmI:SetText(sVal)
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ElderScrollsOfAlts:ResetNote()
end

function ElderScrollsOfAlts:CloseNote(self)
  ElderScrollsOfAlts.view.SelectedDataNode = nil
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ESOA_GUI2_Notes:SetHidden(true)
end
 
function ElderScrollsOfAlts:ResetNote()
  local splayer = ElderScrollsOfAlts.view.SelectedDataNode
  if( splayer == nil ) then
    d("ESOA, failed to get selected character for note")
    return
  end
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  local tplayer = ElderScrollsOfAlts.altData.players[splayer.rawname] --not name as is display
  if( tplayer == nil ) then
    d("ESOA, failed to get character for note")
    return
  end  
  if( tplayer ~= nil ) then
    local note = tplayer.note
    if( note ~= nil ) then
      ESOA_GUI2_Notes_Index_Note:SetText(note)
    end
    local catH = tplayer.category
    if(catH == nil) then
      catH = "All"
    end
    ESOA_GUI2_Notes_Category_Edit:SetText(catH)
  end
end

function ElderScrollsOfAlts:SaveNote()
  local splayer = ElderScrollsOfAlts.view.SelectedDataNode
  --d("SaveNote: splayer="..tostring(splayer) )
  if( splayer == nil ) then
    d("ESOA, failed to get selected character to save note")
    return
  end
  --d("SaveNote: splayer.name="..tostring(splayer.name) )
  local tplayer = ElderScrollsOfAlts.altData.players[splayer.rawname] --not name as is display
  --d("SaveNote: splayer="..tostring(splayer) )
  if( tplayer == nil ) then
    d("ESOA, failed to get character to save note")
    return
  end
  tplayer.note = ESOA_GUI2_Notes_Index_Note:GetText()
  local pName = GetUnitName("player")
  if(pName==splayer.rawname) then
    ElderScrollsOfAlts.view.currentnote = tplayer.note
  end
  
  local selCat = ESOA_GUI2_Notes_Category_Edit:GetText()
  if(selCat==nil)then
    selCat = "All"
  end
  d("ESOA, saved cat="..tostring(selCat))
  tplayer.category = selCat
  if(pName==splayer.rawname) then
    ElderScrollsOfAlts.view.currentcategory = tplayer.category
  end
  d("ESOA, saved note")
end

function ElderScrollsOfAlts:HideGuiCharacterNote(self,selectedData)
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ESOA_GUI2_Notes:SetHidden(true)
end

----------------
--NOTES UTILS --
----------------

----------
-- GUI2 --
----------
--Gui2 - via row mouse event on Main GUI
function ElderScrollsOfAlts:SelectCharacterNote1(self)
    --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_CharList, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_CharList)  
  local previousSelected = ElderScrollsOfAlts.view.SelectedDataNode
  if selectedData == nil then
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote1: selectedData is nil")
    return
  end    
  ElderScrollsOfAlts:debugMsg("SelectCharacterNote1: Req  Name="..tostring(selectedData.name))
  if(previousSelected==nil) then
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote1: Prev Name= is nil")
  else
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote1: Prev Name="..tostring(previousSelected.name))
  end
  
  --Toggle off, if selected is the same  
  if( previousSelected ~= nil and previousSelected.name == selectedData.name ) then
    ElderScrollsOfAlts.view.SelectedDataNode = nil
    ElderScrollsOfAlts:HideGuiCharacterNote(self)
    --TODO ElderScrollsOfAlts.savedVariables.selected.charactername = nil
  else
    ElderScrollsOfAlts.view.SelectedDataNode = selectedData        
    ElderScrollsOfAlts:ShowGuiCharacterNote(self, selectedData)
    --TODO ElderScrollsOfAlts.savedVariables.selected.charactername = selectedData.name
  end      
end

--Gui2 - via row mouse event on Equip GUI
function ElderScrollsOfAlts:SelectCharacterNote2(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_EQUIP, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_EQUIP)  
  local previousSelected = ElderScrollsOfAlts.view.SelectedDataNode
  if selectedData == nil then
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote2: selectedData is nil")
    return
  end    
  ElderScrollsOfAlts:debugMsg("SelectCharacterNote2: Req  Name="..tostring(selectedData.name))
  if(previousSelected==nil) then
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote2: Prev Name= is nil")
  else
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote2: Prev Name="..tostring(previousSelected.name))
  end
  
  --Toggle off, if selected is the same  
  if( previousSelected ~= nil and previousSelected.name == selectedData.name ) then
    ElderScrollsOfAlts:HideGuiCharacterNote(self)    
    ElderScrollsOfAlts.view.SelectedDataNode = nil
  else
    ElderScrollsOfAlts:ShowGuiCharacterNote(self, selectedData)
    ElderScrollsOfAlts.view.SelectedDataNode = selectedData
  end  
end

--Gui2 - via row mouse event on Misc1/Research GUI
function ElderScrollsOfAlts:SelectCharacterNote3(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_Misc1, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_Misc1)  
  local previousSelected = ElderScrollsOfAlts.view.SelectedDataNode
  if selectedData == nil then
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote2: selectedData is nil")
    return
  end
  --Toggle off, if selected is the same  
  if( previousSelected ~= nil and previousSelected.name == selectedData.name ) then
    ElderScrollsOfAlts:HideGuiCharacterNote(self)    
    ElderScrollsOfAlts.view.SelectedDataNode = nil
  else
    ElderScrollsOfAlts:ShowGuiCharacterNote(self, selectedData)
    ElderScrollsOfAlts.view.SelectedDataNode = selectedData
  end  
end

--Gui2 - via row mouse event on Other1 GUI
function ElderScrollsOfAlts:SelectCharacterNote4(self)
  --Select the Row
  local data = ZO_ScrollList_GetData(self) --rowControl)
  ZO_ScrollList_SelectData(ESOA_GUI2_Body_List_Misc2, data, self)
  
  --Get the selected row's data
  local selectedData = ZO_ScrollList_GetSelectedData(ESOA_GUI2_Body_List_Misc2)  
  local previousSelected = ElderScrollsOfAlts.view.SelectedDataNode
  if selectedData == nil then
    ElderScrollsOfAlts:debugMsg("SelectCharacterNote2: selectedData is nil")
    return
  end
  --Toggle off, if selected is the same  
  if( previousSelected ~= nil and previousSelected.name == selectedData.name ) then
    ElderScrollsOfAlts:HideGuiCharacterNote(self)    
    ElderScrollsOfAlts.view.SelectedDataNode = nil
  else
    ElderScrollsOfAlts:ShowGuiCharacterNote(self, selectedData)
    ElderScrollsOfAlts.view.SelectedDataNode = selectedData
  end  
end
