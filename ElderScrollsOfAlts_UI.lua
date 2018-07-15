-- Setups up GUI Elements and Data

function ElderScrollsOfAlts:SetupGUI()

end

function ElderScrollsOfAlts.loadPlayerData(self)
	local pName = GetUnitName("player")
	if ElderScrollsOfAlts.altData.players == nil then
		ElderScrollsOfAlts.altData.players = {}
	end
	ElderScrollsOfAlts.altData.players[pName] = {}

	if ElderScrollsOfAlts.altData.players[pName].bio == nil then
		ElderScrollsOfAlts.altData.players[pName].bio = {}
	end

	--GetCharacterInfo(number index)  What is index?
	--Returns: string name, number Gender gender, number level, number classId, number raceId, number Alliance alliance, string id, number locationId
	local pGender = GetUnitGender("player")
	ElderScrollsOfAlts.altData.players[pName].bio.gender = pGender
	local pLvl = GetUnitLevel("player")
	ElderScrollsOfAlts.altData.players[pName].bio.level = pLvl
  local canChampPts = CanUnitGainChampionPoints("player")
  if canChampPts then
    ElderScrollsOfAlts.altData.players[pName].bio.CanChampPts = canChampPts  
  end  
  
	local pRace = GetUnitRace("player")
	ElderScrollsOfAlts.altData.players[pName].bio.race = pRace
	--GetUnitRaceId(string unitTag)
	local pClass = GetUnitClass("player")
	ElderScrollsOfAlts.altData.players[pName].bio.class = pClass
	local pClassId = GetUnitClassId("player")
	ElderScrollsOfAlts.altData.players[pName].bio.classId = pClassId
   
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

function ElderScrollsOfAlts:matchStringList(str,itemlist)
  for _, v in ipairs(itemlist) do
      if v == str then
          return true
      end
  end
  return false;
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

-- dropdown
function ElderScrollsOfAlts:GuiSetupDropdown(dropdown)
	--local selectedItem = ElderScrollsOfAlts:GetInventoryListFilter()
	--dropdown.comboBox:SetSelectedItem(selectedItem)
end


function ElderScrollsOfAlts.AnimateText()
    -- Avoid playing the animation over itself.
    if not ESOA_GUI:IsHidden() then return end

    --ElderScrollsOfAlts.inCombat = IsUnitInCombat("player")
    --if ElderScrollsOfAlts.inCombat then return end

    local animation, timeline = CreateSimpleAnimation(ANIMATION_ALPHA, ESOA_GUI)

    ESOA_GUI:SetHidden(false)
    animation:SetAlphaValues(ESOA_GUI:GetAlpha(), 1)
    animation:SetDuration(3000)

    -- Fade-out after fade-in.
    timeline:SetHandler('OnStop', function()
        local animation, timeline = CreateSimpleAnimation(ANIMATION_ALPHA, ESOA_GUI)

        animation:SetAlphaValues(ESOA_GUI:GetAlpha(), 0)
        animation:SetDuration(3000)

        timeline:SetHandler('OnStop', function()
            ESOA_GUI:SetHidden(true)
        end)

        timeline:PlayFromStart()
    end)

    timeline:PlayFromStart()
end

function ElderScrollsOfAlts.OnIndicatorMoveStop()
  ElderScrollsOfAlts.savedVariables.left = ESOA_GUI:GetLeft()
  ElderScrollsOfAlts.savedVariables.top  = ESOA_GUI:GetTop()
  --d(ElderScrollsOfAlts.name .. "MainWindow left " .. ElderScrollsOfAlts.savedVariables.left ) -- Prints to chat.
  --d(ElderScrollsOfAlts.name .. "MainWindow top "  .. ElderScrollsOfAlts.savedVariables.top ) -- Prints to chat.
end


function ElderScrollsOfAlts:RestorePosition()
  if savedVariables == nil then end
  local left = self.savedVariables.left
  local top  = self.savedVariables.top

  if left == nil then

  end
  if top == nil then

  end

  ESOA_GUI:ClearAnchors()
  ESOA_GUI:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

-- Wraps text with a color.
function ElderScrollsOfAlts.Colorize(text, color)
    -- Default to addon's .color.
    if not color then color = ElderScrollsOfAlts.color end
    text = "|c" .. color .. text .. "|r"
    return text
end

function ElderScrollsOfAlts:TryShowMainWindow()
	ElderScrollsOfAlts.debugMsg("TryShowMainWindow called") -- Prints to chat.
	--check combat
	if not IsUnitInCombat("player") then
		--todo check if updates needed
		ElderScrollsOfAlts.debugMsg("MainWindow showing") -- Prints to chat.
		--ESOA_GUI:SetHidden(false)
		--ElderScrollsOfAlts.CreateScene()
		--ElderScrollsOfAlts.CreateMenu()
	end
end

local serverSortKeys =
  {
    ["name"]          = { }, 
    ["class"]         =  { tiebreaker = "name" },    
    ["level"]         = { tiebreaker = "name", isNumeric = true },    
    ["gender"]        = { tiebreaker = "name" },    
    ["race"]          = { tiebreaker = "name" },    
    ["alchemy"]       = { tiebreaker = "name", isNumeric = true },    
    ["blacksmithing"] = { tiebreaker = "name", isNumeric = true },    
    ["clothing"]      = { tiebreaker = "name", isNumeric = true },    
    ["enchanting"]    = { tiebreaker = "name", isNumeric = true },    
    ["provisioning"]  = { tiebreaker = "name", isNumeric = true },    
    ["jewelry"]       = { tiebreaker = "name", isNumeric = true },    
    ["woodworking"]   = { tiebreaker = "name", isNumeric = true },    
  }
local currentSortKey = "name"
local currentSortOrder = ZO_SORT_ORDER_UP --ZO_SORT_ORDER_DOWN
  
local function SortServers(a, b)
  return ZO_TableOrderingFunction( a.data, b.data, currentSortKey, serverSortKeys, currentSortOrder)
end

--
function ElderScrollsOfAlts:GuiSortBase(newKey)
  local sameKey = false
  if currentSortKey == newKey then
    sameKey = true
  end
  
  if sameKey then
    if currentSortOrder == ZO_SORT_ORDER_UP then 
      currentSortOrder = ZO_SORT_ORDER_DOWN 
    else
        currentSortOrder = ZO_SORT_ORDER_UP
    end
  else
    currentSortKey = newKey
    currentSortOrder = ZO_SORT_ORDER_UP
  end
  
  local scroll_data = ZO_ScrollList_GetDataList(ESOA_GUI_PAGE1_List)  
  local dataLines   = table.sort( scroll_data,  SortServers )   
  ZO_ScrollList_Commit(ESOA_GUI_PAGE1_List, dataLines)
  --ElderScrollsOfAlts:RefreshInventoryScroll()
end

function ElderScrollsOfAlts:GuiSort(keyname)
  ElderScrollsOfAlts:GuiSortBase(keyname)
end

function ElderScrollsOfAlts:RefreshInventoryScroll()
	ElderScrollsOfAlts:UpdateScrollDataLinesData()
	ElderScrollsOfAlts:UpdateInventoryScroll()
	-- even if the counts aren't visible, update them so they show properly if user turns them on
	--IIFA_GUI_ListHolder_Counts_Items:SetText("Item Count: " .. totItems)
	--IIFA_GUI_ListHolder_Counts_Slots:SetText("Appx. Slots Used: " .. #dataLines)
end

-- fill the shown item list with items that match current filter(s)
function ElderScrollsOfAlts:UpdateScrollDataLinesData()
  --ElderScrollsOfAlts:sort(ESOA_GUI_PAGE1_List.dataLines)
end

function ElderScrollsOfAlts:UpdateInventoryScroll()
  --
end

