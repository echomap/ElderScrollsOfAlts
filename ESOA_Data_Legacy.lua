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
--Load missing data into: ElderScrollsOfAlts.view.playerLines
function ElderScrollsOfAlts:SetupGuiPlayerLinesDSpre()
	--
	local accountname = GetDisplayName()
	if( ElderScrollsOfAlts.view.selectedAccount ~=nil ) then
		if( accountname~=ElderScrollsOfAlts.view.selectedAccount ) then
			ElderScrollsOfAlts.outputMsg("SetupLEGPlayer: Can't Load Legacy characters from a different account.")
			return
		end
	end
	--TODO bankspaces ?
	--
	local pCount = 0
	--
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
		if k == nil then return end
		ElderScrollsOfAlts.outputMsg("SetupLinePre: Checking player: '" , k , "'")
		pCount = pCount+1
		--
		if( ElderScrollsOfAlts.view.playerLines[k] == nil )  then
			ElderScrollsOfAlts.outputMsg("SetupLinePre: player: '" , k , "'")
			ElderScrollsOfAlts.view.playerLines[k] = {}
			ElderScrollsOfAlts:SetupGuiPlayerLinesForK( ElderScrollsOfAlts.view.playerLines,k )
		end
		-- CHECK Data
	end --for k, v in pairs(ElderScrollsOfAlts.altData.players) do
	-- PlayerLines to table
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
function ElderScrollsOfAlts:InitTrackingDataLegacy(trackingType,trackingName)
   ----Section: Statup section
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey =  zo_strformat("<<1>>_<<2>>", pID, pServer:gsub(" ","_") )
  ----Section: Save section
	if ElderScrollsOfAlts.altData.players == nil then
		ElderScrollsOfAlts.altData.players = {}
	end
  if( ElderScrollsOfAlts.altData.players[playerKey] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey] = {}
  end
  if( ElderScrollsOfAlts.altData.players[playerKey].tracking == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].tracking = {}
  end
  if( ElderScrollsOfAlts.altData.players[playerKey].tracking[trackingType] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].tracking[trackingType] = {}
  end
  if( ElderScrollsOfAlts.altData.players[playerKey].tracking[trackingType][trackingName] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].tracking[trackingType][trackingName] = {}
  end
  return ElderScrollsOfAlts.altData.players[playerKey].tracking[trackingType][trackingName]
end

--
function ElderScrollsOfAlts:CollectCPLegacy()
  ElderScrollsOfAlts.debugMsg("CollectCP: called")
  ----Section: Statup section
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  
  --local timeTotalStart = GetFrameTimeSeconds()
  --ElderScrollsOfAlts.debugMsg("timeTotalStart: " .. tostring(timeTotalStart) )
  
  --debugMsg("pName='"..tostring(pName).."'" )
  if ElderScrollsOfAlts.altData.players == nil then
		ElderScrollsOfAlts.altData.players = {}
  end
  if( ElderScrollsOfAlts.altData.players[playerKey] == nil ) then
    ElderScrollsOfAlts.altData.players[playerKey] = {}
  end
  
  ----Section: Collect section
  --if( ElderScrollsOfAlts.altData.players[playerKey] ~= nil ) then
  --end  
  
  ----Section: Save section
  if( ElderScrollsOfAlts.altData.players[playerKey] ~= nil ) then
    ElderScrollsOfAlts.altData.players[playerKey].championpointsactive = {}
    
    --d("[start] TestCP...")
    local CP = CHAMPION_PERKS
    local championBar = CHAMPION_PERKS:GetChampionBar() 
    local CPData = CHAMPION_DATA_MANAGER
    
    local start, nd = GetAssignableChampionBarStartAndEndSlots() -- 1 and 12.
    for i=start, nd do -- loop all 12 slots.
	local starId = GetSlotBoundId(i, HOTBAR_CATEGORY_CHAMPION)
	local req = GetRequiredChampionDisciplineIdForSlot(i, HOTBAR_CATEGORY_CHAMPION)
	local disType = GetChampionDisciplineType(req)
	
	if starId ~= 0 then
		local pointsSpent = GetNumPointsSpentOnChampionSkill(starId)
		local name = GetChampionSkillName(starId)
		ElderScrollsOfAlts.altData.players[playerKey].championpointsactive[i] = {}
		ElderScrollsOfAlts.altData.players[playerKey].championpointsactive[i].id = starId
		ElderScrollsOfAlts.altData.players[playerKey].championpointsactive[i].name = name
		ElderScrollsOfAlts.altData.players[playerKey].championpointsactive[i].disciplineid = req
		ElderScrollsOfAlts.altData.players[playerKey].championpointsactive[i].disciplinetype = disType
		ElderScrollsOfAlts.altData.players[playerKey].championpointsactive[i].numspentpoints = pointsSpent
	end
    end
    
    --xxx
    ElderScrollsOfAlts.altData.players[playerKey].championpoints = {}
    local numDisciplines = GetNumChampionDisciplines()
    --d("numDisciplines: " .. tostring(numDisciplines) )
    for disciplineIndex = 1, numDisciplines do
      ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex] = {}
      ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex].name = GetChampionDisciplineName(disciplineIndex)
      --ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex].id = disciplineIndex
      for championSkillIndex = 1, GetNumChampionDisciplineSkills(disciplineIndex) do
        local championSkillId = GetChampionSkillId(disciplineIndex, championSkillIndex)
        --local numPendingPoints =  GetNumPendingChampionPoints(disciplineIndex, championSkillIndex)
        local ptsspent  = GetNumPointsSpentOnChampionSkill(championSkillId)
        if(ptsspent>0) then
          local championSkillType = GetChampionSkillType(championSkillId)
          local isSlottable       = ElderScrollsOfAlts:CheckIfCpTypeIsSlottable( championSkillType )
          if(isSlottable) then
            local name      = GetChampionSkillName(championSkillId)
            local abilityId = GetChampionAbilityId(championSkillId)
            ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex][championSkillId] = {}
            --ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex][championSkillId].pts = numPendingPoints
            ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex][championSkillId].name      = name
            ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex][championSkillId].ptsspent  = ptsspent
            ElderScrollsOfAlts.altData.players[playerKey].championpoints[disciplineIndex][championSkillId].abilityId = abilityId
            
            --d("championSkillId: " .. tostring(championSkillId) )
            --local championSkillData = ZO_ChampionSkillData:New(self, skillIndex)
            --d("championSkillData: " .. tostring(championSkillData) )
            --if championSkillData:IsClusterRoot() then
            --   table.insert(self.championClusterDatas, ZO_ChampionClusterData:New(championSkillData))
            --end
            --self.championSkillDatas[skillIndex] = championSkillData
          end
        end--spent points
      end
    end
    --d("TestCP...[end]")
  end -- if player line exists
  ElderScrollsOfAlts.debugMsg("CollectCP: done")
end
--CollectCP()

------------------------------
-- 
----------------------------------------
 --[[ ESOA Data Legacy ]]-- 
----------------------------------------