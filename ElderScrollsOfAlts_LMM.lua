--
local LMM = LibStub("LibMainMenu")

-- display the menu
function ElderScrollsOfAlts:Show(viaButton)
	LMM:ToggleCategory(ElderScrollsOfAlts.MENU_CATEGORY_ESOA,viaButton)
	--if not self.sceneGroup:IsShowing() then
		--LMM:ToggleCategory(self.BASE_MENU, viaButton)
	--end
end

function ElderScrollsOfAlts.ToggleShowing()
    --d(ElderScrollsOfAlts.name .. "ESOA_GUI:IsHidden() ".. ESOA_GUI:IsHidden() ) -- Prints to chat.
    --if ESOA_GUI:IsHidden() then
	--ESOA_GUI:SetHidden(false)
    --elseif not ESOA_GUI:IsHidden() then
	--ESOA_GUI:SetHidden(true)
    --end
    
    --Update Me
    ElderScrollsOfAlts.loadPlayerData()

    -- Toggle
    LMM:ToggleCategory(ElderScrollsOfAlts.MENU_CATEGORY_ESOA)
    -- Toggle
    --LMM:Update(MENU_CATEGORY_MYADDON, "MyAddonAnother")
end


--PCHAT -> ESOA
function ElderScrollsOfAlts.SetupLMM()

	-- Create Scene
	ESOA_AUTOMSG_SCENE = ZO_Scene:New("elderScrollsOfAltsAutomatedMessagesScene", SCENE_MANAGER)

	-- Mouse standard position and background
	ESOA_AUTOMSG_SCENE:AddFragmentGroup(FRAGMENT_GROUP.MOUSE_DRIVEN_UI_WINDOW)
	ESOA_AUTOMSG_SCENE:AddFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)

	-- Background Right, it will set ZO_RightPanelFootPrint and its stuff.
	ESOA_AUTOMSG_SCENE:AddFragment(RIGHT_BG_FRAGMENT)

	-- The title fragment
	ESOA_AUTOMSG_SCENE:AddFragment(TITLE_FRAGMENT)

	-- Set Title
	ZO_CreateStringId("SI_ESOA_AUTOMSG_TITLE", ElderScrollsOfAlts.displayName)
	ESOA_AUTOMSG_TITLE_FRAGMENT = ZO_SetTitleFragment:New(SI_ESOA_AUTOMSG_TITLE)
	ESOA_AUTOMSG_SCENE:AddFragment(ESOA_AUTOMSG_TITLE_FRAGMENT)

	-- Add the XML to our scene
	ESOA_AUTOMSG_SCENE_WINDOW = ZO_FadeSceneFragment:New(ESOA_GUI_PAGE1)
	ESOA_AUTOMSG_SCENE:AddFragment(ESOA_AUTOMSG_SCENE_WINDOW)

	-- Register Scenes and the group name
	--SCENE_MANAGER:AddSceneGroup("elderScrollsOfAltsSceneGroup", ZO_SceneGroup:New("elderScrollsOfAltsAutomatedMessagesScene"))

--
	-- Create Scene 2
	ESOA_AUTOMSG_SCENE2 = ZO_Scene:New("elderScrollsOfAltsAutomatedMessagesScene2", SCENE_MANAGER)

	-- Mouse standard position and background
	ESOA_AUTOMSG_SCENE2:AddFragmentGroup(FRAGMENT_GROUP.MOUSE_DRIVEN_UI_WINDOW)
	ESOA_AUTOMSG_SCENE2:AddFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)

	-- Background Right, it will set ZO_RightPanelFootPrint and its stuff.
	ESOA_AUTOMSG_SCENE2:AddFragment(RIGHT_BG_FRAGMENT)

	-- The title fragment
	ESOA_AUTOMSG_SCENE2:AddFragment(TITLE_FRAGMENT)

	-- Set Title
	ZO_CreateStringId("SI_ESOA_AUTOMSG_TITLE2", ElderScrollsOfAlts.name)
	ESOA_AUTOMSG_TITLE_FRAGMENT2 = ZO_SetTitleFragment:New(SI_ESOA_AUTOMSG_TITLE2)
	ESOA_AUTOMSG_SCENE2:AddFragment(ESOA_AUTOMSG_TITLE_FRAGMENT2)

	-- Add the XML to our scene
	ESOA_AUTOMSG_SCENE_WINDOW2 = ZO_FadeSceneFragment:New(ESOA_GUI_PAGE2)
	ESOA_AUTOMSG_SCENE2:AddFragment(ESOA_AUTOMSG_SCENE_WINDOW2)

	-- Register Scenes and the group name
	SCENE_MANAGER:AddSceneGroup("elderScrollsOfAltsSceneGroup", ZO_SceneGroup:New("elderScrollsOfAltsAutomatedMessagesScene","elderScrollsOfAltsAutomatedMessagesScene2") )
--
	-- Set Title
	ZO_CreateStringId("SI_ESOA_MAIN_MENU_TITLE", ElderScrollsOfAlts.menuName) --Harvest.GetLocalization("menu"))

	-- button data for the main menu (top bar with inventory, map, journal etc)
	ESOA_MAIN_MENU_CATEGORY_DATA =
	{
		binding = "ESOA_SHOW_PANEL",
		categoryName = SI_ESOA_MAIN_MENU_TITLE,
		descriptor = 19,--"ElderScrollsOfAltsSceneGroup",
		normal = "EsoUI/Art/Inventory/inventory_tabicon_quest_up.dds",
		pressed = "EsoUI/Art/Inventory/inventory_tabicon_quest_down.dds",
		highlight = "EsoUI/Art/Inventory/inventory_tabicon_quest_over.dds",
		callback = function()
			local viaButton = true
			self:Show(viaButton) -- the top bar button was pressed (i.e. not the keybind), show the scene
		end,
	}

	ElderScrollsOfAlts.MENU_CATEGORY_ESOA = LMM:AddCategory(ESOA_MAIN_MENU_CATEGORY_DATA)

	ZO_CreateStringId("SI_BINDING_NAME_ESOA_SHOW_AUTO_MSG", "Characters") --Harvest.GetLocalization("menu"))
	ZO_CreateStringId("SI_BINDING_NAME_ESOA_SHOW_AUTO_MSG2", "Page 2") --Harvest.GetLocalization("menu"))

	local iconData = {
		{
		categoryName = SI_BINDING_NAME_ESOA_SHOW_AUTO_MSG,
		descriptor = "elderScrollsOfAltsAutomatedMessagesScene",
		normal = "EsoUI/Art/MainMenu/menuBar_champion_up.dds",
		pressed = "EsoUI/Art/MainMenu/menuBar_champion_down.dds",
		highlight = "EsoUI/Art/MainMenu/menuBar_champion_over.dds",
		},
		{
		categoryName = SI_BINDING_NAME_ESOA_SHOW_AUTO_MSG2,
		descriptor = "elderScrollsOfAltsAutomatedMessagesScene2",
		normal = "EsoUI/Art/MainMenu/menuBar_champion_up.dds",
		pressed = "EsoUI/Art/MainMenu/menuBar_champion_down.dds",
		highlight = "EsoUI/Art/MainMenu/menuBar_champion_over.dds",
		},
	}

	-- Register the group and add the buttons (we cannot all AddRawScene, only AddSceneGroup,
	--	so we emulate both functions).
	LMM:AddSceneGroup(ElderScrollsOfAlts.MENU_CATEGORY_ESOA, "elderScrollsOfAltsSceneGroup", iconData)

end
