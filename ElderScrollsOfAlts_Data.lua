-- Uses GUI Elements and Data
--

-- Read all data from the game Player Object into this Addon
function ElderScrollsOfAlts.loadPlayerData(self)
	local pName = GetUnitName("player")
	if ElderScrollsOfAlts.altData.players == nil then
		ElderScrollsOfAlts.altData.players = {}
	end
	ElderScrollsOfAlts.altData.players[pName] = {}

  -- BIO section
	if ElderScrollsOfAlts.altData.players[pName].bio == nil then
		ElderScrollsOfAlts.altData.players[pName].bio = {}
	end
	
	local pGender = GetUnitGender("player")
	ElderScrollsOfAlts.altData.players[pName].bio.gender = pGender
	local pLvl = GetUnitLevel("player")
	ElderScrollsOfAlts.altData.players[pName].bio.level = pLvl
  local canChampPts = CanUnitGainChampionPoints("player")
  ElderScrollsOfAlts.altData.players[pName].bio.CanChampPts = canChampPts  
  if canChampPts then
    ElderScrollsOfAlts.altData.players[pName].bio.level    = GetUnitEffectiveLevel("player") 
    ElderScrollsOfAlts.altData.players[pName].bio.champion = GetUnitChampionPoints("player")   
  end  
	local pRace = GetUnitRace("player")
	ElderScrollsOfAlts.altData.players[pName].bio.race = pRace
	--GetUnitRaceId(string unitTag)
	local pClass = GetUnitClass("player")
	ElderScrollsOfAlts.altData.players[pName].bio.class = pClass
	local pClassId = GetUnitClassId("player")
	ElderScrollsOfAlts.altData.players[pName].bio.classId = pClassId
  local pAlliance = GetUnitAlliance("player")
  ElderScrollsOfAlts.altData.players[pName].bio.alliance = pAlliance

	--local value = GetPlayerStat(self.statType, STAT_BONUS_OPTION_APPLY_BONUS)
	if ElderScrollsOfAlts.altData.players[pName].stats == nil then
		ElderScrollsOfAlts.altData.players[pName].stats = {}
	end
  --Werewolf or Vampire
  ElderScrollsOfAlts.altData.players[pName].bio.Werewolf = false
  ElderScrollsOfAlts.altData.players[pName].bio.Vampire  = false

	local current, max, effectiveMax = GetUnitPower("player", POWERTYPE_STAMINA)
	ElderScrollsOfAlts.altData.players[pName].stats["stamina"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_HEALTH)
	ElderScrollsOfAlts.altData.players[pName].stats["health"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_MAGICKA)
	ElderScrollsOfAlts.altData.players[pName].stats["magicka"] = max
	current, max, effectiveMax = GetUnitPower("player", POWERTYPE_POWER)
	ElderScrollsOfAlts.altData.players[pName].stats["power"] = max
	--POWERTYPE_WEREWOLF
	--POWERTYPE_FERVOR
	--POWERTYPE_COMBO
	--POWERTYPE_CHARGES
	--POWERTYPE_MOUNT_STAMINA

	--ABILITIES/SKILLS
	if ElderScrollsOfAlts.altData.players[pName].skills == nil then
		ElderScrollsOfAlts.altData.players[pName].skills = {}
	end

	--
  local skillType = SKILL_TYPE_ARMOR
	ElderScrollsOfAlts.altData.players[pName].skills.armor = {}
	ElderScrollsOfAlts.altData.players[pName].skills.armor.typelist = {}
  local baseElem = ElderScrollsOfAlts.altData.players[pName].skills.armor.typelist
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
		--ElderScrollsOfAlts.loadPlayerArmorDetails(skillType,skillLineId,ii,name,pName)
	end
  
  --
  skillType = SKILL_TYPE_WORLD 
	ElderScrollsOfAlts.altData.players[pName].skills.world = {}
	ElderScrollsOfAlts.altData.players[pName].skills.world.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[pName].skills.world.typelist
  ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_CLASS 
	ElderScrollsOfAlts.altData.players[pName].skills.class = {}
	ElderScrollsOfAlts.altData.players[pName].skills.class.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[pName].skills.class.typelist
  ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_GUILD  
	ElderScrollsOfAlts.altData.players[pName].skills.guild = {}
	ElderScrollsOfAlts.altData.players[pName].skills.guild.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[pName].skills.guild.typelist
  ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_RACIAL  
	ElderScrollsOfAlts.altData.players[pName].skills.racial = {}
	ElderScrollsOfAlts.altData.players[pName].skills.racial.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[pName].skills.racial.typelist
  ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
  
  --
  skillType = SKILL_TYPE_WEAPON  
	ElderScrollsOfAlts.altData.players[pName].skills.weapon = {}
	ElderScrollsOfAlts.altData.players[pName].skills.weapon.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[pName].skills.weapon.typelist
  ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
    
  --
  skillType = SKILL_TYPE_AVA  
	ElderScrollsOfAlts.altData.players[pName].skills.ava = {}
	ElderScrollsOfAlts.altData.players[pName].skills.ava.typelist = {}
  baseElem = ElderScrollsOfAlts.altData.players[pName].skills.ava.typelist
  ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
    
  --SKILL_TYPE_NONE

	--SKILL_TYPE_TRADESKILL
	ElderScrollsOfAlts.altData.players[pName].skills.trade = {}
	local baseTableElem = ElderScrollsOfAlts.altData.players[pName].skills.trade
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
		ElderScrollsOfAlts.loadPlayerTradeDetails( name, baseTableElem, selElemTable, skillType, ii, numAbilities ) --skillLineId,ii,name,baseTableElem,pName)
	end

  --Check Specific Skilllines
  --ElderScrollsOfAlts.altData.players[pName].skills.world.typelist = {}
  --Werewolf or Vampire
  for key,value in pairs(ElderScrollsOfAlts.altData.players[pName].skills.world.typelist) do
    --print(key,value)
    if key == "Werewolf" then
      ElderScrollsOfAlts.altData.players[pName].bio.Werewolf = true
    elseif key == "Vampire" then
      ElderScrollsOfAlts.altData.players[pName].bio.Vampire = true
    end
  end  
  --
  local bagSize = GetBagSize(BAG_BACKPACK) 
  local bagUsed = GetNumBagUsedSlots(BAG_BACKPACK)
  ElderScrollsOfAlts.altData.players[pName].misc = {}
  ElderScrollsOfAlts.altData.players[pName].misc.backpackSize = bagSize
  ElderScrollsOfAlts.altData.players[pName].misc.backpackUsed = bagUsed
  --
  ElderScrollsOfAlts:loadPlayerEquipment()
  
	-- Fetch the saved variables
  --Default values for the SavedVariables
  local defaults = {
      pName      = pName,
      fillUpAmount    = 0,
  }
	--local db = ZO_SavedVars:NewAccountWide("altsdata", SV_VERSION_NAME, nil, defaults)
	--ElderScrollsOfAlts.altData
end

--Solvent Proficiency, Metalworking, Tailoring, (Aspect Improvement, Potency Improvement), Recipe Quality, Recipe Improvement, Woodworking
local matchNameList = {"Solvent Proficiency", "Metalworking", "Tailoring", "Aspect Improvement", "Potency Improvement", "Recipe Quality", "Recipe Improvement", "Woodworking" }

--
function ElderScrollsOfAlts.loadPlayerTradeDetails(parentName, parentTableElem, tradeTableElem, skillType, ii, numAbilities )
    --Find Abilities - search for main - Levelled one, ie: use iron/maple/greenrunes
    parentTableElem.skills[parentName]	= {}
    local selElemSubTable = parentTableElem.skills[parentName]
    local skillIndex = ii
    selElemSubTable.sunk    = 0
    selElemSubTable.sinkmax = 0
    for aj = 1, numAbilities do
        local name, icon, earnedRank, passive, ultimate, purchased, progressionIndex = GetSkillAbilityInfo(skillType, ii, aj)
        --ElderScrollsOfAlts:debugMsg("TradeSkill Ability: name="..name.. " purchased="..tostring(purchased))
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
        --ElderScrollsOfAlts:debugMsg("TradeSkill Ability: passive="..tostring(passive))
        if purchased then          
          selElemSubTable[plainName] = {}
          local selL = selElemSubTable[plainName]
          selL.plainName = plainName
          selL.name = name
          selL.earnedRank = earnedRank
          selL.currentUpgradeLevel = currentUpgradeLevel
          selL.maxUpgradeLevel = maxUpgradeLevel
          selL.nextUpgradeEarnedRank = nextUpgradeEarnedRank
          local match = ElderScrollsOfAlts:matchStringList(plainName,matchNameList)
          if match then
            selElemSubTable.sunk    = selElemSubTable.sunk    + currentUpgradeLevel - 1
            selElemSubTable.sinkmax = selElemSubTable.sinkmax + maxUpgradeLevel - 1
            tradeTableElem.sunk     = selElemSubTable.sunk
            tradeTableElem.sinkmax  = selElemSubTable.sinkmax
          end
        end
    end
end

function ElderScrollsOfAlts:loadPlayerDataPart(skillType,baseElem)
  if skillType == nil then
      ElderScrollsOfAlts:debugMsg("loadPlayerDataPart: skillType is NIL")
      return
  end
  --ElderScrollsOfAlts:debugMsg("loadPlayerDataPart: skillType="..skillType..".")
	local numSkillLines = GetNumSkillLines(skillType)
  for ii = 1, numSkillLines do
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType,ii)
		--name, number rank, boolean discovered, number skillLineId, boolean advised, unlockText
		if name == nil then
			name = ii;
		end
    if discovered then
      --ElderScrollsOfAlts:debugMsg("loadPlayerDataPart: unlockText="..unlockText..".")
      baseElem[name]	= {}
      local baseElemTable = baseElem[name]
      local numAbilities = GetNumSkillAbilities(skillType, ii)
      baseElemTable.name = name
      baseElemTable.idx = ii
      baseElemTable.numAbilities = numAbilities
      baseElemTable.rank = rank
      baseElemTable.skillLineId = skillLineId
      --ElderScrollsOfAlts.loadPlayerDataPartDetails(skillType,skillLineId,ii,name,pName)
    else 
      --d("loadPlayerDataPart: skillType="..skillType..". name=" ..name)
    end      
	end
end

--
function ElderScrollsOfAlts:ListOfPlayers()
  --for k, v in pairs(ElderScrollsOfAlts.altData.players) do
    --d(ElderScrollsOfAlts.name .. " k " .. k)
   -- table.insert(validChoices, ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k ))
  --end
  --[[
  for k, v in pairs(ElderScrollsOfAlts.altData.players) do
     if k == nil then return end
     d(" players " .. k)
  end
  ]]
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  if ElderScrollsOfAlts.altData.player ~= nil then
    for k, v in pairs(ElderScrollsOfAlts.altData.players) do
      --d(ElderScrollsOfAlts.name .. " k " .. k)
      table.insert(validChoices, ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k ))
    end
  end
  return validChoices
  --return ElderScrollsOfAlts.altData.players    
end

--
function ElderScrollsOfAlts:SetupGuiPlayerLines()
	local playerLines =  {}
	--table.insert(playerLines, "Select")
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
    if k == nil then return end
		ElderScrollsOfAlts.debugMsg(" players " .. k)
		playerLines[k] = {}
		playerLines[k].name = ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k )
    playerLines[k].rawname = k
		local bio = ElderScrollsOfAlts.altData.players[k].bio
		if bio ~=nil then
			playerLines[k].gender   = bio.gender
      playerLines[k].level    = bio.level
			playerLines[k].race     = bio.race
      playerLines[k].class    = bio.class
      playerLines[k].alliance = bio.alliance
      playerLines[k].super    = 0
      if bio.Werewolf then
        playerLines[k].Werewolf = true
        playerLines[k].super    = 1
      end
      if bio.Vampire then
        playerLines[k].Vampire = true
        playerLines[k].super    = 2
      end
    else 
      playerLines[k].gender = -1
			playerLines[k].level = -1
			playerLines[k].race = "Unk"
      playerLines[k].class = "Unk"
      playerLines[k].Werewolf = false
      playerLines[k].Vampire = false
      playerLines[k].super    = 0
		end
    if playerLines[k].level == nil or playerLines[k].level < 1 then
      ElderScrollsOfAlts.altData.players[k]  = nil
      return
    end
    --
    if bio.CanChampPts then
      playerLines[k].champion = bio.champion
    else 
      playerLines[k].champion = nil
    end

    -- MISC
    local misc = ElderScrollsOfAlts.altData.players[k].misc
    if misc ~=nil then
      playerLines[k].backpackSize = misc.backpackSize
      playerLines[k].backpackUsed = misc.backpackUsed
    else
      playerLines[k].backpackSize = 0
      playerLines[k].backpackUsed = 0
    end
    --
    local trade = ElderScrollsOfAlts.altData.players[k].skills.trade
    if trade ~=nil then
      local tradeL = ElderScrollsOfAlts.altData.players[k].skills.trade.typelist    
      if trade ~=nil then
        local alchemy  = tradeL["Alchemy"]
        if alchemy ~=nil then
          playerLines[k].alchemy         = alchemy.rank
          playerLines[k].alchemy_sunk    = alchemy.sunk
          playerLines[k].alchemy_sinkmax = alchemy.sinkmax
        else
          playerLines[k].alchemy = 0
          playerLines[k].alchemy_sunk    = 0
          playerLines[k].alchemy_sinkmax = 0          
        end
        local blacksmithing = tradeL["Blacksmithing"] 
        if blacksmithing ~=nil then
          playerLines[k].blacksmithing = blacksmithing.rank   
          playerLines[k].blacksmithing_sunk    = blacksmithing.sunk
          playerLines[k].blacksmithing_sinkmax = blacksmithing.sinkmax
        else
          playerLines[k].blacksmithing = 0
          playerLines[k].blacksmithing_sunk    = 0
          playerLines[k].blacksmithing_sinkmax = 0   
        end
        local clothing = tradeL["Clothing"] 
        if clothing ~=nil then
          playerLines[k].clothing = clothing.rank   
          playerLines[k].clothing_sunk    = clothing.sunk
          playerLines[k].clothing_sinkmax = clothing.sinkmax
        else
           playerLines[k].clothing = 0
          playerLines[k].clothing_sunk    = 0
          playerLines[k].clothing_sinkmax = 0   
        end
        local enchanting = tradeL["Enchanting"] 
        if enchanting ~=nil then
          playerLines[k].enchanting = enchanting.rank 
          playerLines[k].enchanting_sunk    = enchanting.sunk
          playerLines[k].enchanting_sinkmax = enchanting.sinkmax
        else
          playerLines[k].enchanting = 0
          playerLines[k].enchanting_sunk    = 0
          playerLines[k].enchanting_sinkmax = 0             
        end         
        local jewelry = tradeL["Jewelry Crafting"] 
        if jewelry ~=nil then
          playerLines[k].jewelry = jewelry.rank   
          playerLines[k].jewelry_sunk    = jewelry.sunk
          playerLines[k].jewelry_sinkmax = jewelry.sinkmax
        else
          playerLines[k].jewelry = 0
          playerLines[k].jewelry_sunk    = 0
          playerLines[k].jewelry_sinkmax = 0 
        end          
        local provisioning = tradeL["Provisioning"]          
        if provisioning ~=nil then
          playerLines[k].provisioning = provisioning.rank   
          playerLines[k].provisioning_sunk    = provisioning.sunk
          playerLines[k].provisioning_sinkmax = provisioning.sinkmax
        else
          playerLines[k].provisioning = 0
          playerLines[k].provisioning_sunk    = 0
          playerLines[k].provisioning_sinkmax = 0              
         end              
         local woodworking = tradeL["Woodworking"] 
         if woodworking ~=nil then
          playerLines[k].woodworking = woodworking.rank   
          playerLines[k].woodworking_sunk    = woodworking.sunk
          playerLines[k].woodworking_sinkmax = woodworking.sinkmax
         else
          playerLines[k].woodworking = 0
          playerLines[k].woodworking_sunk    = 0
          playerLines[k].woodworking_sinkmax = 0              
         end
        end
    else
      --
    end
  end

  -- PlayerLines to table
  table.sort(playerLines)  
  return playerLines
end

local SLOT_TYPE= {
  ["HEAD"]  = EQUIP_SLOT_HEAD,
  ["NECK"]  = EQUIP_SLOT_NECK,
  ["SHOULDERS"] = EQUIP_SLOT_SHOULDERS,  
  ["CHEST"] = EQUIP_SLOT_CHEST,
  ["WAIST"] = EQUIP_SLOT_WAIST,
  ["WRIST"] = EQUIP_SLOT_WRIST,  
  ["FEET"]  = EQUIP_SLOT_FEET,
  ["HAND"]  = EQUIP_SLOT_HAND,
  ["LEGS"]  = EQUIP_SLOT_LEGS,
  
  ["WRIST"] = EQUIP_SLOT_BACKUP_MAIN,
  ["WRIST"] = EQUIP_SLOT_BACKUP_OFF,
  ["WRIST"] = EQUIP_SLOT_BACKUP_POISON,
  ["OFF_HAND"] = EQUIP_SLOT_OFF_HAND,
  ["POISON"] = EQUIP_SLOT_POISON,
  ["MAIN_HAND"] = EQUIP_SLOT_MAIN_HAND,
  ["RANGED"] = EQUIP_SLOT_RANGED, 
  
  ["CLASS1"] = EQUIP_SLOT_CLASS1,
  ["CLASS2"] = EQUIP_SLOT_CLASS2,
  ["CLASS3"] = EQUIP_SLOT_CLASS3,
  ["COSTUME"] = EQUIP_SLOT_COSTUME,
  
  ["RING1"] = EQUIP_SLOT_RING1,
  ["RING2"] = EQUIP_SLOT_RING2,
  
  ["NONE"] = EQUIP_SLOT_NONE,  
}

--
function ElderScrollsOfAlts:loadPlayerEquipment()
  local pName = GetUnitName("player")
  ElderScrollsOfAlts.altData.players[pName].items = {}
  ElderScrollsOfAlts.altData.players[pName].equip = {}
  
  local slotIndex = ZO_GetNextBagSlotIndex(BAG_WORN)
  while slotIndex do
    --self:AddInventoryItem(inventoryType, slotIndex)
    local link = GetItemLink(BAG_WORN, slotIndex)--,LINK_STYLE_BRACKETS)--, number LinkStyle linkStyle)
    if link ~= nil then
      --d("itemlink= ".. link)
    end
    --GetItemId: id = tonumber((tostring(itemLink):match("|H%d:item:(%d+)") or -1)
    slotIndex = ZO_GetNextBagSlotIndex(BAG_WORN, slotIndex)
  end
  
  --str icon, bool slotHasItem, num sellPrice, bool isHeldSlot, bool isHeldNow, bool locked
  local icon, slotHasItem, sellPrice, isHeldSlot, isHeldNow, locked = GetEquippedItemInfo(EQUIP_SLOT_BACKUP_MAIN)  
  --TODO not like this
  ElderScrollsOfAlts.altData.players[pName].equip.backupmain = {}
  ElderScrollsOfAlts.altData.players[pName].equip.backupmain.icon = icon
  
  ElderScrollsOfAlts.altData.players[pName].equip.slots = {}
  local elemH = ElderScrollsOfAlts.altData.players[pName].equip.slots
  for slotId = 0, GetBagSize(BAG_WORN) do    
  	local itemName = GetItemName(BAG_WORN, slotId)
    local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyleId, quality = GetItemInfo(BAG_WORN, slotId)
    local itemId = GetItemInstanceId(BAG_WORN, slotId)
    elemH[slotId] = {}
    elemH[slotId].itemId = itemId
    elemH[slotId].itemName = itemName
    elemH[slotId].icon = icon
    elemH[slotId].equipType = equipType
    
	end
      
  --number:nilable id = GetItemInstanceId(number Bag bagId, number slotIndex)
  --GetItemLinkInfo(string itemLink)
  --Returns: string icon, num sellPrice, bool meetsUsageRequirement, num EquipType equipType, num itemStyleId 
  --GetBagSize(number Bag bagId) 
  --local pName = GetUnitName("player")
  --str icon, bool slotHasItem, num sellPrice, bool isHeldSlot, bool isHeldNow, bool locked = 
  --  GetEquippedItemInfo(num EquipSlot equipSlot)
  --local icon, slotHasItem, sellPrice, isHeldSlot, isHeldNow, locked = 
  --  GetEquippedItemInfo(EQUIP_SLOT_BACKUP_MAIN)
  --textureName icon, num stack, num sellPrice, boolean meetsUsageRequirement, bool locked, num EquipType equipType, num itemStyleId, num ItemQuality quality   
  --local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyleId, ItemQuality quality = 
  --  GetItemInfo(BAG_WORN, slotIndex)
  --local itemId = GetItemId(BAG_WORN, slotIndex) 
  --boolean hasItemInSlot = HasItemInSlot(number Bag bagId, number slotIndex)
  --local string link = GetItemLink(number Bag bagId, number slotIndex, number LinkStyle linkStyle)

  --d("eq: ")
  --[[
  EQUIP_SLOT_BACKUP_OFF
    EQUIP_SLOT_BACKUP_POISON
    EQUIP_SLOT_CHEST
    EQUIP_SLOT_CLASS1
    EQUIP_SLOT_CLASS2
    EQUIP_SLOT_CLASS3
    EQUIP_SLOT_COSTUME
    EQUIP_SLOT_FEET
    EQUIP_SLOT_HAND
    EQUIP_SLOT_HEAD
    EQUIP_SLOT_LEGS
    EQUIP_SLOT_MAIN_HAND
    EQUIP_SLOT_NECK
    EQUIP_SLOT_NONE
    EQUIP_SLOT_OFF_HAND
    EQUIP_SLOT_POISON
    EQUIP_SLOT_RANGED
    EQUIP_SLOT_RING1
    EQUIP_SLOT_RING2
    EQUIP_SLOT_SHOULDERS
    EQUIP_SLOT_WAIST
    EQUIP_SLOT_WRIST 
    ]]
end

