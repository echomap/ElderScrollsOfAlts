----------------------------------------
--[[ ESOA ]]-- 
----------------------------------------
-- INTERNAL Implementation API
-- Data Legacy 
-- Load/Save Data from ESOA saved variables (not Datastore)
----------------------------------------


------------------------------
-- MAIN call that calls other functions ot populate PLAYER Data
-- When not fully converted to Datastore!
function ElderScrollsOfAlts:SetupGuiPlayerLinesDSpre()
	--
	local accountname = GetDisplayName()
	--
	ElderScrollsOfAlts.view.accountData = {}
	ElderScrollsOfAlts.view.accountData.secondsplayed = 0
	--TODO bankspaces
	--
	local playerLines =  {}
	--table.insert(playerLines, "Select")
	local pCount = 0
	--
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
		if k == nil then return end
		ElderScrollsOfAlts.outputMsg("SetupLinePre: player: '" , k , "'")
		pCount = pCount+1
		--
		local chardata = ESOADatastore.getCharacterByID(k)
		--chardata = nil -- TESTING TODO
		if(chardata~=nil) then
			playerLines[k] = {}
			ElderScrollsOfAlts:SetupGuiPlayerBaseLines(playerLines,k)	-- contains only defaults
			--ElderScrollsOfAlts:SetupGuiPlayerBaseLines2(playerLines,k)	--contains local stuff
			--ElderScrollsOfAlts:SetupGuiPlayerBaseLinesDS2(playerLines,k)	--TODO since contains local stuff
			--
			-- Flatten chardata for ESOA
			local chardataF = ElderScrollsOfAlts:SetupGuiPlayerLinesDSFlatten(chardata)
			if(chardataF~=nil) then
				ElderScrollsOfAlts.outputMsg("SetupLinePre: flattened: name='" , chardataF.name , "' lvl='" , chardataF.level, "'")
				playerLines[k] = chardataF
			else 
				ElderScrollsOfAlts.outputMsg("SetupLinePre: flattened: FAILED")
			end
		else
			table.insert(ElderScrollsOfAlts.view.playerLinesMissing, k )
		end
		-- CHECK Data
		--
	end --for k, v in pairs(ElderScrollsOfAlts.altData.players) do
	-- PlayerLines to table
	table.sort(playerLines)  
	ElderScrollsOfAlts.view.maxPlayerLineCount = pCount
	return playerLines
end

------------------------------
-- MAIN call that calls other functions ot populate PLAYER Data
function ElderScrollsOfAlts:SetupGuiPlayerLines()
	ElderScrollsOfAlts.debugMsg("SetupGuiPlayerLines: Called Legacy")
	--local timeTotalStart = GetFrameTimeSeconds()
	--ElderScrollsOfAlts.debugMsg("timeTotalStart: " .. tostring(timeTotalStart) )
	--
	ElderScrollsOfAlts.view.accountData = {}
	ElderScrollsOfAlts.view.accountData.secondsplayed = 0
	--TODO bankspaces
	--
	local playerLines =  {}
	--table.insert(playerLines, "Select")
	local pCount = 0
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
		if k == nil then return end
		ElderScrollsOfAlts.debugMsg(" players " .. k)
		ElderScrollsOfAlts:SetupGuiPlayerLinesForK(playerLines,k)
		--
		pCount = pCount+1
	end--for k, v in pairs(ElderScrollsOfAlts.altData.players) do
	--
	-- PlayerLines to table
	table.sort(playerLines)  
	ElderScrollsOfAlts.view.maxPlayerLineCount = pCount
	--local timeTotalEnd = GetFrameTimeSeconds()
	--local timeTotalDiff = GetDiffBetweenTimeStamps(timeTotalStart, timeTotalEnd)
	--ElderScrollsOfAlts.debugMsg("timeTotalStart: " .. tostring(timeTotalStart) .. " timeTotalEnd:" .. tostring(timeTotalEnd) )
	--ElderScrollsOfAlts.debugMsg("ESOA.SAVE timeTotalDiff=".. tostring(timeTotalDiff) )
	return playerLines
end

------------------------------
-- Companions
function ElderScrollsOfAlts:CollectCompanionDataInitLegacy(playerKey, companionId, cname)
  if ElderScrollsOfAlts.altData.players == nil then
		ElderScrollsOfAlts.altData.players = {}
	end
  if( ElderScrollsOfAlts.altData.players[playerKey] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey] = {}
  end
  ElderScrollsOfAlts.debugMsg("companion save data: companionId: '", companionId, "' as '", cname, "'" )
  ----Section: Save section
  if( ElderScrollsOfAlts.altData.players[playerKey].companions == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].companions = {}
    ElderScrollsOfAlts.altData.players[playerKey].companions.ids  = {}
    ElderScrollsOfAlts.altData.players[playerKey].companions.data = {}
  end
  if( ElderScrollsOfAlts.altData.players[playerKey].companions.ids[companionId] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].companions.ids[companionId] = companionId
  end
  if( ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId] = {}
  end
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].id      = companionId
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].name    = zo_strformat("<<X:1>>", cname )
  
  ElderScrollsOfAlts.debugMsg("companion save data: companionId: '", companionId, "' fixed as '", zo_strformat("<<X:1>>", cname ), "'" )
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataLevelLegacy(companionId, cname, level, currentExperience, experienceForLevel)
  ElderScrollsOfAlts.debugMsg("CollectCompanionDataLevel: called")
  ----Section: Statup section
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  --
  ElderScrollsOfAlts:CollectCompanionDataInitLegacy(playerKey, companionId, cname)
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].level             = level
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].currentExperience = currentExperience
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].experienceForLevel = experienceForLevel
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataSkillRankLegacy(companionId, cname, skillLineId, slName, rank )
  ElderScrollsOfAlts.debugMsg("CollectCompanionDataSkillRank: called")
  ----Section: Statup section
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  --
  ElderScrollsOfAlts:CollectCompanionDataInitLegacy(playerKey, companionId, cname)
  ElderScrollsOfAlts:CollectCompanionDataSkillLine(companionId, cname, skillLineId, slName )
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline[skillLineId].rank = rank
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataSkillLineLegacy(companionId, cname, skillLineId, slName )
  ElderScrollsOfAlts.debugMsg("CollectCompanionDataSkillLine: called")
  ----Section: Statup section
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  --
  ElderScrollsOfAlts:CollectCompanionDataInitLegacy(playerKey, companionId, cname)
  if( ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline == nil) then
    ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline = {}
  end
  if( ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline[skillLineId] == nil ) then
      ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline[skillLineId] = {}
  end
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline[skillLineId].id   = skillLineId
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].skillline[skillLineId].name = slName
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataRapportLegacy(companionId, cname, currentRapport)
  ElderScrollsOfAlts.debugMsg("CollectCompanionDataRapport: called")
  ----Section: Statup section
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  --
  ElderScrollsOfAlts:CollectCompanionDataInitLegacy(playerKey, companionId, cname)
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].id      = companionId
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].name    = cname
  ElderScrollsOfAlts.altData.players[playerKey].companions.data[companionId].rapport = currentRapport
end


------------------------------
-- 
function ElderScrollsOfAlts.SavePlayerDataLegacy( playerLineKey, keyName, elementData )	
	if( ElderScrollsOfAlts.altData.players[playerLineKey] ~= nil ) then
		ElderScrollsOfAlts.altData.players[playerLineKey][keyName] = elementData
		ElderScrollsOfAlts.debugMsg("SavePlayerData: player=",playerLineKey," keyName=",keyName," as ", elementData) 
	end
end

------------------------------
-- 

----------------------------------------
 --[[ ESOA Data Legacy ]]-- 
----------------------------------------