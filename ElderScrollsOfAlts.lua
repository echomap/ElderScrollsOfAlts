ElderScrollsOfAlts = {
    name            = "ElderScrollsOfAlts",	-- Matches folder and Manifest file names.
    displayName     = "Elder Scrolls of Alts",
    version         = "1.00.18",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.
    menuName        = "ElderScrollsOfAlts_Options", -- Unique identifier for menu object.
    SV_VERSION_NAME = 1,
    --HOME_FONT_BASE  = "ZoFontWinT2",
    --HOME_FONT_SEL   = "ZoFontGameLargeBold",
    defaultMaxViewButtons = 5,
    defaultMaxLines = 12,
    defaultFieldWidthForName = 180,
    defaultFieldHeight  = 30,
    defaultFieldYOffset = -10,-- -10 
    defaultView     = GetString(ESOA_VIEW_HOME),
    defaultSearch   = "Name",
    CATEGORY_ALL    = "All",
    BITE_WERE_ABILITY  = GetString(ESOA_BITE_WERE_ABILITY),
    BITE_WERE_COOLDOWN = GetString(ESOA_BITE_WERE_COOLDOWN),
    BITE_VAMP_ABILITY  = GetString(ESOA_BITE_VAMP_ABILITY),
    BITE_VAMP_COOLDOWN = GetString(ESOA_BITE_VAMP_COOLDOWN),
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
  currentView      = GetString(ESOA_VIEW_HOME),
  currentsort      = { },
  fieldWidthForName = 180,
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
    ElderScrollsOfAlts.outputMsg("/esoa <commands> where command can be, gui, help, debug, resetviews, showentries")
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
    --ElderScrollsOfAlts.LoadSettings()
  elseif options[1] == "savebuttondata" then --debug
    ElderScrollsOfAlts:ButtonFrameOnMoveStop()
  elseif options[1] == "testdata" then--debug
    ElderScrollsOfAlts:LoadTestData1()
  elseif options[1] == "deltestdata" then--debug
    ElderScrollsOfAlts:DelTestData1()     
  elseif options[1] == "resetviews" then
    ElderScrollsOfAlts:ResetUIViews()     
  elseif options[1] == "showentries" then
    ElderScrollsOfAlts:ListAllAllowedViewEntries()   
  elseif options[1] == "forcesavedata" then
    ElderScrollsOfAlts.SavePlayerDataForGui()
  elseif options[1] == "forceloaddata" then
    ElderScrollsOfAlts:LoadPlayerDataForGui()
  else
    ElderScrollsOfAlts.outputMsg("/esoa <commands> where command can be, gui, help, debug, beta, resetviews, showentries, forcesavedata, forceloaddata")
    ElderScrollsOfAlts.outputMsg("showentries: prints allowable view entries. resetviews: sets the views back to default. ")
	end
end

function ElderScrollsOfAlts.ShowHelp()

end

-- EVENT
function ElderScrollsOfAlts.OnChampionPerksStateChange(oldState,newState)
    if newState == SCENE_SHOWING then
      ElderScrollsOfAlts.HideAll()--ESOA_ButtonFrame
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
    -- LMM Settings menu in Settings.lua.
    ElderScrollsOfAlts.LoadSettings()    
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
-- Player can be unloaded on zone change, reload, etc, but not called on QUIT/Crash
function ElderScrollsOfAlts.OnPlayerUnloaded(event)
  --ElderScrollsOfAlts.debugMsg("OnPlayerUnloaded:", " called")
  --zo_callLater(ElderScrollsOfAlts.SavePlayerDataForGui, 3000)-- DATA
  ElderScrollsOfAlts.SavePlayerDataForGui()
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

  --check/setup a bit earlier
  ElderScrollsOfAlts.CheckData()
  ElderScrollsOfAlts.SetupDefaultColors()
  zo_callLater(ElderScrollsOfAlts.DelayedStart, 3000)

  -- Slash commands must be lowercase. Set to nil to disable.
  SLASH_COMMANDS["/elderScrollsOfAlts"] = ElderScrollsOfAlts.SlashCommandHandler
  SLASH_COMMANDS["/esoa"] = ElderScrollsOfAlts.SlashCommandHandler
  -- Reset autocomplete cache to update it.
  --dunno, 'SLASH_COMMAND_AUTO_COMPLETE' doesnt work anymore?
  --SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
  --debugMsg(ElderScrollsOfAlts.name .. GetString(SI_NEW_ADDON_MESSAGE2)) -- Prints to chat.
end


-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED, ElderScrollsOfAlts.OnAddOnLoaded)
--
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_DEACTIVATED, ElderScrollsOfAlts.OnPlayerUnloaded)
-- When player is ready, after everything has been loaded. (after addon loaded)
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED, ElderScrollsOfAlts.OnPlayerLoaded)
