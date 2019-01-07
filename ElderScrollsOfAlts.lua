ElderScrollsOfAlts = {
    name            = "ElderScrollsOfAlts",	-- Matches folder and Manifest file names.
    displayName     = "Elder Scrolls of Alts",
    version         = "1.00.06",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.
    menuName        = "ElderScrollsOfAlts_Options", -- Unique identifier for menu object.
    SV_VERSION_NAME = 1,
    HOME_FONT_BASE  = "ZoFontWinT2",
    HOME_FONT_SEL   = "ZoFontGameLargeBold",
    defaultMaxViewButtons = 5,
    defaultMaxLines = 12,
    defaultView     = "Home",
    defaultSearch   = "Name",
    CATEGORY_ALL    = "All",
    BITE_WERE_ABILITY = "Bite an Ally",
    BITE_VAMP_ABILITY = "Feed on Ally",
    rgbaWhite   = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
    },
    view            = {},
    -- Saved Settings
    savedVariables  = {},
    altData         = {},
}

--ZO_SORT_ORDER_UP, --ZO_SORT_ORDER_DOWN
local defaultSettings = {   
  sversion   = ElderScrollsOfAlts.version,
  --currentSortKey   = "name",
  --currentSortOrder =  true,
  currentView      = "Home",
  currentsort      = { },
  window     = {
      ["minimized"] = false,
      ["shown"]     = false,
      ["top"]       = 100,
      ["left"]      = 100,
      ["width"]     = 830,
      ["height"]    = 325,
  },
  uibutton    = {
    ["shown"] = true,
    ["top"]   = 200,
    ["left"]  = 200,
  },
  selected = {
    --["charactername"] = nil,
  },
}

local defaultSettingsGlobal = {
  debug      = false,
  beta       = false,
}

--Commands, help/debug/beta/testdata/deltestdata
function ElderScrollsOfAlts.SlashCommandHandler(text)
	ElderScrollsOfAlts.debugMsg("SlashCommandHandler: " , text)
	local options = {}
	local searchResult = { string.match(text,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
		    options[i] = string.lower(v)
		end
	end

	if #options == 0 then
    ElderScrollsOfAlts.outputMsg("/esoa <commands> where command can be, gui, help, debug, beta, resetviews")
  elseif options[1] == "gui" then
    ElderScrollsOfAlts.ShowGuiByChoice()
  elseif options[1] == "help" then
    ElderScrollsOfAlts.ShowHelp()
	elseif options[1] == "debug" then
		local dg = ElderScrollsOfAlts.altData.debug
		ElderScrollsOfAlts.altData.debug = not dg
		ElderScrollsOfAlts.outputMsg("ElderScrollsOfAlts: Debug = " .. tostring(ElderScrollsOfAlts.altData.debug) )
		ElderScrollsOfAlts.savedVariables.debug = ElderScrollsOfAlts.altData.debug
	elseif options[1] == "beta" then
		local dg = ElderScrollsOfAlts.altData.beta
		ElderScrollsOfAlts.altData.beta = not dg
		ElderScrollsOfAlts.outputMsg("ElderScrollsOfAlts: Beta = " .. tostring(ElderScrollsOfAlts.altData.beta) )
		--ElderScrollsOfAlts.savedVariables.beta = ElderScrollsOfAlts.altData.beta
  elseif options[1] == "testdata" then
    ElderScrollsOfAlts:LoadTestData1()
  elseif options[1] == "deltestdata" then
    ElderScrollsOfAlts:DelTestData1()     
  elseif options[1] == "resetviews" then
    ElderScrollsOfAlts:ResetUIViews()     
	end
end

function ElderScrollsOfAlts.ShowHelp()

end

-- EVENT
function ElderScrollsOfAlts.OnChampionPerksStateChange(oldState,newState)
    if newState == SCENE_SHOWING then
      ElderScrollsOfAlts.HideAll()--ESOA_ButtonFrame
      --TODO ESOA_ButtonFrame:SetHidden(true)
    elseif newState == SCENE_HIDDEN then
      ElderScrollsOfAlts.ShowUIButton()--ESOA_ButtonFrame
    end
end


-- SETUP  setup event handling
function ElderScrollsOfAlts.DelayedStart()
    ElderScrollsOfAlts.SetupDefaultColors()
    --ElderScrollsOfAlts:InitializeCharts()
    ElderScrollsOfAlts.SavePlayerDataForGui() -- DATA
    ElderScrollsOfAlts.InitializeGui()
    ElderScrollsOfAlts:RestoreUI()
    --fix
    ElderScrollsOfAlts.savedVariables.selected.character = nil
    
    CHAMPION_PERKS_SCENE:RegisterCallback('StateChange',ElderScrollsOfAlts.OnChampionPerksStateChange)
    ElderScrollsOfAlts.debugMsg(ElderScrollsOfAlts.name , GetString(SI_ESOA_MESSAGE)) 
    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
        ElderScrollsOfAlts.name .. GetString(SI_ESOA_MESSAGE)) -- Top-right alert.
end


-- EVENT
function ElderScrollsOfAlts.OnPlayerLoaded(e)
  --ElderScrollsOfAlts.debugMsg("OnPlayerLoaded:", " called") 
  --EVENT_MANAGER:UnregisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED)
  --ElderScrollsOfAlts.debugMsg("OnPlayerLoaded:", " done")
end

-- EVENT
-- Player can be unloaded on zone change, reload, etc, but ont called on QUIT/Crash
function ElderScrollsOfAlts.OnPlayerUnloaded(event)
  --ElderScrollsOfAlts.debugMsg("OnPlayerUnloaded:", " called")
  zo_callLater(ElderScrollsOfAlts.SavePlayerDataForGui, 3000)-- DATA
  --ElderScrollsOfAlts.debugMsg("OnPlayerUnloaded:", " done")
end

-- EVENT
function ElderScrollsOfAlts.OnAddOnLoaded(event, addonName)
    if addonName ~= ElderScrollsOfAlts.name then return end
    EVENT_MANAGER:UnregisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED)
    CHAMPION_PERKS_SCENE:UnregisterCallback('StateChange',ElderScrollsOfAlts.OnChampionPerksStateChange)
    --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
    ElderScrollsOfAlts.savedVariables = ZO_SavedVars:New("ElderScrollsOfAltsSavedVariables", ElderScrollsOfAlts.SV_VERSION_NAME, nil, defaultSettings)
    --(savedVariableTable, version, namespace, defaults, profile, displayName)
    ElderScrollsOfAlts.altData = ZO_SavedVars:NewAccountWide("ESOA_AltData", ElderScrollsOfAlts.SV_VERSION_NAME, nil, defaultSettingsGlobal)

    -- LMM Settings menu in Settings.lua.
    ElderScrollsOfAlts.LoadSettings()    
    zo_callLater(ElderScrollsOfAlts.DelayedStart, 3000)

    -- Slash commands must be lowercase. Set to nil to disable.
    SLASH_COMMANDS["/elderScrollsOfAlts"] = ElderScrollsOfAlts.SlashCommandHandler
    SLASH_COMMANDS["/esoa"] = ElderScrollsOfAlts.SlashCommandHandler
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
    --debugMsg(ElderScrollsOfAlts.name .. GetString(SI_NEW_ADDON_MESSAGE2)) -- Prints to chat.
end


-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED, ElderScrollsOfAlts.OnAddOnLoaded)
--
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_DEACTIVATED, ElderScrollsOfAlts.OnPlayerUnloaded)
-- When player is ready, after everything has been loaded. (after addon loaded)
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED, ElderScrollsOfAlts.OnPlayerLoaded)
