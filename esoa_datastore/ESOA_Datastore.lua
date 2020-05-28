--[[ ESOA Datastore ]]-- 

------------------------------
-- 
EchoESOADatastore = {
    name            = "ESOA_Datastore",           -- Matches folder and Manifest file names.
    version         = "0.0.1",                    -- A nuisance to match to the Manifest.
    author          = "Echomap",
    --menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    --menuDisplayName = "EchoExperience",
    version = 1,
    SV_VERSION_NAME = 1,
    -- In Memory Settings
    view            = {
      fError    = false,
      fErrorMsg = nil,
    },
    --
    -- Saved settings.
    svESOADataAW  = {},
    svCharDataAW  = {},
    svEquipDataAW = {},
    
    -- Default settings.    
    defaultSettings1 = {
    },
    defaultSettingsGlobal = {
      debug      = false,
      beta       = false,
      savePlayerData = true,
      saveEquipData  = true,
    },
}

------------------------------
-- API
------------------------------
------------------------------

------------------------------
-- UTIL
function EchoESOADatastore.debugMsg(...)
  ElderScrollsOfAlts.debugMsg(...)
end

------------------------------
-- UTIL
function EchoESOADatastore.outputMsg(text)
  d("(" .. EchoESOADatastore.name .. ") " .. text )
end

------------------------------
-- UTIL
function EchoESOADatastore.errorMsg(text)
  d("(" .. EchoESOADatastore.name .. ") " .. text )
end

------------------------------
-- SETUP  setup event handling
function EchoESOADatastore.DelayedStart()
    --EchoESOADatastore.SetupDefaultColors()
    --EchoESOADatastore:InitializeCharts()
    ESOADatastoreLogic.saveCurrentPlayerData() -- DATA
    --EchoESOADatastore.InitializeGui()
    --EchoESOADatastore:RestoreUI()
    -- LMM Settings menu in Settings.lua.
    --EchoESOADatastore.LoadSettings()    
    --fix
    --EchoESOADatastore.savedVariables.selected.character = nil
    
    --CHAMPION_PERKS_SCENE:RegisterCallback('StateChange',EchoESOADatastore.OnChampionPerksStateChange)
    --EchoESOADatastore.debugMsg(EchoESOADatastore.name , GetString(SI_ESOA_MESSAGE)) 
    --ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
    --    EchoESOADatastore.name .. GetString(SI_ESOA_MESSAGE)) -- Top-right alert.
end

------------------------------
-- EVENT
function EchoESOADatastore.OnPlayerLoaded(e)
  EVENT_MANAGER:UnregisterForEvent(EchoESOADatastore.name, EVENT_PLAYER_ACTIVATED)
end

------------------------------
-- EVENT
-- Player can be unloaded on zone change, reload, etc, but not called on QUIT/Crash
function EchoESOADatastore.OnPlayerUnloaded(event)
  ESOADatastoreLogic.saveCurrentPlayerData()
end

------------------------------
-- EVENT
function EchoESOADatastore.OnAddOnLoaded(event, addonName)
  --d("addonName="..addonName)
  if addonName ~= EchoESOADatastore.name then return end
  EVENT_MANAGER:UnregisterForEvent(EchoESOADatastore.name, EVENT_ADD_ON_LOADED)
  
  --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
   EchoESOADatastore.svESOADataAW = ZO_SavedVars:NewAccountWide("ESOA_Datastore", EchoESOADatastore.SV_VERSION_NAME, "AccountData", EchoESOADatastore.defaultSettingsGlobal)
  EchoESOADatastore.svCharDataAW = ZO_SavedVars:NewAccountWide("ESOA_DatastoreBio", EchoESOADatastore.SV_VERSION_NAME, "CharData", EchoESOADatastore.defaultSettings)
  EchoESOADatastore.svEquipDataAW = ZO_SavedVars:NewAccountWide("ESOA_DatastoreEq", EchoESOADatastore.SV_VERSION_NAME, "EquipData", EchoESOADatastore.defaultSettings)

  --check/setup a bit earlier
  --EchoESOADatastore.CheckData()
  --EchoESOADatastore.SetupDefaultColors()
  zo_callLater(EchoESOADatastore.DelayedStart, 3000)

  -- Slash commands must be lowercase. Set to nil to disable.
  SLASH_COMMANDS["/esoadata"]      = EchoESOADatastore.SlashCommandHandler
  SLASH_COMMANDS["/esoadatastore"] = EchoESOADatastore.SlashCommandHandler
  --d("ESOA Datastore loaded")
end

------------------------------
-- Commands, help/debug/beta/testdata/deltestdata
function EchoESOADatastore.SlashCommandHandler(text)
	EchoESOADatastore.debugMsg("SlashCommandHandler: " , text)
	local options = {}
	local searchResult = { string.match(text,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
		    options[i] = string.lower(v)
		end
	end

	if #options == 0 then
    EchoESOADatastore.ShowHelp()
  elseif (options[1] == "note" and #options == 2) then
    local playerName = options[2]
    EchoESOADatastore.GetPlayerNote(playerName)
  elseif options[1] == "help" then
    EchoESOADatastore.ShowHelp()
  else
      EchoESOADatastore.ShowHelp()
	end
end

------------------------------
-- User command
function EchoESOADatastore.ShowHelp()
    EchoESOADatastore.outputMsg("/esoadata <commands> where command can be, note")
end

------------------------------
-- Register for starting/startup events

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoESOADatastore.name, EVENT_ADD_ON_LOADED, EchoESOADatastore.OnAddOnLoaded)
-- Add on player loaded
EVENT_MANAGER:RegisterForEvent(EchoESOADatastore.name, EVENT_PLAYER_DEACTIVATED, EchoESOADatastore.OnPlayerUnloaded)
-- When player is ready, after everything has been loaded. (after addon loaded)
EVENT_MANAGER:RegisterForEvent(EchoESOADatastore.name, EVENT_PLAYER_ACTIVATED, EchoESOADatastore.OnPlayerLoaded)
--EOF