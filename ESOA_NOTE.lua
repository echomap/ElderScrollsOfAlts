--

function ElderScrollsOfAlts:ShowCharacterNote(self)
  local charactername = ElderScrollsOfAlts.savedVariables.selected.charactername  
  --Select the Row
  ElderScrollsOfAlts.debugMsg("ShowCharacterNote:"," SelChar=",tostring(ElderScrollsOfAlts.savedVariables.selected.charactername) )
  ElderScrollsOfAlts.debugMsg("ShowCharacterNote:"," SelRow=",tostring(ElderScrollsOfAlts.view.selectedPlayerRow) )
  
  local selectedPlayer = ElderScrollsOfAlts.view.playerLines[ElderScrollsOfAlts.savedVariables.selected.charactername]
  ElderScrollsOfAlts.debugMsg("ShowCharacterNote: selectedPlayer="..tostring(selectedPlayer) )
  ElderScrollsOfAlts.view.selectedPlayerData = selectedPlayer
  
  ElderScrollsOfAlts:ShowGuiCharacterNote(self)
end

function ElderScrollsOfAlts:ShowGuiCharacterNote(self)
  if(ElderScrollsOfAlts.view.selectedPlayerData==nil)then
    d("ESOA, failed to get selected character to display note")
    return
  end  
  
  ESOA_GUI2_Notes:SetHidden(false)
  ESOA_GUI2_Notes:ClearAnchors()
  ESOA_GUI2_Notes:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
    self:GetLeft(), self:GetTop()+100
    --ElderScrollsOfAlts.savedVariables.uibutton.left, 
    --ElderScrollsOfAlts.savedVariables.uibutton.top )
  )  
  ESOA_GUI2_Notes:SetHeight( 150 )
  ESOA_GUI2_Notes:SetWidth(  300 )
    
  local pNote = ElderScrollsOfAlts.view.selectedPlayerData["note"]
  --d("selectedData="..tostring(selectedData))
  if( pNote == nil ) then
    --
  end
  local sVal = zo_strformat("(<<C:1>>)", ElderScrollsOfAlts.view.selectedPlayerData["name"] )
  
  ESOA_GUI2_Header_WhoAmI:SetText(sVal)
  ESOA_GUI2_Notes_WhoAmI:SetText(sVal)
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ElderScrollsOfAlts:ResetNote()
end

function ElderScrollsOfAlts:ResetNote()
  local tplayer = ElderScrollsOfAlts.view.selectedPlayerData
  if( tplayer == nil ) then
    d("ESOA, failed to get selected character for note")
    return
  end
  
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  
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


function ElderScrollsOfAlts:SaveNote()
  local tplayer = ElderScrollsOfAlts.view.selectedPlayerData
  if( tplayer == nil ) then
    d("ESOA, failed to get selected character to save note")
    return
  end
  tplayer.note = ESOA_GUI2_Notes_Index_Note:GetText()
  --local pName = GetUnitName("player")
  --if(pName==splayer.rawname) then
  ElderScrollsOfAlts.view.currentnote = tplayer.note
  ElderScrollsOfAlts.SavePlayerData( tplayer.rawname, "note", tplayer.note)
  --end
  
  local selCat = ESOA_GUI2_Notes_Category_Edit:GetText()
  if(selCat==nil)then
    selCat = "All"
  end
  d("ESOA, saved cat="..tostring(selCat))
  tplayer.category = selCat
  ElderScrollsOfAlts.SavePlayerData( tplayer.rawname, "category", tplayer.category)
  --if(pName==splayer.rawname) then
  ElderScrollsOfAlts.view.currentcategory = tplayer.category
  --end
  d("ESOA, saved note")
end

function ElderScrollsOfAlts:CloseNote(self)
  ElderScrollsOfAlts.view.selectedPlayerRow = nil
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ESOA_GUI2_Notes:SetHidden(true)
end


--EOF