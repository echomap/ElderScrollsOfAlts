ElderScrollsOfAlts = {
    name            = "ElderScrollsOfAlts",	-- Matches folder and Manifest file names.
    displayName     = "Elder Scrolls of Alts",
    version         = "0.1.15",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.
    menuName        = "ElderScrollsOfAlts_Options", -- Unique identifier for menu object.
    view            = {},
    -- Saved Settings
    savedVariables  = {},
    altData         = {},
}

--ZO_SORT_ORDER_UP, --ZO_SORT_ORDER_DOWN
local defaultSettings = {   
  sversion   = ElderScrollsOfAlts.version,
  uimode     = "Show2",
  currentSortKey   = "name",
  currentSortOrder = true,
  currentView      = "Home",
  window     = {
      ["minimized"] = false,
      ["shown"]   = false,
      ["top"]     = 100,
      ["left"]    = 100,
      ["width"]   = 830,
      ["height"]  = 325,
  },
  uibutton    = {
    ["shown"] = true,
    ["top"] = 200,
    ["left"] = 200,
  },
  selected = {
    ["charactername"] = nil,
  },
}

local defaultSettingsGlobal = {
  debug      = false,
  beta       = false,
}

--
function ElderScrollsOfAlts.SetUIMode(self,var)
  ElderScrollsOfAlts.debugMsg("SetUIMode: var="..var)
  ElderScrollsOfAlts.savedVariables.uimode = var
end

--
function ElderScrollsOfAlts.initData(self)
  --ElderScrollsOfAlts:loadSavedVariables()
  ElderScrollsOfAlts:InitializeCharts()
  ElderScrollsOfAlts:RestoreUI()
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
    ElderScrollsOfAlts.ShowGuiByChoice()
	elseif options[1] == "help" then
		-- TODO Display help  
	elseif options[1] == "debug" then
		local dg = ElderScrollsOfAlts.altData.debug
		ElderScrollsOfAlts.altData.debug = not dg
		d("ElderScrollsOfAlts: Debug = " .. tostring(ElderScrollsOfAlts.altData.debug) )
		ElderScrollsOfAlts.savedVariables.debug = ElderScrollsOfAlts.altData.debug
	elseif options[1] == "beta" then
		local dg = ElderScrollsOfAlts.altData.beta
		ElderScrollsOfAlts.altData.beta = not dg
		d("ElderScrollsOfAlts: Beta = " .. tostring(ElderScrollsOfAlts.altData.beta) )
		--ElderScrollsOfAlts.savedVariables.beta = ElderScrollsOfAlts.altData.beta
  elseif options[1] == "testdata" then
    ElderScrollsOfAlts:LoadTestData1()
  elseif options[1] == "deltestdata" then
    ElderScrollsOfAlts:DelTestData1()    
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

function ElderScrollsOfAlts.OnChampionPerksSceneStateChange(oldState,newState)
    if newState == SCENE_SHOWING then
      ElderScrollsOfAlts.HideAll()--ESOA_ButtonFrame
      ESOA_ButtonFrame:SetHidden(true)
    elseif newState == SCENE_HIDDEN then
      --TODO check user wants to re-show
      --if CS.Account.option[1] then CraftStoreFixed_ButtonFrame:SetHidden(false) end
      ElderScrollsOfAlts.ShowUIButton()--ESOA_ButtonFrame
      ElderScrollsOfAlts.RestoreGui2()--ESOA_ButtonFrame
    end
end

function ElderScrollsOfAlts.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED)

    ElderScrollsOfAlts:debugMsg(ElderScrollsOfAlts.name .. GetString(SI_ESOA_MESSAGE)) 
    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
        ElderScrollsOfAlts.name .. GetString(SI_ESOA_MESSAGE)) -- Top-right alert.

    ElderScrollsOfAlts.initData()

    CHAMPION_PERKS_SCENE:RegisterCallback('StateChange',ElderScrollsOfAlts.OnChampionPerksSceneStateChange)
end

-- When player is ready, after everything has been loaded. (after addon loaded)
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_ACTIVATED, ElderScrollsOfAlts.Activated)

--TODO When is this called? NOT On quit!!
function ElderScrollsOfAlts.OnAddOnUnloaded(event)
  ElderScrollsOfAlts.debugMsg("OnAddOnUnloaded called") -- Prints to chat.  
  ElderScrollsOfAlts.loadPlayerData()
  --ElderScrollsOfAlts.SaveSettings()
  ElderScrollsOfAlts.debugMsg("OnAddOnUnloaded done") -- Prints to chat.
end

function ElderScrollsOfAlts.OnAddOnLoaded(event, addonName)
    if addonName ~= ElderScrollsOfAlts.name then return end
    EVENT_MANAGER:UnregisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED)
    CHAMPION_PERKS_SCENE:UnregisterCallback('StateChange',ElderScrollsOfAlts.OnChampionPerksSceneStateChange)

    ElderScrollsOfAlts.savedVariables = ZO_SavedVars:New("ElderScrollsOfAltsSavedVariables", 1, nil, defaultSettings)
    ElderScrollsOfAlts.altData = ZO_SavedVars:NewAccountWide("ESOA_AltData", 1, nil, defaultSettingsGlobal)
    
    --ESOA_AltData
    --local db = ZO_SavedVars:NewAccountWide("altsdata", SV_VERSION_NAME, nil, defaults)

    -- Settings menu in Settings.lua.
    ElderScrollsOfAlts.LoadSettings()    
    --ElderScrollsOfAlts:SetupGUI()

    -- Slash commands must be lowercase. Set to nil to disable.
    SLASH_COMMANDS["/elderScrollsOfAlts"] = ElderScrollsOfAlts.SlashCommandHandler
    SLASH_COMMANDS["/esoa"] = ElderScrollsOfAlts.SlashCommandHandler
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
    --d(ElderScrollsOfAlts.name .. GetString(SI_NEW_ADDON_MESSAGE2)) -- Prints to chat.
end

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_ADD_ON_LOADED, ElderScrollsOfAlts.OnAddOnLoaded)
--
EVENT_MANAGER:RegisterForEvent(ElderScrollsOfAlts.name, EVENT_PLAYER_DEACTIVATED, ElderScrollsOfAlts.OnAddOnUnloaded)
