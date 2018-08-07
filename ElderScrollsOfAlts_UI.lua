-- GUI Elements (Control/Show/Hide/View)

--On Load, what to restore
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

--
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

--Gui2
function ElderScrollsOfAlts.RestoreGui2()
  --Check that wants to show, and min or not?
  --if ElderScrollsOfAlts.savedVariables.window.hiddenonpurpose then
  --ElderScrollsOfAlts:RestoreIconfify()
  --ElderScrollsOfAlts.savedVariables.uibutton.shown
  --end
end

--Shared
function ElderScrollsOfAlts.GetUIShown()
  return not ESOA_GUI2:IsHidden()
end

--Shared
function ElderScrollsOfAlts:ShowGuiByChoice()
  ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  ElderScrollsOfAlts:Gui2SortRefresh()
  ElderScrollsOfAlts:GuiEquipSortRefresh()
  
  if(ElderScrollsOfAlts.savedVariables.currentView == "Equip") then     
    ElderScrollsOfAlts:GUIShowViewEquip()
  else
    ElderScrollsOfAlts:GUIShowViewHome()
  end
end

--Shared
function ElderScrollsOfAlts:HideGuiByChoice()
  ElderScrollsOfAlts:HideGui2() 
end

--Shared, call from Bindings
function ElderScrollsOfAlts:ShowGuiEquip()
  ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  ElderScrollsOfAlts:Gui2SortRefresh()
  
  ElderScrollsOfAlts.savedVariables.currentView = "Equip"
  ElderScrollsOfAlts:GUIShowViewEquip()
end

--Shared, call from Bindings
function ElderScrollsOfAlts:ShowGuiHome()
  ElderScrollsOfAlts.loadPlayerData() -- read data from game into addon
  ElderScrollsOfAlts:SetupGui2(self)  -- Setup Display of addon data     
  ElderScrollsOfAlts:ShowGui2()       -- Display GUI
  ElderScrollsOfAlts:Gui2SortRefresh()
  
  ElderScrollsOfAlts.savedVariables.currentView = "Home"
  ElderScrollsOfAlts:GUIShowViewHome()
end