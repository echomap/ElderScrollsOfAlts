--

--Solvent Proficiency, Metalworking, Tailoring, (Aspect Improvement, Potency Improvement), Recipe Quality, Recipe Improvement, Woodworking
local matchNameList1 = {"Solvent Proficiency", "Metalworking", "Tailoring", "Aspect Improvement", "Recipe Quality", "Woodworking", "Engraver" }
local matchNameList2 = {"Potency Improvement", "Recipe Improvement", }

local SLOT_TYPE_REV = {
  EQUIP_SLOT_HEAD      = "Head",
  EQUIP_SLOT_NECK      = "Neck",
  EQUIP_SLOT_SHOULDERS = "Shoulders",
  EQUIP_SLOT_CHEST     = "Chest",
  EQUIP_SLOT_WAIST     = "Waist",
  EQUIP_SLOT_WRIST     = "Wrist",
  EQUIP_SLOT_FEET      = "Feet", --9
  EQUIP_SLOT_HAND      = "Hand",
  EQUIP_SLOT_LEGS      = "Legs",
  
  EQUIP_SLOT_BACKUP_MAIN   = "ScndMain",
  EQUIP_SLOT_BACKUP_OFF    = "ScndOff",
  EQUIP_SLOT_BACKUP_POISON = "ScndPoison",
  EQUIP_SLOT_OFF_HAND      = "OffHand",
  EQUIP_SLOT_POISON        = "MainPoison",
  EQUIP_SLOT_MAIN_HAND     = "MainHand",
  EQUIP_SLOT_RANGED        = "Ranged",
  
  EQUIP_SLOT_CLASS1  = "Class1",
  EQUIP_SLOT_CLASS2  = "Class2",
  EQUIP_SLOT_CLASS3  = "Class3",
  EQUIP_SLOT_COSTUME = "Costume",
  
  EQUIP_SLOT_RING1 = "Ring1",
  EQUIP_SLOT_RING2 = "Ring2",
  
  EQUIP_SLOT_NONE = "None",
}

--
function ElderScrollsOfAlts.SavePlayerData( playerLineKey, keyName, elementData )
  if( ElderScrollsOfAlts.altData.players[playerLineKey] ~= nil ) then
    ElderScrollsOfAlts.altData.players[playerLineKey][keyName] = elementData
    ElderScrollsOfAlts.debugMsg("SavePlayerData: player=",playerLineKey," keyName=",keyName," as ", elementData) 
  end
end

-- Read all data from the game Player Object into this Addon
function ElderScrollsOfAlts:DataSaveLivePlayer()
	local pName     = GetUnitName("player")
  local rName     = GetRawUnitName("player")   
  local pID       = GetCurrentCharacterId()
  local pServer   = GetWorldName()
  local playerKey = pID.."_".. pServer:gsub(" ","_")
  ElderScrollsOfAlts.view.whoiamplayerKey = tostring(playerKey)
  
  --debugMsg("pName='"..tostring(pName).."'" )
	if ElderScrollsOfAlts.altData.players == nil then
		ElderScrollsOfAlts.altData.players = {}
	end

  --Protect note data if not saved to disk in this session
  if( ElderScrollsOfAlts.altData.players[pName] ~= nil and 
      ElderScrollsOfAlts.altData.players[pName].note ~= nil ) then
    ElderScrollsOfAlts.view.currentnote = ElderScrollsOfAlts.altData.players[pName].note
    ElderScrollsOfAlts.debugMsg("ESOA, saved current note, as '", tostring(ElderScrollsOfAlts.altData.players[pName].note) , "'")
  end
  
  if( ElderScrollsOfAlts.altData.players[pName] ~= nil and 
      ElderScrollsOfAlts.altData.players[pName].category~=nil ) then
    ElderScrollsOfAlts.view.currentcategory = ElderScrollsOfAlts.altData.players[pName].category
    ElderScrollsOfAlts.debugMsg("ESOA, saved current category, as '", tostring(ElderScrollsOfAlts.altData.players[pName].category) , "'")    
  end
  --Protect note data if not saved to disk in this session
  if( ElderScrollsOfAlts.altData.players[playerKey] ~= nil and 
      ElderScrollsOfAlts.altData.players[playerKey].note ~= nil ) then
    ElderScrollsOfAlts.view.currentnote = ElderScrollsOfAlts.altData.players[playerKey].note
    ElderScrollsOfAlts.debugMsg("ESOA, saved current note, as '", tostring(ElderScrollsOfAlts.altData.players[playerKey].note) , "'")
  end
  
  if( ElderScrollsOfAlts.altData.players[playerKey] ~= nil and 
      ElderScrollsOfAlts.altData.players[playerKey].category~=nil ) then
    ElderScrollsOfAlts.view.currentcategory = ElderScrollsOfAlts.altData.players[playerKey].category
    ElderScrollsOfAlts.debugMsg("ESOA, saved current category, as '", tostring(ElderScrollsOfAlts.altData.players[playerKey].category) , "'")    
  end

  --- Reset Old Data Format
  --Resets all my data to current data
	ElderScrollsOfAlts.altData.players[pName] = nil
  
  --- Reset New Data Format
  --Resets all my data to current data
	ElderScrollsOfAlts.altData.players[playerKey] = {}
  ElderScrollsOfAlts.altData.players[playerKey].category = "A"


  -- BIO section
	if ElderScrollsOfAlts.altData.players[playerKey].bio == nil then
		ElderScrollsOfAlts.altData.players[playerKey].bio = {}
	end  
  
  ElderScrollsOfAlts.altData.players[playerKey].bio.server  = pServer
  ElderScrollsOfAlts.altData.players[playerKey].bio.id      = pID
  ElderScrollsOfAlts.altData.players[playerKey].bio.name    = pName
  ElderScrollsOfAlts.altData.players[playerKey].bio.rawname = rName  
	local pGender = GetUnitGender("player")
	ElderScrollsOfAlts.altData.players[playerKey].bio.gender = pGender
	local pLvl = GetUnitLevel("player")
	ElderScrollsOfAlts.altData.players[playerKey].bio.level = pLvl
  local canChampPts = CanUnitGainChampionPoints("player")
  ElderScrollsOfAlts.altData.players[playerKey].bio.CanChampPts = canChampPts  
  if CanChampPts then
    --TODO Not sure what this means
    --ElderScrollsOfAlts.altData.players[playerKey].bio.level    = GetUnitEffectiveLevel("player") 
    ElderScrollsOfAlts.altData.players[playerKey].bio.champion = GetUnitChampionPoints("player")   
  end  
	local pRace = GetUnitRace("player")
	ElderScrollsOfAlts.altData.players[playerKey].bio.race = pRace
	--GetUnitRaceId(string unitTag)
	local pClass = GetUnitClass("player")
	ElderScrollsOfAlts.altData.players[playerKey].bio.class = pClass
	local pClassId = GetUnitClassId("player")
	ElderScrollsOfAlts.altData.players[playerKey].bio.classId = pClassId
  local pAlliance = GetUnitAlliance("player")
  ElderScrollsOfAlts.altData.players[playerKey].bio.alliance = pAlliance

	--local value = GetPlayerStat(self.statType, STAT_BONUS_OPTION_APPLY_BONUS)
	if ElderScrollsOfAlts.altData.players[playerKey].stats == nil then
		ElderScrollsOfAlts.altData.players[playerKey].stats = {}
	end
  --Werewolf or Vampire
  ElderScrollsOfAlts.altData.players[playerKey].bio.Werewolf = false
  ElderScrollsOfAlts.altData.players[playerKey].bio.Vampire  = false

	local current, max, effectiveMax = GetUnitPower("player", POWERTYPE_STAMINA)
	ElderScrollsOfAlts.altData.players[playerKey].stats["stamina"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_HEALTH)
	ElderScrollsOfAlts.altData.players[playerKey].stats["health"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_MAGICKA)
	ElderScrollsOfAlts.altData.players[playerKey].stats["magicka"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_POWER)
	ElderScrollsOfAlts.altData.players[playerKey].stats["power"] = max
	--POWERTYPE_WEREWOLF
	--POWERTYPE_FERVOR
	--POWERTYPE_COMBO
	--POWERTYPE_CHARGES
	--POWERTYPE_MOUNT_STAMINA

	--ABILITIES/SKILLS
	if ElderScrollsOfAlts.altData.players[playerKey].skills == nil then
		ElderScrollsOfAlts.altData.players[playerKey].skills = {}
	end

	--
  local skillType = SKILL_TYPE_ARMOR
	ElderScrollsOfAlts.altData.players[playerKey].skills.armor = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.armor.typelist = {}
  local baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.armor.typelist
	local numSkillLines = GetNumSkillLines(skillType)
  for ii = 1, numSkillLines do
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
		--name, number rank, boolean discovered, number skillLineId, boolean advised, unlockText
		if name == nil then
			name = ii;
		end
		baseElem[name]	= {}
		local baseElemTable = baseElem[name]
		local numAbilities = GetNumSkillAbilities(skillType, ii)
		baseElemTable.name = name
		baseElemTable.idx = ii
		baseElemTable.numAbilities = numAbilities
		baseElemTable.rank = rank
		baseElemTable.skillLineId = skillLineId
		--ElderScrollsOfAlts.loadPlayerArmorDetails(skillType,skillLineId,ii,name,playerKey)
	end
  
  --
  skillType = SKILL_TYPE_WORLD 
	ElderScrollsOfAlts.altData.players[playerKey].skills.world = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.world.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.world.typelist
  ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_CLASS 
	ElderScrollsOfAlts.altData.players[playerKey].skills.class = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.class.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.class.typelist
  ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_GUILD  
	ElderScrollsOfAlts.altData.players[playerKey].skills.guild = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.guild.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.guild.typelist
  ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_RACIAL  
	ElderScrollsOfAlts.altData.players[playerKey].skills.racial = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.racial.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.racial.typelist
  ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_WEAPON  
	ElderScrollsOfAlts.altData.players[playerKey].skills.weapon = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.weapon.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.weapon.typelist
  ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
    
  --
  skillType = SKILL_TYPE_AVA  
	ElderScrollsOfAlts.altData.players[playerKey].skills.ava = {}
	ElderScrollsOfAlts.altData.players[playerKey].skills.ava.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[playerKey].skills.ava.typelist
  ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
    
  --SKILL_TYPE_NONE

	--SKILL_TYPE_TRADESKILL
	ElderScrollsOfAlts.altData.players[playerKey].skills.trade = {}
	local baseTableElem = ElderScrollsOfAlts.altData.players[playerKey].skills.trade
	baseTableElem.typelist = {}
  baseTableElem.skills   = {}
	skillType = SKILL_TYPE_TRADESKILL
  numSkillLines = GetNumSkillLines(skillType)
  for ii = 1, numSkillLines do
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
		--name, number rank, boolean discovered, number skillLineId, boolean advised, unlockText
		if name == nil then
			name = ii;
		end
		baseTableElem.typelist[name]	= {}
		local selElemTable = baseTableElem.typelist[name]
		local numAbilities = GetNumSkillAbilities(skillType, ii)
		selElemTable.name = name
		selElemTable.idx = ii
		selElemTable.numAbilities = numAbilities
		selElemTable.rank = rank
		selElemTable.skillLineId = skillLineId
    
		ElderScrollsOfAlts.SaveDataPlayerTradeDetails( name, baseTableElem, selElemTable, skillType, ii, numAbilities ) --skillLineId,ii,name,baseTableElem,playerKey)
	end

  --Check Specific Skilllines
  --ElderScrollsOfAlts.altData.players[playerKey].skills.world.typelist = {}
  --Werewolf or Vampire
  for key,value in pairs(ElderScrollsOfAlts.altData.players[playerKey].skills.world.typelist) do
    --print(key,value)
    if key == "Werewolf" then
      ElderScrollsOfAlts.altData.players[playerKey].bio.Werewolf = true
    elseif key == "Vampire" then
      ElderScrollsOfAlts.altData.players[playerKey].bio.Vampire = true
    end
  end  
  
  --Misc
  if(ElderScrollsOfAlts.altData.players[playerKey].misc==nil) then
    ElderScrollsOfAlts.altData.players[playerKey].misc = {}
  end
  
  ElderScrollsOfAlts.altData.players[playerKey].misc.now = GetFrameTimeSeconds()--ZO_FormatClockTime()
  
  --Riding
  local inventoryBonus, maxInventoryBonus, staminaBonus, maxStaminaBonus, speedBonus, maxSpeedBonus =   GetRidingStats()
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding = {}
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.inventory = inventoryBonus
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.stamina   = staminaBonus
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.speed     = speedBonus
  local canTrainRiding = false
  if(speedBonus < maxSpeedBonus)then
    canTrainRiding = true
  elseif (staminaBonus < maxStaminaBonus) then
    canTrainRiding = true
  elseif(inventoryBonus < maxInventoryBonus) then
    canTrainRiding = true
  end
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.cantrain = canTrainRiding   
  local timeMs, totalDurationMs = GetTimeUntilCanBeTrained()
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.timeMs          = timeMs
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.totalDurationMs = totalDurationMs
  ElderScrollsOfAlts.altData.players[playerKey].misc.riding.timeDataTaken   = GetFrameTimeMilliseconds()
  if(timeMs<1)then
    ElderScrollsOfAlts.altData.players[playerKey].misc.riding.trainingReadyAt  = 0
  else
    local expiresAt = GetFrameTimeMilliseconds() + timeMs
    ElderScrollsOfAlts.altData.players[playerKey].misc.riding.trainingReadyAt  = expiresAt
  end
 
  -- Bags
  local bagSize = GetBagSize(BAG_BACKPACK) 
  local bagUsed = GetNumBagUsedSlots(BAG_BACKPACK)
  ElderScrollsOfAlts.altData.players[playerKey].misc.backpackSize = bagSize
  ElderScrollsOfAlts.altData.players[playerKey].misc.backpackUsed = bagUsed
  ElderScrollsOfAlts.altData.players[playerKey].misc.backpackFree = tonumber( bagSize-bagUsed )
  --
  ElderScrollsOfAlts.altData.players[playerKey].misc.skillpoints = GetAvailableSkillPoints() 
  ElderScrollsOfAlts.altData.players[playerKey].misc.secondsPlayed = GetSecondsPlayed()
  --GetUnitZone("player")
  
  --Currency
  if(ElderScrollsOfAlts.altData.players[playerKey].currency==nil) then
    ElderScrollsOfAlts.altData.players[playerKey].currency = {}
  end  
  local currType = {CURT_ALLIANCE_POINTS, CURT_CHAOTIC_CREATIA,CURT_CROWNS,CURT_CROWN_GEMS,CURT_MONEY,CURT_NONE,CURT_STYLE_STONES,CURT_TELVAR_STONES,CURT_WRIT_VOUCHERS}
  local currLoc = {CURRENCY_LOCATION_ACCOUNT,CURRENCY_LOCATION_BANK,CURRENCY_LOCATION_CHARACTER,CURRENCY_LOCATION_GUILD_BANK}
  for clIdx = 1, #currLoc do 
    local cL = currLoc[clIdx]
    ElderScrollsOfAlts.altData.players[playerKey].currency[cL] = {}
    for ctIdx = 1, #currType do
      local cT = currType[ctIdx]
      local amount = GetCurrencyAmount( cT, cL )
      ElderScrollsOfAlts.altData.players[playerKey].currency[cL][cL] = amount
    end
  end  

  -- Equipment
  ElderScrollsOfAlts:SavaDataPlayerEquipment(playerKey)
  
  --Research
  ElderScrollsOfAlts.altData.players[playerKey].research = {}  
  ElderScrollsOfAlts.altData.players[playerKey].research.now = GetFrameTimeSeconds()
  ElderScrollsOfAlts:SaveDataPlayerResearchData(CRAFTING_TYPE_BLACKSMITHING, "blacksmithing",
        ElderScrollsOfAlts.altData.players[playerKey].research)
  ElderScrollsOfAlts:SaveDataPlayerResearchData(CRAFTING_TYPE_CLOTHIER, "clothier", 
        ElderScrollsOfAlts.altData.players[playerKey].research)
  ElderScrollsOfAlts:SaveDataPlayerResearchData(CRAFTING_TYPE_WOODWORKING, "woodworking",
        ElderScrollsOfAlts.altData.players[playerKey].research)
  --7 d("CRAFTING_TYPE_JEWELRYCRAFTING="..tostring(CRAFTING_TYPE_JEWELRYCRAFTING) )
  ElderScrollsOfAlts:SaveDataPlayerResearchData(CRAFTING_TYPE_JEWELRYCRAFTING, "jewelcrafting",
        ElderScrollsOfAlts.altData.players[playerKey].research)
  --TODO //JC?
  
  --Bags/ Bank
  ElderScrollsOfAlts.altData.data = {}
  ElderScrollsOfAlts.altData.data.server = {}
  ElderScrollsOfAlts.altData.data.server[pServer] = {}
  
  local bagSizeB = GetBagSize(BAG_BACKPACK) 
  local bagUsedB = GetNumBagUsedSlots(BAG_BACKPACK)
  ElderScrollsOfAlts.altData.data.server[pServer].bankSize = bagSizeB
  ElderScrollsOfAlts.altData.data.server[pServer].bankUsed = bagUsedB
  ElderScrollsOfAlts.altData.data.server[pServer].bankFree = tonumber( bagSizeB-bagUsedB )
  
  -- Reload Note if not saved properly
  if( ElderScrollsOfAlts.view.currentnote ~= nil) then    
    ElderScrollsOfAlts.altData.players[playerKey].note = ElderScrollsOfAlts.view.currentnote
    ElderScrollsOfAlts.debugMsg("ESOA, restored current note, as '", tostring(ElderScrollsOfAlts.altData.players[playerKey].note) ,"'")
  end
  if( ElderScrollsOfAlts.view.currentcategory ~= nil) then    
    ElderScrollsOfAlts.altData.players[playerKey].category = ElderScrollsOfAlts.view.currentcategory
    ElderScrollsOfAlts.debugMsg("ESOA, restored current category, as '", tostring(ElderScrollsOfAlts.altData.players[playerKey].category) ,"'")
  end
  
  --TODO more?
  
  --BUFFS
  ElderScrollsOfAlts.altData.players[playerKey].buffs = {}  
  local numBuffs = GetNumBuffs("player") 
  for buffIndex = 1, numBuffs do
    --string buffName, number timeStarted, number timeEnding, number buffSlot, number stackCount, textureName iconFilename, string buffType, number BuffEffectType effectType, number AbilityType abilityType, number StatusEffectType statusEffectType, number abilityId, boolean canClickOff, boolean castByPlayer
    local buffName, timeStarted, timeEnding, buffSlot, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = GetUnitBuffInfo("player", buffIndex)
    ElderScrollsOfAlts.altData.players[playerKey].buffs[buffName] = {}
    ElderScrollsOfAlts.altData.players[playerKey].buffs[buffName].timeStarted = timeStarted 
    ElderScrollsOfAlts.altData.players[playerKey].buffs[buffName].timeEnding  = timeEnding
    ElderScrollsOfAlts.altData.players[playerKey].buffs[buffName].abilityId   = abilityId
  end
	-- Fetch the saved variables
end

--loadPlayerDataPart
function ElderScrollsOfAlts:SaveDataSkillData(skillType,baseElem)
  if skillType == nil then
      ElderScrollsOfAlts.debugMsg("SaveDataSkillData: skillType is NIL")
      return
  end
  --ElderScrollsOfAlts.debugMsg("loadPlayerDataPart: skillType="..skillType..".")
	local numSkillLines = GetNumSkillLines(skillType)
  for ii = 1, numSkillLines do
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
		--name, number rank, boolean discovered, number skillLineId, boolean advised, unlockText
		if name == nil then
			name = ii;
		end
    if discovered then
      --ElderScrollsOfAlts.debugMsg("loadPlayerDataPart: unlockText="..unlockText..".")
      baseElem[name]	= {}
      local baseElemTable = baseElem[name]
      local numAbilities = GetNumSkillAbilities(skillType, ii)
      baseElemTable.name = name
      baseElemTable.idx = ii
      baseElemTable.numAbilities = numAbilities
      baseElemTable.rank = rank
      baseElemTable.skillLineId = skillLineId
      --ElderScrollsOfAlts.loadPlayerDataPartDetails(skillType,skillLineId,ii,name,pName)
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

    else 
      --debugMsg("loadPlayerDataPart: skillType="..skillType..". name=" ..name)
    end      
	end
end

--loadPlayerTradeDetails
function ElderScrollsOfAlts.SaveDataPlayerTradeDetails(parentName, parentTableElem, tradeTableElem, skillType, ii, numAbilities )
    --Find Abilities - search for main - Levelled one, ie: use iron/maple/greenrunes
    --ElderScrollsOfAlts.debugMsg("parentName='",parentName,"'")
    parentTableElem.skills[parentName]	= {}
    local selElemSubTable = parentTableElem.skills[parentName]
    local skillIndex = ii
    selElemSubTable.sunk     = 0
    selElemSubTable.sinkmax  = 0
    selElemSubTable.sunk2    = 0
    selElemSubTable.sinkmax2 = 0
    for aj = 1, numAbilities do
        local name, icon, earnedRank, passive, ultimate, purchased, progressionIndex = GetSkillAbilityInfo(skillType, ii, aj)
        --ElderScrollsOfAlts.debugMsg("TradeSkill Ability: name="..name.. " purchased="..tostring(purchased))
        local currentUpgradeLevel, maxUpgradeLevel = GetSkillAbilityUpgradeInfo(skillType, skillIndex, aj)
        local _, _, nextUpgradeEarnedRank = GetSkillAbilityNextUpgradeInfo(skillType, skillIndex, aj)
        local plainName = zo_strformat(SI_ABILITY_NAME, name)
        name = ZO_Skills_GenerateAbilityName(SI_ABILITY_NAME_AND_UPGRADE_LEVELS, name, currentUpgradeLevel, maxUpgradeLevel, progressionIndex)
        --local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
        --if not (currentUpgradeLevel and maxUpgradeLevel) and progressionIndex then
        --    self.displayedAbilityProgressions[progressionIndex] = true
        --end
        --local isActive = (not passive and not ultimate)
        --local isUltimate = (not passive and ultimate)
        --ElderScrollsOfAlts.debugMsg("TradeSkill Ability: passive="..tostring(passive))
        if purchased then          
          selElemSubTable[plainName] = {}
          local selL = selElemSubTable[plainName]
          selL.plainName = plainName
          selL.name = name
          selL.earnedRank = earnedRank
          selL.currentUpgradeLevel = currentUpgradeLevel
          selL.maxUpgradeLevel = maxUpgradeLevel
          selL.nextUpgradeEarnedRank = nextUpgradeEarnedRank
          local match1 = ElderScrollsOfAlts:matchStringList(plainName,matchNameList1)
          if match1 then
            selElemSubTable.sunk    = selElemSubTable.sunk    + (currentUpgradeLevel - 1)
            selElemSubTable.sinkmax = selElemSubTable.sinkmax + (maxUpgradeLevel - 1)
            tradeTableElem.sunk     = selElemSubTable.sunk
            tradeTableElem.sinkmax  = selElemSubTable.sinkmax
          end
          local match2 = ElderScrollsOfAlts:matchStringList(plainName,matchNameList2)
          if match2 then
            selElemSubTable.sunk2    = selElemSubTable.sunk2    + (currentUpgradeLevel - 1)
            selElemSubTable.sinkmax2 = selElemSubTable.sinkmax2 + (maxUpgradeLevel - 1)
            tradeTableElem.sunk2     = selElemSubTable.sunk2
            tradeTableElem.sinkmax2  = selElemSubTable.sinkmax2
            --ElderScrollsOfAlts.debugMsg("loadPlayerTradeDetails: plainName="..plainName.." sunk2="..selElemSubTable.sunk2)
          end
        end
    end
end

--loadPlayerEquipment
function ElderScrollsOfAlts:SavaDataPlayerEquipment(playerKey)
  --local pName = GetUnitName("player")
  ElderScrollsOfAlts.altData.players[playerKey].items = {}
  ElderScrollsOfAlts.altData.players[playerKey].equip = {}
    
  ElderScrollsOfAlts.altData.players[playerKey].equip.slots = {}
  local elemH = ElderScrollsOfAlts.altData.players[playerKey].equip.slots
  for slotId = 0, GetBagSize(BAG_WORN) do    
  	local itemName = GetItemName(BAG_WORN, slotId)
    --quality is numeric
    local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyleId, quality = GetItemInfo(BAG_WORN, slotId)
    local itemId = GetItemInstanceId(BAG_WORN, slotId)
    local itemLink = GetItemLink(BAG_WORN, slotId)--, number LinkStyle linkStyle) 
    if( equipType ~= nil and equipType > EQUIP_TYPE_MIN_VALUE ) then
      --TODO check itemname not nil, and EquipType > 0
      elemH[slotId] = {}
      elemH[slotId].itemId = itemId
      elemH[slotId].itemName = itemName
      elemH[slotId].itemLink = itemLink
      elemH[slotId].icon = icon
      elemH[slotId].quality = quality
      elemH[slotId].itemStyleId = itemStyleId
      elemH[slotId].slotId = slotId
      elemH[slotId].equipType = equipType
      elemH[slotId].equipLoc = SLOT_TYPE_REV[slotId]
      --equipslot
      
      local itemType, specializedItemType = GetItemLinkItemType(itemLink)
      --Returns: number ItemType itemType, number SpecializedItemType specializedItemType 
      elemH[slotId].itemType = itemType
      elemH[slotId].specializedItemType = specializedItemType
      elemH[slotId].armorType = nil
      elemH[slotId].weaponType = nil

      if( itemType == ITEMTYPE_ARMOR ) then
        local armorType = GetItemLinkArmorType(itemLink)
        --Returns: number ArmorType armorType 
        elemH[slotId].armorType = armorType
      end
      if( itemType == ITEMTYPE_WEAPON ) then
        local weaponType = GetItemLinkWeaponType(itemLink)
        --Returns: number WeaponType weaponType 
        elemH[slotId].weaponType = weaponType
      end
    end
	end
end

--collectResearchData
function ElderScrollsOfAlts:SaveDataPlayerResearchData(tradeSkillType, keyProfName, dataResearchElem)
  dataResearchElem[keyProfName] = {}
  local researchMS       = GetMaxSimultaneousSmithingResearch(tradeSkillType)
  local researchNumlines = GetNumSmithingResearchLines(tradeSkillType)
  dataResearchElem[keyProfName].ongoing = {}
  for researchLineIndex = 1, researchNumlines do
    local name, icon, numTraits, timeRequiredForNextResearchSecs = GetSmithingResearchLineInfo(tradeSkillType, researchLineIndex)
    --
    dataResearchElem[keyProfName].numTraits = numTraits
    dataResearchElem[keyProfName].researchMS = researchMS
    dataResearchElem[keyProfName].researchNumlines = researchNumlines
    dataResearchElem[keyProfName].timeRequiredForNextResearchSecs = timeRequiredForNextResearchSecs
    --    
    for traitIndex = 1, numTraits do
      --local traitType, traitDescription, known = GetSmithingResearchLineTraitInfo(tradeSkillType, researchLineIndex, traitIndex)
      local durationSecs, timeRemainingSecs = GetSmithingResearchLineTraitTimes(tradeSkillType, researchLineIndex, traitIndex)
      if(durationSecs~=nil) then
        local traitType, traitDescription, known = GetSmithingResearchLineTraitInfo(tradeSkillType,  researchLineIndex, traitIndex)
        local timeTillReady = GetFrameTimeSeconds() + timeRemainingSecs
        dataResearchElem[keyProfName].ongoing[name] = {}
        dataResearchElem[keyProfName].ongoing[name].name              = name
        dataResearchElem[keyProfName].ongoing[name].durationSecs      = durationSecs
        dataResearchElem[keyProfName].ongoing[name].timeRemainingSecs = timeRemainingSecs
        dataResearchElem[keyProfName].ongoing[name].timeTillReady     = timeTillReady
        dataResearchElem[keyProfName].ongoing[name].traitIndex        = traitIndex
        dataResearchElem[keyProfName].ongoing[name].researchLineIndex = researchLineIndex
        dataResearchElem[keyProfName].ongoing[name].traitType         = traitType
        dataResearchElem[keyProfName].ongoing[name].traitDescription  = traitDescription
        dataResearchElem[keyProfName].ongoing[name].known             = known
      end        
    end
  end    
end



--EOF

