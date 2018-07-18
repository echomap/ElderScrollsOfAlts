-- GUI Elements

--Gui3 (called from XML)
function ElderScrollsOfAlts:SetupGui3()
	--local settings = IIfA:GetSceneSettings()
	--settings.hidden = true
  if ElderScrollsOfAlts.settings.window.top ~= nil then
    local left = 80
    local top  = 80
    ESOA_GUI2_EQUIP:ClearAnchors()
    ESOA_GUI2_EQUIP:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
    ESOA_GUI2_EQUIP:SetHeight(ElderScrollsOfAlts.settings.window.height)
    ESOA_GUI2_EQUIP:SetWidth( ElderScrollsOfAlts.settings.window.width )
 end
end

--Gui3
function ElderScrollsOfAlts.HideGui3()
    ESOA_GUI2_EQUIP:SetHidden(true)
end

--Gui2
function ElderScrollsOfAlts.ShowGui3()
  if not ESOA_GUI2_EQUIP:IsHidden() then 
    ESOA_GUI2_EQUIP:SetHidden(true)
  else
    ESOA_GUI2_EQUIP:SetHidden(false)
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
	ESOA_GUI2_EQUIP_Header_Dropdown.comboBox = ESOA_GUI2_EQUIP_Header_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI2_EQUIP_Header_Dropdown)
	local comboBox = ESOA_GUI2_EQUIP_Header_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
  
  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI2_EQUIP_Header_Dropdown)
  --ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI_PAGE1_List)
end
