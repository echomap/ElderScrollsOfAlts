--[[ ESOA Datastore Player Data ]]-- 

------------------------------
-- 


------------------------------
-- INT
function ESOADatastoreLogic.saveCurrentPlayerDataInt()
  local pName     = GetUnitName("player")
  local rName     = GetRawUnitName("player")   
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  EchoESOADatastore.view.whoiamplayerKey = tostring(playerKey)
  
  --globals
  if EchoESOADatastore.svCharDataAW.playerlist == nil then
		EchoESOADatastore.svCharDataAW.playerlist = {}
	end
  EchoESOADatastore.svCharDataAW.playerlist[playerKey] = pName
  
  --current
  --debugMsg("pName='"..tostring(pName).."'" )
  if EchoESOADatastore.svCharDataAW.players == nil then
		EchoESOADatastore.svCharDataAW.players = {}
	end  
  if EchoESOADatastore.svCharDataAW.sections == nil then
		EchoESOADatastore.svCharDataAW.sections = {}
	end
  if EchoESOADatastore.svCharDataAW.sections.bio == nil then
		EchoESOADatastore.svCharDataAW.sections.bio = {}
	end
  if EchoESOADatastore.svCharDataAW.sections.stats == nil then
		EchoESOADatastore.svCharDataAW.sections.stats = {}
	end
  if EchoESOADatastore.svCharDataAW.sections.skills == nil then
		EchoESOADatastore.svCharDataAW.sections.skills = {}
	end
  if EchoESOADatastore.svCharDataAW.sections.tradeskills == nil then
		EchoESOADatastore.svCharDataAW.sections.tradeskills = {}
	end
  
  
  --Resets all my data to current data
	EchoESOADatastore.svCharDataAW.players[playerKey] = {}
  EchoESOADatastore.svCharDataAW.players[playerKey].version = EchoESOADatastore.version
  EchoESOADatastore.svCharDataAW.players[playerKey].previousversion = EchoESOADatastore.view.previousversion

  -- BIO section
  ESOADatastoreLogic.saveCurrentPlayerDataBio(   playerKey, EchoESOADatastore.svCharDataAW.sections.bio )
  ESOADatastoreLogic.saveCurrentPlayerDataStats( playerKey, EchoESOADatastore.svCharDataAW.sections.stats )
  ESOADatastoreLogic.saveCurrentPlayerDataSkills(playerKey, EchoESOADatastore.svCharDataAW.sections.skills )
  --ESOADatastoreLogic.saveCurrentPlayerDataTradeSkills(playerKey, EchoESOADatastore.svCharDataAW.sections.tradeskills )
  
  --
  local myBioSection     = EchoESOADatastore.svCharDataAW.sections.bio[playerKey]
  local mySkilllsSection = EchoESOADatastore.svCharDataAW.sections.skills[playerKey]
  
  --Check Specific Skilllines for --Werewolf or Vampire--
  if(mySkilllsSection~=nil and mySkilllsSection.world~=nil) then
    for key,value in pairs(mySkilllsSection.world) do
      --print(key,value)
      if key == "Werewolf" then
        EchoESOADatastore.svCharDataAW.players[playerKey].bio.Werewolf = true
      elseif key == "Vampire" then
        EchoESOADatastore.svCharDataAW.players[playerKey].bio.Vampire = true
      end
    end
  end
  --
end

------------------------------
-- INT
function ESOADatastoreLogic.saveCurrentPlayerDataSkills(playerKey, sectionElem)
  --
  sectionElem[playerKey] = {}
  local playerElem = sectionElem[playerKey]
  --
  sectionElem[playerKey].baseranks = {}
  local playerRanksElem = sectionElem[playerKey].baseranks

  -- DEFAULTS --
  local skillType          = nil  
  local baseElem           = nil
  local outputUndiscovered = false

  --
  skillType = SKILL_TYPE_ARMOR 
  outputUndiscovered = true
	playerElem.armor = {}
  baseElem = playerElem.armor --.typelist
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,outputUndiscovered,playerRanksElem)
  
  --
  skillType = SKILL_TYPE_WORLD 
  outputUndiscovered = false
	playerElem.world = {}
  baseElem = playerElem.world --.typelist
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,playerRanksElem)
  
  --
  skillType = SKILL_TYPE_CLASS 
  outputUndiscovered = false
	playerElem.class = {}
  baseElem = playerElem.class --.typelist
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,playerRanksElem)
  
  --
  skillType = SKILL_TYPE_GUILD  
  outputUndiscovered = false
	playerElem.guild = {}
  baseElem = playerElem.guild --.typelist
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,playerRanksElem)
  
  --
  skillType = SKILL_TYPE_RACIAL  
  outputUndiscovered = false
	playerElem.racial = {}
  baseElem = playerElem.racial --.typelist
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,playerRanksElem)
  
  --
  skillType = SKILL_TYPE_WEAPON  
  outputUndiscovered = false
	playerElem.weapon = {}
  baseElem = playerElem.weapon --.typelist
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,playerRanksElem)
    
  --
  skillType = SKILL_TYPE_AVA  
  outputUndiscovered = false
	playerElem.ava = {}
  baseELem = playerElem.ava
  ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,playerRanksElem)
  --
end

------------------------------
-- INT
function ESOADatastoreLogic.saveCurrentPlayerDataTradeSkills(playerKey, sectionElem)
  --
  sectionElem[playerKey] = {}
  local playerElem = sectionElem[playerKey]
  --
  sectionElem[playerKey].baseranks = {}
  local playerRanksElem = sectionElem[playerKey].baseranks
  
  -- DEFAULTS --
  local skillType          = nil  
  local baseElem           = nil
  local outputUndiscovered = false

  -- TRADESKILLS
  skillType = SKILL_TYPE_TRADESKILL 
  outputUndiscovered = true  
  
  --
  local baseTableElem = sectionElem
  local numSkillLines = GetNumSkillLines(skillType)
  for ii = 1, numSkillLines do
    --name, number rank, boolean discovered, number skillLineId, boolean advised, unlockText
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
		if name == nil then
			name = ii;
		end
		baseTableElem[name]	= {}
		local selElemTable = baseTableElem[name]
		local numAbilities = GetNumSkillAbilities(skillType, ii)
		selElemTable.name = name
		selElemTable.idx  = ii	
		selElemTable.rank = rank
    selElemTable.numAbilities = numAbilities
		selElemTable.skillLineId = skillLineId
    
    local lastRankXP, nextRankXP, currentXP  = GetSkillLineXPInfo( skillType, ii )
    selElemTable.lastRankXP = lastRankXP
    selElemTable.nextRankXP = nextRankXP
    selElemTable.currentXP  = currentXP
    
		ESOADatastoreLogic.SaveDataPlayerTradeDetails( name, baseTableElem, selElemTable, skillType, ii, numAbilities )
	end
end

------------------------------
-- INT
function ESOADatastoreLogic.saveCurrentPlayerDataStats(playerKey, sectionElem)
  
  sectionElem[playerKey] = {}
  local playerElem = sectionElem[playerKey]
    
	local current, max, effectiveMax = GetUnitPower("player", POWERTYPE_STAMINA)
	playerElem["stamina"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_HEALTH)
	playerElem["health"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_MAGICKA)
	playerElem["magicka"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_POWER)
	playerElem["power"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_WEREWOLF)
	playerElem["werewolf"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_FERVOR)
	playerElem["fervor"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_COMBO)
	playerElem["combo"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_CHARGES)
	playerElem["charges"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_MOUNT_STAMINA)
	playerElem["mountstamina"] = max
  --
end

------------------------------
-- INT
function ESOADatastoreLogic.saveCurrentPlayerDataBio( playerKey, sectionElem)
  sectionElem[playerKey] = {}
  local playerElem = sectionElem[playerKey]
  
  local pName     = GetUnitName("player")
  local rName     = GetRawUnitName("player")   
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()

  playerElem.name    = pName
  playerElem.rawname = rName  
  playerElem.id      = pID
  playerElem.server  = pServer  
	local pGender = GetUnitGender("player")
	playerElem.gender = pGender
	local pLvl = GetUnitLevel("player")
	playerElem.level = pLvl
  local canChampPts = CanUnitGainChampionPoints("player")
  playerElem.CanChampPts = canChampPts  
  if CanChampPts then
    --TODO Not sure what effective level means
    --playerElem.level    = GetUnitEffectiveLevel("player") 
    playerElem.champion = GetUnitChampionPoints("player")   
  end  
	local pRace = GetUnitRace("player")
	playerElem.race = pRace
	--GetUnitRaceId(string unitTag)
	local pClass = GetUnitClass("player")
	playerElem.class = pClass
	local pClassId = GetUnitClassId("player")
	playerElem.classId = pClassId
  local pAlliance = GetUnitAlliance("player")
  playerElem.alliance = pAlliance

  --Werewolf or Vampire
  playerElem.Werewolf = false
  playerElem.Vampire  = false
  --
end
------------------------------
------------------------------


------------------------------
-- INT
function ESOADatastoreLogic.SaveDataPlayerTradeDetails(parentName, parentTableElem, tradeTableElem, skillType, ii, numAbilities )
  --TODO
end

------------------------------
-- INT (part 2)
function ESOADatastoreLogic:SaveDataSkillData(skillType,baseElem,outputUndiscovered,playerRanksElem)
  if skillType == nil then
      EchoESOADatastore.debugMsg("SaveDataSkillData: skillType is NIL")
      return
  end
  
  --EchoESOADatastore.debugMsg("loadPlayerDataPart: skillType="..skillType..".")
	local numSkillLines = GetNumSkillLines(skillType)
  for ii = 1, numSkillLines do
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
		--name, number rank, boolean discovered, number skillLineId, boolean advised, unlockText
		if name == nil then
			name = ii;
		end
    if discovered or outputUndiscovered then
      --EchoESOADatastore.debugMsg("loadPlayerDataPart: unlockText="..unlockText..".")
      baseElem[name]	= {}
      local baseElemTable = baseElem[name]
      local numAbilities = GetNumSkillAbilities(skillType, ii)
      baseElemTable.name = name
      baseElemTable.idx  = ii
      baseElemTable.rank = rank
      baseElemTable.numAbilities = numAbilities
      baseElemTable.skillLineId  = skillLineId
      playerRanksElem[name] = rank
      
      local lastRankXP, nextRankXP, currentXP  = GetSkillLineXPInfo( skillType, ii )
      baseElemTable.lastRankXP = lastRankXP
      baseElemTable.nextRankXP = nextRankXP
      baseElemTable.currentXP  = currentXP

      --EchoESOADatastore.loadPlayerDataPartDetails(skillType,skillLineId,ii,name,pName)
      --string name, textureName texture, number earnedRank, boolean passive, boolean ultimate, boolean purchased, number:nilable progressionIndex, number:nilable rankIndex 
      --GetSkillAbilityInfo(number SkillType skillType, number skillIndex, number abilityIndex)
      baseElemTable.abilities = {}
      local baseAbilityElem = baseElemTable.abilities
      for abilityIndex = 1, numAbilities do
        local ABname, ABtextureName, ABearnedRank, ABpassive, ABultimate, ABpurchased, ABprogressionIndex, ABrankIndex =
        GetSkillAbilityInfo(skillType, ii, abilityIndex)
        baseAbilityElem[ABname] = {}
        baseAbilityElem[ABname].name        = ABname
        baseAbilityElem[ABname].textureName = ABtextureName
        baseAbilityElem[ABname].earnedRank  = ABearnedRank
        baseAbilityElem[ABname].passive     = ABpassive
        baseAbilityElem[ABname].ultimate    = ABultimate
        baseAbilityElem[ABname].purchased   = ABpurchased
        baseAbilityElem[ABname].progressionIndex = ABprogressionIndex
        baseAbilityElem[ABname].rankIndex   = ABrankIndex
      end
      --
    else --if discovered or outputUndiscovered then
      --debugMsg("loadPlayerDataPart: skillType="..skillType..". name=" ..name)
    end      
	end
end
------------------------------
------------------------------
-- EOF