--


--Gui1
function ElderScrollsOfAlts:SetupGuiPage1(self)
  ElderScrollsOfAlts:debugMsg("SetupGuiPage1 Called!")
	ESOA_GUI_PAGE1_Dropdown.comboBox = ESOA_GUI_PAGE1_Dropdown.comboBox or ZO_ComboBox_ObjectFromContainer(ESOA_GUI_PAGE1_Dropdown)
	local comboBox = ESOA_GUI_PAGE1_Dropdown.comboBox
	comboBox:ClearItems()
	comboBox:SetSortsItems(false)
	--ESOA_GUI_PAGE1_Dropdown:SetHidden(false)  
  
  ElderScrollsOfAlts:SetupGuiCharDropDown(self, comboBox, ESOA_GUI_PAGE1_Dropdown)
  ElderScrollsOfAlts:SetupGuiCharListing(self,  ESOA_GUI_PAGE1_List)
end

