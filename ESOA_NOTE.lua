----------------------------------------
--[[ ESOA UI ]]-- 
----------------------------------------
-- Player Note processing and saving
------------------------------------------ 


------------------------------
-- 
function ElderScrollsOfAlts:ShowCharacterNote(self)
	local charactername = ElderScrollsOfAlts.savedVariables.selected.charactername
	--Select the Row
	ElderScrollsOfAlts.outputMsg("ShowCharacterNote:"," SelChar=", tostring(charactername) )
	ElderScrollsOfAlts.outputMsg("ShowCharacterNote:"," SelRow=" , tostring(ElderScrollsOfAlts.view.selectedPlayerRow) )
	--
	local selectedPlayer = ElderScrollsOfAlts.view.playerLines[charactername]
	ElderScrollsOfAlts.view.selectedPlayerData = selectedPlayer
	ElderScrollsOfAlts.outputMsg("ShowCharacterNote: selectedPlayer="..tostring(selectedPlayer) )
	ElderScrollsOfAlts.outputMsg("ShowCharacterNote: selectedPlayer rawname="..tostring(selectedPlayer.rawname) )
	ElderScrollsOfAlts.outputMsg("ShowCharacterNote: selectedPlayer charkey="..tostring(selectedPlayer.charkey) )
	--
	ElderScrollsOfAlts:ShowGuiCharacterNote(self)
end

function ElderScrollsOfAlts:ShowGuiCharacterNote(self)
  if(ElderScrollsOfAlts.view.selectedPlayerData==nil)then
    ElderScrollsOfAlts.errorMsg("failed to get selected character to display note")
    return
  end  
  
  ESOA_GUI2_Notes:SetHidden(false)
  ESOA_GUI2_Notes:ClearAnchors()
  ESOA_GUI2_Notes:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
    self:GetLeft(), ESOA_GUI2:GetHeight()
	--self:GetTop() + 100
    --ElderScrollsOfAlts.savedVariables.uibutton.left, 
    --ElderScrollsOfAlts.savedVariables.uibutton.top )
  )  
  ESOA_GUI2_Notes:SetHeight( 150 )
  ESOA_GUI2_Notes:SetWidth(  300 )
    
  local pNote = ElderScrollsOfAlts.view.selectedPlayerData["note"]
  --debugMsg("selectedData="..tostring(selectedData))
  if( pNote == nil ) then
    --
  end
  local sVal = zo_strformat("(<<C:1>>)", ElderScrollsOfAlts.view.selectedPlayerData["name"] )
  
  ESOA_GUI2_Notes_WhoAmI:SetText(sVal)
  ESOA_GUI2_Notes_WhoAmI:SetText(sVal)
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ESOA_GUI2_Notes_Order_Edit:SetText("")
  ElderScrollsOfAlts:ResetNote()
end

function ElderScrollsOfAlts:ResetNote()
  local tplayer = ElderScrollsOfAlts.view.selectedPlayerData
  if( tplayer == nil ) then
    ElderScrollsOfAlts.errorMsg("failed to get selected character for note")
    return
  end
  
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ESOA_GUI2_Notes_Order_Edit:SetText("")
  
  local note = tplayer.note
  if( note ~= nil ) then
    ESOA_GUI2_Notes_Index_Note:SetText(note)
  end
  local catH = tplayer.category
  if(catH == nil) then
    catH = ElderScrollsOfAlts.CATEGORY_ALL
  end
  ESOA_GUI2_Notes_Category_Edit:SetText(catH)
  
  local playersorder = tplayer.playersorder
  if( playersorder ~= nil ) then
    ESOA_GUI2_Notes_Order_Edit:SetText(playersorder)
  end
  --
end

--
function ElderScrollsOfAlts:SaveNote()
  local tplayer = ElderScrollsOfAlts.view.selectedPlayerData
  if( tplayer == nil ) then
    ElderScrollsOfAlts.errorMsg("failed to get selected character to save note")
    return
  end
  tplayer.note = ESOA_GUI2_Notes_Index_Note:GetText()
  ElderScrollsOfAlts.view.currentnote = tplayer.note
    if( tplayer.rawname~=nil ) then
	ElderScrollsOfAlts.SavePlayerData( tplayer.rawname, "note", tplayer.note )
  else
	local charactername = ElderScrollsOfAlts.savedVariables.selected.charactername
	ElderScrollsOfAlts.outputMsg( "SaveNote: charactername=", charactername )
	ElderScrollsOfAlts.SavePlayerData( charactername, "note", tplayer.note )
  end
  -- ORDER --
  local selOrder = ESOA_GUI2_Notes_Order_Edit:GetText()
  if(selOrder==nil or selOrder=="")then
    selOrder = 0
  end
  selOrder = tonumber(selOrder)
  tplayer.playersorder = selOrder
  -- Save --
  if( tplayer.rawname~=nil ) then
	ElderScrollsOfAlts.SavePlayerData( tplayer.rawname, "playersorder", tplayer.playersorder)
  else
	local charactername = ElderScrollsOfAlts.savedVariables.selected.charactername
	ElderScrollsOfAlts.outputMsg( "SaveNote: charactername=", charactername )
	ElderScrollsOfAlts.SavePlayerData( charactername, "playersorder", tplayer.playersorder)
  end
  ElderScrollsOfAlts.view.currentorder = tplayer.playersorder
  -- CATEGORY --
  local selCat = ESOA_GUI2_Notes_Category_Edit:GetText()
  if(selCat==nil or selCat=="")then
    selCat = ElderScrollsOfAlts.CATEGORY_ALL
  end
  tplayer.category = selCat
  -- Save --
  if( tplayer.rawname~=nil ) then
	ElderScrollsOfAlts.SavePlayerData( tplayer.rawname, "category", tplayer.category)
  else
	local charactername = ElderScrollsOfAlts.savedVariables.selected.charactername
	ElderScrollsOfAlts.outputMsg( "SaveNote: charactername=", charactername )
	ElderScrollsOfAlts.SavePlayerData( charactername, "category", tplayer.category)
  end
  ElderScrollsOfAlts.view.currentcategory = tplayer.category
  -- OUTPUT --
  ElderScrollsOfAlts.outputMsg( zo_strformat("ESOA, saved note, order=<<1>>/cat=<<2>>", tostring(selOrder) , tostring(selCat) ) )
  --
  --ElderScrollsOfAlts.outputMsg("ESOA, saved note")
  --ElderScrollsOfAlts.RefreshViewableTable()
  ElderScrollsOfAlts:ShowSetView()
end

function ElderScrollsOfAlts:CloseNote(self)
  ElderScrollsOfAlts.view.selectedPlayerRow = nil
  ESOA_GUI2_Notes_Index_Note:SetText("")
  ESOA_GUI2_Notes_Category_Edit:SetText("")
  ESOA_GUI2_Notes_Order_Edit:SetText("")
  ESOA_GUI2_Notes:SetHidden(true)
end


--EOF
----------------------------------------
----------------------------------------