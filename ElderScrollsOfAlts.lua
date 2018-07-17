ElderScrollsOfAlts = {
    name            = "ElderScrollsOfAlts",	-- Matches folder and Manifest file names.
    displayName     = "Elder Scrolls of Alts",
    -- version         = "1.0",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.
    menuName        = "ElderScrollsOfAlts_Options", -- Unique identifier for menu object.
    debug           = false,
    savedVariables = {},
    altData        = {},
}

function ElderScrollsOfAlts.loadSavedVariables(self)
    if ElderScrollsOfAlts.savedVariables.debug ~= niil then
        ElderScrollsOfAlts.debug = ElderScrollsOfAlts.savedVariables.debug
    end
end
function ElderScrollsOfAlts.initData(self)
	ElderScrollsOfAlts.SetupLMM()	
  ElderScrollsOfAlts.loadPlayerData()
end

function ElderScrollsOfAlts.SlashCommandHandler(text)
	ElderScrollsOfAlts.debugMsg("SlashCommandHandler: " .. text)
	local options = {}
	local searchResult = { string.match(text,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
		    options[i] = string.lower(v)
		end
	end

	if #options == 0 then
    ElderScrollsOfAlts.ToggleShowing()
	elseif #options == 0 or options[1] == "show2" then
    ElderScrollsOfAlts.ShowGui2()
	elseif #options == 0 or options[1] == "help" then
		-- Display help  
	elseif #options == 0 or options[1] == "debug" then
		local dg = ElderScrollsOfAlts.debug
		ElderScrollsOfAlts.debug = not dg
		d("ElderScrollsOfAlts: Debug = " .. tostring(ElderScrollsOfAlts.debug) )
		ElderScrollsOfAlts.savedVariables.debug = ElderScrollsOfAlts.debug
  elseif #options == 0 or options[1] == "testdata" then
    ElderScrollsOfAlts:LoadTestData1()
	elseif (#options == 0 or options[1] == "tab") and options[2] ~= nil then
		ElderScrollsOfAlts:debugMsg("ElderScrollsOfAlts: tab = " .. tostring(options[2]) )
		ElderScrollsOfAlts.tab = tonumber(options[2])
		ElderScrollsOfAlts.savedVariables.tab = ElderScrollsOfAlts.tab
	elseif (#options == 0 or options[1] == "window") and options[2] ~= nil then
		ElderScrollsOfAlts:debugMsg("ElderScrollsOfAlts: window = " .. tostring(options[2]) )
		ElderScrollsOfAlts.window = tonumber(options[2])
		ElderScrollsOfAlts.savedVariables.window = ElderScrollsOfAlts.window
	end
end

function ElderScrollsOfAlts.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED)

    ElderScrollsOfAlts:debugMsg(ElderScrollsOfAlts.name .. GetString(SI_NEW_ADDON_MESSAGE)) 
    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
        ElderScrollsOfAlts.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.

    -- Animate the xml UI center text, after a delay.
    --zo_callLater(ElderScrollsOfAlts.AnimateText, 3000)
    ElderScrollsOfAlts:loadSavedVariables()
    ElderScrollsOfAlts.initData()
    ElderScrollsOfAlts:SetupGUI()
    --zo_callLater(ElderScrollsOfAlts.TryShowMainWindow, 3000)
    --zo_callLater(ElderScrollsOfAlts.TryShowMainWindow, 3000)
end

-- When player is ready, after everything has been loaded. (after addon loaded)
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED, ElderScrollsOfAlts.Activated)

function ElderScrollsOfAlts.OnAddOnUnloaded(event)
  ElderScrollsOfAlts.debugMsg("OnAddOnUnloaded called") -- Prints to chat.
  ElderScrollsOfAlts.loadPlayerData()
  ElderScrollsOfAlts.debugMsg("OnAddOnUnloaded done") -- Prints to chat.
end

function ElderScrollsOfAlts.OnAddOnLoaded(event, addonName)
    if addonName ~= ElderScrollsOfAlts.name then return end
    EVENT_MANAGER:UnregisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED)

    ElderScrollsOfAlts.savedVariables = ZO_SavedVars:New("ElderScrollsOfAltsSavedVariables", 1, nil, ElderScrollsOfAlts.savedVariables)

    local defaults = {
      pName      = pName,
      fillAmt    = 0,
    }
    ElderScrollsOfAlts.altData = ZO_SavedVars:NewAccountWide("ESOA_AltData", 1, nil, defaults)
    --ESOA_AltData
    --local db = ZO_SavedVars:NewAccountWide("altsdata", SV_VERSION_NAME, nil, defaults)

    -- Settings menu in Settings.lua.
    ElderScrollsOfAlts.LoadSettings()
    --ElderScrollsOfAlts:RestorePosition()
    --ElderScrollsOfAlts:SetupGUI()

    -- Slash commands must be lowercase. Set to nil to disable.
    SLASH_COMMANDS["/elderScrollsOfAlts"] = ElderScrollsOfAlts.SlashCommandHandler
    SLASH_COMMANDS["/esoa"] = ElderScrollsOfAlts.SlashCommandHandler
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
    d(ElderScrollsOfAlts.name .. GetString(SI_NEW_ADDON_MESSAGE2)) -- Prints to chat.
end

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED, ElderScrollsOfAlts.OnAddOnLoaded)

EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_DEACTIVATED, ElderScrollsOfAlts.OnAddOnUnloaded)
