--ESOA Charts -- data lookups

-----------
-- VIEWS --

ElderScrollsOfAlts.allowedViewEntries = {
  ["Note"] = 1, 
  ["Special"] = 1, 
  ["Alliance"] = 1, 
  ["Class"] = 1, 
  ["Level"] = 1, 
  ["Gender"] = 1, 
  ["Race"] = 1, 
  ["Alchemy"] = 1, 
  ["Smithing"] = 1, 
  ["Clothing"] = 1, 
  ["Enchanting"] = 1, 
  ["Jewelry"] = 1, 
  ["Provisioning"] = 1, 
  ["Woodworking"] = 1,         
  ["BagSpace"] = 1,         
  ["BagSpaceFree"] = 1,         
  ["Skillpoints"] = 1, 
  ["Head"] = 1, 
  ["Shoulders"] = 1, 
  ["Chest"] = 1, 
  ["Hands"] = 1, 
  ["Waist"] = 1, 
  ["Legs"] = 1, 
  ["Feet"] = 1, 
  ["Neck"] = 1, 
  ["Ring1"] = 1, 
  ["Ring2"] = 1, 
  ["M1"] = 1, 
  ["M2"] = 1, 
  ["Mp"] = 1, 
  ["O1"] = 1, 
  ["O2"] = 1, 
  ["Op"] = 1, 
  ["Heavy"] = 1, 
  ["Medium"] = 1, 
  ["Light"] = 1, 
  
  ["Clothier Research 1"] = 1, 
  ["Clothier Research 2"] = 1, 
  ["Clothier Research 3"] = 1, 
  ["Blacksmithing Research 1"] = 1, 
  ["Blacksmithing Research 2"] = 1, 
  ["Blacksmithing Research 3"] = 1, 
  ["Woodworking Research 1"] = 1, 
  ["Woodworking Research 2"] = 1, 
  ["Woodworking Research 3"] = 1, 
  ["Jewelcrafting Research 1"] = 1, 
  ["Jewelcrafting Research 2"] = 1, 
  ["Jewelcrafting Research 3"] = 1, 

  ["Assault"] = 1, 
  ["Support"] = 1, 
  ["Legerdemain"] = 1, 
  ["Soul Magic"] = 1, 
  ["Werewolf"] = 1, 
  ["Vampire"] = 1, 
  ["Fighters Guild"] = 1, 
  ["Mages Guild"] = 1, 
  ["Undaunted"] = 1, 
  ["Thieves Guild"] = 1, 
  ["Dark Brotherhood"] = 1, 
  ["Psijic Order"] = 1, 
  
  ["Riding Speed"] = 1, 
  ["Riding Stamina"] = 1, 
  ["Riding Inventory"] = 1, 
  ["Riding Timer"] = 1, 
  
  ["SpecialBiteTimer"] = 1, 
  ["SecondsPlayed"] = 1, 
  ["TimePlayed"] = 1, 
  
  ["Alliance Name"] = 1,
  ["InCampaign"] = 1,
  ["GuestCampaignId"] = 1,
  ["HomeCampaignId"] = 1,
  ["AssignedCampaignId"] = 1,
  
  ["HomeCampaignName"] = 1,
  ["GuestCampaignName"] = 1,
  ["AssignedCampaignName"] = 1,
  
  ["IsInCampaign"] = 1,  
  ["UnitAlliance"] = 1,
  ["AllianceName"] = 1,
  ["UnitAvARank"] = 1,
  ["UnitAvARankPoints"] = 1,
  ["SubRankStartsAt"] = 1,
  ["NextSubRankAt"] = 1,
  ["RankStartsAt"] = 1,
  ["NextRankAt"] = 1,
  ["AvaRankName"] = 1,
  ["HomeCampaignRewardEarnedTier"] = 1,
  ["GuestCampaignRewardEarnedTier"] = 1,
}

ElderScrollsOfAlts.view.guiTemplates = {  
  ["Home"] = {
    ["name"] = "Home",
    ["view"] = {
      [1] = "Note",
      [2] = "Special",
      [3] = "Alliance",
      [4] = "Class",
      [5] = "Level",
      [6] = "Gender",
      [7] = "Race",
      [8] = "Alchemy",
      [9] = "Smithing",
      [10] = "Clothing",
      [11] = "Enchanting",
      [12] = "Jewelry",
      [13] = "Provisioning",
      [14] = "Woodworking",        
      [15] = "BagSpace",        
      [16] = "BagSpaceFree",        
      [17] = "Skillpoints",
    }
  },
  ["Equip"] = {
    ["name"] = "Equip",
    ["view"] = {
      [1] = "Head",
      [2] = "Shoulders",
      [3] = "Chest",
      [4] = "Hands",
      [5] = "Waist",
      [6] = "Legs",
      [7] = "Feet",
      [8] = "Neck",
      [9] = "Ring1",
      [10] = "Ring2",
      [11] = "M1",
      [12] = "M2",
      [13] = "Mp",
      [14] = "O1",
      [15] = "O2",
      [16] = "Op",
      [17] = "Heavy",
      [18] = "Medium",
      [19] = "Light",
    }
  },
  ["Research"] = {
    ["name"] = "Research",
    ["view"] = {
      [1] = "Clothier Research 1",
      [2] = "Clothier Research 2",
      [3] = "Clothier Research 3",
      [4] = "Blacksmithing Research 1",
      [5] = "Blacksmithing Research 2",
      [6] = "Blacksmithing Research 3",
      [7] = "Woodworking Research 1",
      [8] = "Woodworking Research 2",
      [9] = "Woodworking Research 3",
      [10] = "Jewelcrafting Research 1",
      [11] = "Jewelcrafting Research 2",
      [12] = "Jewelcrafting Research 3",
    }
  },
  ["Skills"] = {
    ["name"] = "Skills",
    ["view"] = {
      [1] = "Assault",
      [2] = "Support",
      [3] = "Legerdemain",
      [4] = "Soul Magic",
      [5] = "Werewolf",
      [6] = "Vampire",
      [7] = "Fighters Guild",
      [8] = "Mages Guild",
      [9] = "Undaunted",
      [10] = "Thieves Guild",
      [11] = "Dark Brotherhood",
      [12] = "Psijic Order",
      
      [13] = "Riding Speed",
      [14] = "Riding Stamina",
      [15] = "Riding Inventory",
      [16] = "Riding Timer",
    }
  },
}

-- VIEWS --
-----------

-----------
-- DISPLAY -- 
function ElderScrollsOfAlts:GetCraftSunkText(craftName,sunkVal)
  if(craftName=="JC" or craftName=="Jewelry" )then
    if(sunkVal == 0) then
      return "Allows the use of |c00FFFFPewter|r Ounces."
    elseif(sunkVal == 1) then
      return"Allows the use of |c00FFFFCopper|r Ounces."
    elseif(sunkVal == 2) then
      return "Allows the use of |c00FFFFSilver|r Ounces. (Create gear up to CP |c00FFFF80|r)."
    elseif(sunkVal == 3) then
      return "Allows the use of |c00FFFFElectrum|r Ounces. (Create gear up to CP |c00FFFF140|r)."
    elseif(sunkVal == 4) then
      return "Allows the use of |c00FFFFPlatinum|r Ounces."
    end
  elseif(craftName=="Smithing")then
    if(sunkVal == 0) then
      return "Allows the use of |c00FFFFIron|r Ingots (Create gear up to Lvl |c00FFFF14|r)."
    elseif(sunkVal == 1) then
      return "Allows the use of |c00FFFFSteel|r Ingots (Create gear up to Lvl |c00FFFF24|r)."
    elseif(sunkVal == 2) then
      return "Allows the use of |c00FFFFOrichalc|r Ingots (Create gear up to Lvl |c00FFFF34|r)."
    elseif(sunkVal == 3) then
      return "Allows the use of |c00FFFFDwarven|r Ingots (Create gear up to Lvl |c00FFFF44|r)."
    elseif(sunkVal == 4) then
      return "Allows the use of |c00FFFFEbony|r Ingots (Create gear up to Lvl |c00FFFF50|r)."
    elseif(sunkVal == 5) then
      return "Allows the use of |c00FFFFCalcinium|r Ingots (Create gear up to CP |c00FFFF30|r)."
    elseif(sunkVal == 6) then
      return "Allows the use of |c00FFFFGalatite|r Ingots (Create gear up to CP |c00FFFF60|r)."
    elseif(sunkVal == 7) then
      return "Allows the use of |c00FFFFQuicksilver|r Ingots (Create gear up to CP |c00FFFF80|r)."
    elseif(sunkVal == 8) then
      return "Allows the use of |c00FFFFVoidstone|r Ingots (Create gear up to CP |c00FFFF140|r)."
    elseif(sunkVal == 9) then  
      return "Allows the use of |c00FFFFRubedite|r Ingots (Create gear up to CP |c00FFFF160|r)."
    end
  elseif(craftName=="Alchemy")then
    if(sunkVal == 0) then  
      return "Allows the use of |c00FFFFNatural Water and Grease, Clear Water and Ichor|r (Makes a level |c00FFFF3 or 10|r concoction)."
    elseif(sunkVal == 1) then  
      return "Allows the use of |c00FFFFPristine Water and Slime|r (Makes a level |c00FFFF20|r concoction)."
    elseif(sunkVal == 2) then  
      return "Allows the use of |c00FFFFCleansed Water and Gall|r (Makes a level |c00FFFF30|r concoction)."
    elseif(sunkVal == 3) then  
      return "Allows the use of |c00FFFFFiltered Water and Terebinthine|r (Makes a level |c00FFFF40|r concoction)."
    elseif(sunkVal == 4) then  
      return "Allows the use of |c00FFFFPurified Water to Pitch-Blie|r (Makes a level |c00FFFFCP10|r concoction)."
    elseif(sunkVal == 5) then  
      return "Allows the use of |c00FFFFCloud Mist and Tarblack|r (Makes a level |c00FFFFCP50|r concoction)."
    elseif(sunkVal == 6) then  
      return "Allows the use of |c00FFFFStar Dew and Night-Oil|r (Makes a level |c00FFFFCP100|r concoction)."
    elseif(sunkVal == 7) then  
     return "Allows the use of |c00FFFFLorkhan's Tears and Alkhest|r (Makes a level |c00FFFFCP150|r concoction)."
    end
  elseif(craftName=="Enchanting")then
    if(sunkVal == 0) then
      return "Allows the use of Common(|c00FFFFwhite|r) and Standard(green) Aspect Runestones."
    elseif(sunkVal == 1) then
      return "Allows the use of Superior(|c00FFFFblue|r) Aspect Runestones."
    elseif(sunkVal == 2) then
      return "Allows the use of Artifact (|cFF00FFpurple|r) Aspect Runestones."
    elseif(sunkVal == 3) then
      return "Allows the use of Legendary (|cFFFF00gold|r) Aspect Runestones."
    end
  elseif(craftName=="Enchanting2")then
    if(sunkVal == 0) then
      return "Allows the use of Jora, Porade, Jode and Notade Potency Runestones to make Glyphs of levels 1-15."
    elseif(sunkVal == 1) then
      return "Allows the use of Jera, Jejora, Ode and Tade Potency Runestones to make Glyphs of levels 10-25."   
    elseif(sunkVal == 2) then
      return   "Allows the use of Odra, Pojora, Jayde and Edode Potency Runestones to make Glyphs of levels 20-35."      
    elseif(sunkVal == 3) then
      return "Allows the use of Edora, Jaera, Pojode, and Rekude Potency Runestones to make Glyphs of levels 30-45."
    elseif(sunkVal == 4) then    
      return   "Allows the use of Pora, Denara, Hade and Idode Potency Runestones to make Glyphs from level 40 to Champion 30."
    elseif(sunkVal == 5) then    
      return "Allows the use of Rera and Pode Potency Runestones to make Glyphs of Champion 30-50."
    elseif(sunkVal == 6) then    
      return "Allows the use of Derado and Kedeko Potency Runestones to make Glyphs of Champion 50-70."
    elseif(sunkVal == 7) then    
      return"Allows the use of Rekura and Rede Potency Runestones to make Glyphs of Champion 70-90."
    elseif(sunkVal == 8) then   
      return "Allows the use of Kura and Kude Potency Runestones to make Glyphs of Champion 100-140."
     elseif(sunkVal == 9) then   
      return"Allows the use of Rejera, Repora, Jehade, and Itade Potency Runestones to make Glyphs of Champion 150 and 160."
    end
  elseif(craftName=="Woodworking")then
    if(sunkVal == 0) then  
      return "Allows the use of Sanded |c00FFFFMaple|r wood (Create gear up to Lvl |c00FFFF14|r)."
    elseif(sunkVal == 1) then  
      return "Allows the use of Sanded |c00FFFFOak|r wood (Create gear up to Lvl |c00FFFF24|r)."
    elseif(sunkVal == 2) then  
      return "Allows the use of Sanded |c00FFFFBeech|r wood (Create gear up to Lvl |c00FFFF34|r)."
    elseif(sunkVal == 3) then  
      return "Allows the use of Sanded |c00FFFFHickory|r wood (Create gear up to Lvl |c00FFFF44|r)."
    elseif(sunkVal == 4) then  
      return "Allows the use of Sanded |c00FFFFYew|r wood (Create gear up to Lvl |c00FFFF50|r)."
    elseif(sunkVal == 5) then  
      return "Allows the use of Sanded |c00FFFFBirch|r wood (Create gear up to CP |c00FFFF30|r)."
    elseif(sunkVal == 6) then  
      return "Allows the use of Sanded |c00FFFFAsh|r wood (Create gear up to CP |c00FFFF60|r)."
    elseif(sunkVal == 7) then  
      return "Allows the use of Sanded |c00FFFFMahogany|r wood (Create gear up to CP |c00FFFF80|r)."
    elseif(sunkVal == 8) then        
      return "Allows the use of Sanded |c00FFFFNightwood|r (Create gear up to CP |c00FFFF140|r)."
    elseif(sunkVal == 9) then        
      return "Allows the use of Sanded |c00FFFFRuby Ash|r (Create gear up to CP |c00FFFF160|r)."
    end
  elseif(craftName=="Clothing")then
    if(sunkVal == 0) then  
      return "Allows the use of |c00FFFFJute and Rawhide|r (Create gear up to Lvl |c00FFFF14|r)."
    elseif(sunkVal == 1) then  
      return "Allows the use of |c00FFFFFlax and Hide|r (Create gear up to Lvl |c00FFFF24|r)."
    elseif(sunkVal == 2) then  
      return "Allows the use of |c00FFFFCotton and Leather|r (Create gear up to Lvl |c00FFFF34|r)."
    elseif(sunkVal == 3) then  
      return "Allows the use of |c00FFFFSpidersilk and Thick Leather|r (Create gear up to Lvl |c00FFFF44|r)."
    elseif(sunkVal == 4) then  
      return "Allows the use of |c00FFFFEbonthread and Topgrain Hide|r (Create gear up to Lvl |c00FFFF50|r)."
    elseif(sunkVal == 5) then  
      return "Allows the use of |c00FFFFFamin and Fell Hide|r (Create gear up to CP |c00FFFF30|r)."
    elseif(sunkVal == 6) then  
      return "Allows the use of |c00FFFFIronthread and Iron Hide|r (Create gear up to CP |c00FFFF60|r)."
    elseif(sunkVal == 7) then  
      return "Allows the use of |c00FFFFSilverweave and Scaled Hide|r (Create gear up to CP |c00FFFF80|r)."
    elseif(sunkVal == 8) then
      return "Allows the use of |c00FFFFVoid Cloth and Daedra Hide|r (Create gear up to CP |c00FFFF140|r)."
    elseif(sunkVal == 9) then
      return "Allows the use of |c00FFFFAncestor Silk and Rubedo Leather|r (Create gear up to CP |c00FFFF160|r)."
    end
  elseif(craftName=="Provisioning")then
    if(sunkVal == 0) then  
      return "Allows the use of Standard (|c00FF00green|r) Recipies."
    elseif(sunkVal == 1) then  
      return "Allows the use of Difficult (|c00FFFFblue|r) Recipies."
    elseif(sunkVal == 2) then  
      return "Allows the use of Complex (|cFF00FFpurple|r) Recipies."
    elseif(sunkVal == 3) then  
      return "Allows the use of Legendary (|cFFFF00yellow|r) Recipies."
    end
  elseif(craftName=="Provisioning2")then
    if(sunkVal == 0) then  
      return "Allows the making of up to level |c00FFFF19|r Recipes."
    elseif(sunkVal == 1) then  
      return "Allows the making of up to level |c00FFFF29|r Recipes."
    elseif(sunkVal == 2) then  
      return "Allows the making of up to level |c00FFFF39|r Recipes."
    elseif(sunkVal == 3) then  
       return "Allows the making of up to level |c00FFFF49|r Recipes."
    elseif(sunkVal == 4) then  
      return "Allows the making of up to Champion |c00FFFF50|r Recipes."
    elseif(sunkVal == 5) then  
      return "Allows the making of up to Champion |c00FFFF150|r Recipes."
    end
  end  
  return ""
end


function ElderScrollsOfAlts:GetGenderFullText(genderId)
  local genderName = GetString(ESOA_GENDER_OTHER)
    if genderId == 0 then
      genderName = GetString(ESOA_GENDER_MALE)
    elseif genderId == 1 then
      genderName = GetString(ESOA_GENDER_FEMALE)
    end
    return genderName
end
function ElderScrollsOfAlts:GetGenderText(genderId)
  local genderName = GetString(ESOA_GENDER_OTHER_S)
    if genderId == 0 then
      genderName = GetString(ESOA_GENDER_MALE_S)
    elseif genderId == 1 then
      genderName = GetString(ESOA_GENDER_FEMALE_S)
    end
    return genderName
end

function ElderScrollsOfAlts:GetClassText(className)
  local classX = GetString(ESOA_CLASS_DEFAULT_ABBREV)
    if className == GetString(ESOA_CLASS_DRAGONKNIGHT) then
      classX = GetString(ESOA_CLASS_DRAGONKNIGHT_ABBREV)
    elseif className == GetString(ESOA_CLASS_SORCERER) then
      classX = GetString(ESOA_CLASS_SORCERER_ABBREV)
    elseif className == GetString(ESOA_CLASS_NIGHTBLADE) then
      classX = GetString(ESOA_CLASS_NIGHTBLADE_ABBREV) 
    elseif className == GetString(ESOA_CLASS_TEMPLAR) then
      classX = GetString(ESOA_CLASS_TEMPLAR_ABBREV)
    elseif className == GetString(ESOA_CLASS_WARDEN) then
      classX = GetString(ESOA_CLASS_WARDEN_ABBREV)
    elseif className == GetString(ESOA_CLASS_NECRO) then
      classX = GetString(ESOA_CLASS_NECRO_ABBREV)
    end
    return classX
end

function ElderScrollsOfAlts:GetRaceText1(raceName)
  local raceX = raceName
    if raceName == GetString(ESOA_RACE_HIGHELF) then
      raceX = GetString(ESOA_RACE_HIGHELF_ABBREV) 
    elseif raceName == GetString(ESOA_RACE_WOODELF) then
      raceX = GetString(ESOA_RACE_WOODELF_ABBREV)
    elseif raceName == GetString(ESOA_RACE_KHAJIIT) then
      raceX = GetString(ESOA_RACE_KHAJIIT_ABBREV)
    elseif raceName == GetString(ESOA_RACE_ARGONIAN) then
      raceX = GetString(ESOA_RACE_ARGONIAN_ABBREV)
    elseif raceName == GetString(ESOA_RACE_DARKELF) then
      raceX = GetString(ESOA_RACE_DARKELF_ABBREV)
    end
    return raceX
end
function ElderScrollsOfAlts:GetRaceText2(raceName)
  local raceX = GetString(ESOA_RACE_UNKNOWN)
    if raceName == GetString(ESOA_RACE_HIGHELF) then
      raceX = GetString(ESOA_RACE_HIGHELF_ABBREV2)
    elseif raceName == GetString(ESOA_RACE_WOODELF) then
      raceX = GetString(ESOA_RACE_WOODELF_ABBREV2)
    elseif raceName == GetString(ESOA_RACE_KHAJIIT) then
      raceX = GetString(ESOA_RACE_KHAJIIT_ABBREV2)
    elseif raceName == GetString(ESOA_RACE_ARGONIAN) then
      raceX = GetString(ESOA_RACE_ARGONIAN_ABBREV2)
    elseif raceName == GetString(ESOA_RACE_NORD) then
      raceX = GetString(ESOA_RACE_NORD_ABBREV)
    elseif raceName == GetString(ESOA_RACE_DARKELF) then
      raceX = GetString(ESOA_RACE_DARKELF_ABBREV2)
    elseif raceName == GetString(ESOA_RACE_BRETON) then
      raceX = GetString(ESOA_RACE_BRETON_ABBREV)
    elseif raceName == GetString(ESOA_RACE_ORC) then
      raceX = GetString(ESOA_RACE_ORC_ABBREV)
    elseif raceName == GetString(ESOA_RACE_REDGUARD) then
      raceX = GetString(ESOA_RACE_REDGUARD_ABBREV)   
    end
    return raceX
end

--
function ElderScrollsOfAlts:GetAllianceIcon(alliance)
  --if( alliance == 1 ) then
  --else if XXX then
  --end
  return ZO_GetAllianceIcon(alliance)
end

--
function ElderScrollsOfAlts:ListAllAllowedViewEntries()
  local printEntries = "" 
  for kName, kVal in pairs(ElderScrollsOfAlts.allowedViewEntries) do
    printEntries = zo_strformat("<<1>> {<<2>>},", printEntries, kName )
  end
  printEntries = "Allowable entry names: " .. printEntries
  ElderScrollsOfAlts.outputMsg(printEntries)
end



-- DISPLAY -- 
-----------
