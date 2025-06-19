----------------------------------------
--[[ ESOA ]]-- 
----------------------------------------
-- INTERNAL Implementation API
----------------------------------------


------------------------------
--NEW BETA/ALPHA
function ElderScrollsOfAlts.DataSaveLivePlayerNew()
  if (EchoESOADatastore ~= nil) then
    EchoESOADatastore.saveCurrentPlayerData()
  else 
    ElderScrollsOfAlts:DataSaveLivePlayer()
  end
end

------------------------------
-- 
function ElderScrollsOfAlts:LoadPlayerDataForGui()
	if( ESOADatastore~=nil ) then
		ElderScrollsOfAlts.outputMsg("LoadPlayerDataForGui: Called DS")
		if(ElderScrollsOfAlts.altData.convertedToDataStore==nil) then
			-- Use Datastore and Legacy
			-- Check if chardata is in the Datastore
			ElderScrollsOfAlts.view.playerLinesMissing = {}
			ElderScrollsOfAlts.view.playerLines = ElderScrollsOfAlts:SetupGuiPlayerLinesDSpre()
			ElderScrollsOfAlts.outputMsg("Loaded from Datastore, cnt#=", #ElderScrollsOfAlts.view.playerLines )
			for k, v in pairs(ElderScrollsOfAlts.view.playerLinesMissing) do
				if k == nil then return end
				ElderScrollsOfAlts.outputMsg(" esoa load requested, for='",  k, "' v=", v)
				ElderScrollsOfAlts.view.playerLines[v] = {}
				ElderScrollsOfAlts:SetupGuiPlayerLinesForK(ElderScrollsOfAlts.view.playerLines,v)
			end
			--ElderScrollsOfAlts.view.playerLinesMissing = nil -- TODO reset missing data
			ElderScrollsOfAlts.outputMsg("Loaded from Both, cnt#=", #ElderScrollsOfAlts.view.playerLines )
		else
			-- Only Use Datastore
			ElderScrollsOfAlts.view.playerLines = ElderScrollsOfAlts:SetupGuiPlayerLinesDS()
		end
	else
		-- Only legacy
		ElderScrollsOfAlts.debugMsg("LoadPlayerDataForGui: Called Legacy")
		ElderScrollsOfAlts.view.playerLines = ElderScrollsOfAlts:SetupGuiPlayerLines()
		ElderScrollsOfAlts.view.needToLoadGuiData = false
		ElderScrollsOfAlts.debugMsg("LoadPlayerDataForGui:", " called") 
	end
end

------------------------------
-- 
function ElderScrollsOfAlts.GeneratePlayerKeyForCurrentCharacter()
	local pName     = GetUnitName("player")
	local rName     = GetRawUnitName("player")   
	local pID       = GetCurrentCharacterId()
	local pServer   = GetWorldName()
	local playerKey = pID.."_".. pServer:gsub(" ","_")
	ElderScrollsOfAlts.view.currentplayerkey = playerKey
	return playerKey
end

------------------------------
-- 
function ElderScrollsOfAlts.SavePlayerDataForGui(loadtype)
	ElderScrollsOfAlts.debugMsg("SavePlayerDataForGui: loadtype='"..tostring(loadtype).."'")
	ElderScrollsOfAlts.GeneratePlayerKeyForCurrentCharacter()
	--
	if(ESOADatastore~=nil and ElderScrollsOfAlts.altData.players==nil ) then
		ElderScrollsOfAlts.altData.convertedToDataStore = true
	end
	--
	ElderScrollsOfAlts.DataSaveLivePlayer(loadtype)
	--ALPHA ElderScrollsOfAlts.DataSaveLivePlayerNew()
	ElderScrollsOfAlts.view.needToLoadGuiData = true
	ElderScrollsOfAlts.debugMsg("SavePlayerDataForGui:", " called") 
	ElderScrollsOfAlts:ResetPlayerOrder()
end

------------------------------
-- 
--
function ElderScrollsOfAlts.SavePlayerData( playerLineKey, keyName, elementData )
	ElderScrollsOfAlts.outputMsg("SavePlayerData: playerKey=",playerLineKey," keyName=",keyName," as ", elementData) 
	if (ESOADatastore ~= nil) then
		ElderScrollsOfAlts.SavePlayerDataDS( playerLineKey, keyName, elementData )
	else 
		ElderScrollsOfAlts.SavePlayerDataLegacy( playerLineKey, keyName, elementData )
	end
end

------------------------------
-- 
--20250518 trying to use datastore instead of this addon SV for alt data
-- Read all data from the game Player Object into this Addon
function ElderScrollsOfAlts.DataSaveLivePlayer(loadtype)
	ElderScrollsOfAlts.debugMsg("DataSaveLivePlayer: loadtype='"..tostring(loadtype).."'")
	--TODO pause 
	if(ElderScrollsOfAlts.view.pauseactivesave) then 
		ElderScrollsOfAlts.debugMsg( GetString(ESOA_MSG_PAUSED) )
		return
	end
	local isInDungeon = IsUnitInDungeon("player")
	if(isInDungeon and ElderScrollsOfAlts.savedVariables.dontLoadDataInDungeon ) then
		ElderScrollsOfAlts.debugMsg("DataSaveLivePlayer:", " stopping per in instance") 
		return
	end
	local isInCombat = IsUnitInCombat("player")
	if(isInCombat and ElderScrollsOfAlts.savedVariables.dontLoadDataInCombat ) then
		ElderScrollsOfAlts.debugMsg("DataSaveLivePlayer:", " stopping per in combat") 
		return
	end
	local isPvPFlagged = IsUnitPvPFlagged("player")
	if(isInCombat and ElderScrollsOfAlts.savedVariables.dontLoadDataWhilePvPFlagged ) then
		ElderScrollsOfAlts.debugMsg("DataSaveLivePlayer:", " stopping per is PvPFlagged") 
		return
	end
	--
	if (ESOADatastore ~= nil) then
		ESOADatastore.saveCurrentCharcterDataAll(loadtype)
		--ElderScrollsOfAlts.DataSaveLivePlayer2(loadtype)
	else 
		ElderScrollsOfAlts.DataSaveLivePlayer2(loadtype)
	end
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataLevel(companionId, cname, level, currentExperience, experienceForLevel)
	ElderScrollsOfAlts.debugMsg("CollectCompanionDataLevel: Called")
	if (EchoESOADatastore ~= nil) then
		ElderScrollsOfAlts:CollectCompanionDataLevelDS(companionId, cname, level, currentExperience, experienceForLevel)
	else
		ElderScrollsOfAlts:CollectCompanionDataLevelLegacy(companionId, cname, level, currentExperience, experienceForLevel)
	end
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataSkillRank(companionId, cname, skillLineId, slName, rank )
	ElderScrollsOfAlts.debugMsg("CollectCompanionDataSkillRank: Called")
	if (EchoESOADatastore ~= nil) then
		ElderScrollsOfAlts:CollectCompanionDataSkillRankDS(companionId, cname, skillLineId, slName, rank )
	else
		ElderScrollsOfAlts:CollectCompanionDataSkillRankLegacy(companionId, cname, skillLineId, slName, rank )
	end
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataSkillLine(companionId, cname, skillLineId, slName )
	ElderScrollsOfAlts.debugMsg("CollectCompanionDataSkillLine: Called")
	if (EchoESOADatastore ~= nil) then
		ElderScrollsOfAlts:CollectCompanionDataSkillLineDS(companionId, cname, skillLineId, slName )
	else
		ElderScrollsOfAlts:CollectCompanionDataSkillLineLegacy(companionId, cname, skillLineId, slName )
	end
end

------------------------------
--Companions
function ElderScrollsOfAlts:CollectCompanionDataRapport(companionId, cname, currentRapport)
	ElderScrollsOfAlts.debugMsg("CollectCompanionDataRapport: Called")
	if (EchoESOADatastore ~= nil) then
		ElderScrollsOfAlts:CollectCompanionDataRapportDS(companionId, cname, currentRapport )
	else
		ElderScrollsOfAlts:CollectCompanionDataRapportLegacy(companionId, cname, currentRapport )
	end
end

----------------------------------------
 --[[ ESOA Data ]]-- 
----------------------------------------