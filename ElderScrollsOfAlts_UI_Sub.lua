-- GUI Elements

function ElderScrollsOfAlts:GUIShowViewHome()
  ESOA_GUI2_Body_CharListHeader:SetHidden(false)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(true)
  ESOA_GUI2_Body_CharList:SetHidden(false)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(true)  	
  ElderScrollsOfAlts.savedVariables.currentView = "Home"
end
function ElderScrollsOfAlts:GUIShowViewEquip()
  ESOATooltip:SetParent(PopupTooltipTopLevel)
  ESOA_GUI2_Body_CharListHeader:SetHidden(true)
  ESOA_GUI2_Body_EquipListHeader:SetHidden(false)
  ESOA_GUI2_Body_CharList:SetHidden(true)
  ESOA_GUI2_Body_List_EQUIP:SetHidden(false)
  ElderScrollsOfAlts.savedVariables.currentView = "Equip"
end

-- Tooltip handler
function ElderScrollsOfAlts:TraitTipEnter(sender,key)
  --InitializeTooltip(InformationTooltip, resultButton, TOPRIGHT, 0, 0, BOTTOMLEFT)
  InitializeTooltip(ESOATooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  --InitializeTooltip(ESOATooltip, sender, TOPLEFT, -10, -10, BOTTOMLEFT)
  ElderScrollsOfAlts:TraitTipLookupDesc(ESOATooltip,key)
  ElderScrollsOfAlts:TraitTipLookupName(ESOATooltip,key)
  --SetTooltipText(ESOATooltip, "Test123" ZO_NORMAL_TEXT)
end
function ElderScrollsOfAlts:TraitTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(ESOATooltip)
end
function ElderScrollsOfAlts:TraitTipLookupDesc(lTooltip,key)  
  --lTooltip:AddVerticalPadding(14)
  local ttld = {
    --["name"] = "Name",
    --["head"] = "Head",
  }
  if( ttld[key] ~= nil) then
    lTooltip:AddHeaderLine(ttld[key], "ZoFontGameLarge", 1, TOOLTIP_HEADER_SIDE_LEFT, ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())  
    --AddLineTitle(lTooltip, "test line 134", ZO_NORMAL_TEXT)
    --lTooltip:AddVerticalPadding(-9)
  end
end
function ElderScrollsOfAlts:TraitTipLookupName(lTooltip,key)
  lTooltip:AddLine(key, "ZoFontHeader3")
end


--Gui3 (called from XML)
function ElderScrollsOfAlts:SetupGui3(selectedData)
	--local settings = IIfA:GetSceneSettings()
	--settings.hidden = true
  if ElderScrollsOfAlts.savedVariables.window.top ~= nil then
    local left = 40
    local top  = 100
    ESOA_GUI2_SUB:ClearAnchors()
    ESOA_GUI2_SUB:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 
        ElderScrollsOfAlts.savedVariables.window.left, ElderScrollsOfAlts.savedVariables.window.top+300 )
    --ESOA_GUI2_SUB:SetHeight( 100 ) --ElderScrollsOfAlts.savedVariables.window.height)
    --ESOA_GUI2_SUB:SetWidth(  100 ) --ElderScrollsOfAlts.savedVariables.window.width )
  end  
  if selectedData then 
    if selectedData == ESOA_GUI2_SUB.selectedData then
      ElderScrollsOfAlts:HideGui3()
    else    
      ESOA_GUI2_SUB_Body_Label:SetText( selectedData.name )
      --TODO ESOA_GUI2_SUB_Body_BackupMain:SetTexture( ElderScrollsOfAlts.items.backupmainicon )      
    end
    --ESOA_GUI2_SUB_Header_Label:SetText( selectedData.name )
  end
  ESOA_GUI2_SUB.selectedData = selectedData
end

--Gui3
function ElderScrollsOfAlts:HideGui3()
    ESOA_GUI2_SUB:SetHidden(true)
end

--Gui2
function ElderScrollsOfAlts:ShowGui3(selectedData)
  ESOA_GUI2_SUB:SetHidden(false)
  if not ESOA_GUI2_SUB:IsHidden() then 
  end
  if selectedData then
    ElderScrollsOfAlts:SetupGui3(selectedData)
  end  
end

--Gui3
function ElderScrollsOfAlts:onMoveStop3()  
end

--Gui3
function ElderScrollsOfAlts:onResizeStart3() 
  --
end

--Gui3
function ElderScrollsOfAlts:onResizeStop3()
  --
end

--Gui3
function ElderScrollsOfAlts:GuiSetupDropdown3()
  ElderScrollsOfAlts.debugMsg("GuiSetupDropdown3 Called!")
	ESOA_GUI2_SUB_Header_Dropdown.comboBox = ESOA_GUI2_SUB_Header_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_SUB_Header_Dropdown)
	local comboBox = ESOA_GUI2_SUB_Header_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
  
  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI2_SUB_Header_Dropdown)
  --ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI_PAGE1_List)
end

function ElderScrollsOfAlts:doShowCharacterEquip()
    if ESOA_GUI2_SUB.selectedData ~= nil then
    else
    end    
end

function ElderScrollsOfAlts:doShowCharacterStats()
    if ESOA_GUI2_SUB.selectedData ~= nil then
    else
    end  
end
