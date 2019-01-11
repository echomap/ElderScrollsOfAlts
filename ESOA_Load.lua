--

function ElderScrollsOfAlts:SavePlayerDataForGui()
  ElderScrollsOfAlts.DataSaveLivePlayer()
  ElderScrollsOfAlts.view.needToLoadGuiData = true
  ElderScrollsOfAlts.debugMsg("SavePlayerDataForGui:", " called") 
end

function ElderScrollsOfAlts:LoadPlayerDataForGui()
  ElderScrollsOfAlts.view.playerLines = ElderScrollsOfAlts:SetupGuiPlayerLines()
  ElderScrollsOfAlts.view.needToLoadGuiData = false
  ElderScrollsOfAlts.debugMsg("LoadPlayerDataForGui:", " called") 
end


function ElderScrollsOfAlts:SetupGuiPlayerLines()
  
  --
  ElderScrollsOfAlts.view.accountData = {}
  ElderScrollsOfAlts.view.accountData.secondsplayed = 0
  --bankspaces
  --etc
  
  --
	local playerLines =  {}
	--table.insert(playerLines, "Select")
  local pCount = 0
	for k, v in pairs(ElderScrollsOfAlts.altData.players) do
    if k == nil then return end
		--ElderScrollsOfAlts.debugMsg(" players " .. k)
		playerLines[k] = {}
    pCount = pCount+1    
		playerLines[k].name = ElderScrollsOfAlts:getColoredString(ITEM_QUALITY_TRASH, k )
    playerLines[k].rawname = k
    playerLines[k].category = ElderScrollsOfAlts.altData.players[k].category
    if(playerLines[k].category==nil)then
      playerLines[k].category = "A"
    end
    playerLines[k].note = ElderScrollsOfAlts.altData.players[k].note
		local bio = ElderScrollsOfAlts.altData.players[k].bio
    playerLines[k].gender = -1
    playerLines[k].level = -1
    playerLines[k].race = "Unk"
    playerLines[k].class = "Unk"
    playerLines[k].Werewolf = false
    playerLines[k].Vampire = false
    playerLines[k].special    = 0    
    playerLines[k].special_biteicon = nil
    playerLines[k].special_bitetimer = -1
    --playerLines[k].special_bitetimer2 = "n/a"
    playerLines[k].special_bitetimerDisplay = "[n/a]"
    --
		if bio ~=nil then
			playerLines[k].gender   = bio.gender
      playerLines[k].level    = bio.level
			playerLines[k].race     = bio.race
      playerLines[k].class    = bio.class
      playerLines[k].alliance = bio.alliance
      playerLines[k].name     = bio.name --rewrite name
      playerLines[k].id       = bio.id      
      --
      if bio.Werewolf then
        playerLines[k].Werewolf = true
        playerLines[k].special    = 1        
        -- ["Werewolf"]["abilities"]["Bloodmoon"] TODO
        local foundItem = ElderScrollsOfAlts:FindAbility(ElderScrollsOfAlts.altData.players[k],"world","Werewolf","Bloodmoon")
        if(foundItem~=nil) then
          playerLines[k].special_bitetimerDisplay = "[Unk]"
          playerLines[k].special_icon = foundItem["textureName"]
          if(ElderScrollsOfAlts.altData.players[k].buffs~=nil)then
            local buffvalue = nil
            for buffName, buffvalueL in pairs(ElderScrollsOfAlts.altData.players[k].buffs) do
              if(buffName==ElderScrollsOfAlts.BITE_WERE_ABILITY)then--TODO global
                buffvalue = buffvalueL
              end
            end
            if buffvalue~=nil then
              --local timeDiff = GetFrameTimeSeconds() - buffvalue["timeEnding"]
              local timeDiff = GetDiffBetweenTimeStamps( buffvalue["expiresAt"], GetTimeStamp() ) 
              if(ElderScrollsOfAlts.altData.players[k].version==nil) then
                timeDiff = GetFrameTimeSeconds() - buffvalue["timeEnding"]
              end
              playerLines[k].special_bitetimer = timeDiff
              playerLines[k].special_bitetimerDisplay = ElderScrollsOfAlts:timeToDisplay( (timeDiff*1000) ,true,false)
            else
              playerLines[k].special_bitetimer = 0
              playerLines[k].special_bitetimerDisplay = "[v.v]"
            end
          end
        else
          playerLines[k].special_bitetimerDisplay = "[Not Skilled]"
        end--foundItem
      end--ww
      if bio.Vampire then
        playerLines[k].Vampire = true
        playerLines[k].special    = 2
        local foundItem = ElderScrollsOfAlts:FindAbility(ElderScrollsOfAlts.altData.players[k],"world","Vampire","Blood Ritual")
        if(foundItem~=nil) then
          playerLines[k].special_bitetimerDisplay = "[Unk]"
          playerLines[k].special_icon = foundItem["textureName"]
          --ElderScrollsOfAlts.outputMsg("Found Blood Ritual!!")
          --AND buff name check buff  "Feed on Ally"
          if(ElderScrollsOfAlts.altData.players[k].buffs~=nil)then
            local buffvalue = nil
            for buffName,buffvalue in pairs(ElderScrollsOfAlts.altData.players[k].buffs) do
              if(buffName==ElderScrollsOfAlts.BITE_VAMP_ABILITY  )then --TODO global
                buffvalue = buffvalueL
              end
            end
            if buffvalue~=nil then
              --local timeDiff = GetFrameTimeSeconds() - buffvalue["timeEnding"]
              local timeDiff = GetDiffBetweenTimeStamps( buffvalue["expiresAt"], GetTimeStamp() ) 
              if(ElderScrollsOfAlts.altData.players[k].version==nil) then
                timeDiff = GetFrameTimeSeconds() - timeTillReady
              end              
              playerLines[k].special_bitetimer = timeDiff
              playerLines[k].special_bitetimerDisplay = ElderScrollsOfAlts:timeToDisplay( (timeDiff*1000) ,true,false)
            else
              playerLines[k].special_bitetimer = 0
              playerLines[k].special_bitetimerDisplay = "[v.v]"
            end
          end
        else
          playerLines[k].special_bitetimerDisplay = "[Not Skilled]"
        end--foundItem    
      end--vv
		end
    if playerLines[k].level == nil or playerLines[k].level < 1 then
      ElderScrollsOfAlts.altData.players[k]  = nil --TODO this working as intended?
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
    playerLines[k].backpackSize  = 0
    playerLines[k].backpackUsed  = 0
    playerLines[k].backpackFree  = 0
    playerLines[k].skillpoints   = 0
    playerLines[k].secondsplayed = 0
    playerLines[k].timeplayed    = "---"
    if misc ~=nil then
      playerLines[k].backpackSize  = misc.backpackSize
      playerLines[k].backpackUsed  = misc.backpackUsed
      playerLines[k].backpackFree  = misc.backpackFree
      playerLines[k].skillpoints   = misc.skillpoints
      playerLines[k].secondsplayed = misc.secondsPlayed
    end
    if(playerLines[k].skillpoints==nil)then
      playerLines[k].skillpoints = 0 --per recent version
    end
    if(playerLines[k].secondsplayed==nil)then
      playerLines[k].secondsplayed = 0 --per recent version
    else
      ElderScrollsOfAlts.view.accountData.secondsplayed = ElderScrollsOfAlts.view.accountData.secondsplayed+playerLines[k].secondsplayed
      playerLines[k].timeplayed = ElderScrollsOfAlts:timeToDisplay( (playerLines[k].secondsplayed*1000) ,true,false)
    end
    
    --
    --local skills = ElderScrollsOfAlts.altData.players[k].skills
    ElderScrollsOfAlts:SetupGuiPlayerTradeLines(playerLines,k)
    ElderScrollsOfAlts:SetupGuiPlayerSkillsLines(playerLines,k)      
    ElderScrollsOfAlts:SetupGuiPlayerEquipLines(playerLines,k)      
    ElderScrollsOfAlts:SetupGuiResearchPlayerLines(playerLines,k)
  end--for k, v in pairs(ElderScrollsOfAlts.altData.players) do

  -- PlayerLines to table
  table.sort(playerLines)  
  ElderScrollsOfAlts.view.maxPlayerLineCount = pCount
  return playerLines
end

--("world","Vampire","Blood Ritual")
function ElderScrollsOfAlts:FindAbility(tplayer,skillType,skillClass,skillName)
  local retVal = nil
  if( tplayer.skills[skillType]~=nil and 
      tplayer.skills[skillType]["typelist"]~=nil and
      tplayer.skills[skillType]["typelist"][skillClass]~=nil and
      tplayer.skills[skillType]["typelist"][skillClass]["abilities"]~=nil and
      tplayer.skills[skillType]["typelist"][skillClass]["abilities"][skillName]~=nil) then
    retVal = tplayer.skills[skillType]["typelist"][skillClass]["abilities"][skillName]
  end
  return retVal
end

function ElderScrollsOfAlts:SetupGuiPlayerEquipLines(playerLines,k)    
  --Set Defaults
  playerLines[k].heavy  = 0
  playerLines[k].medium = 0
  playerLines[k].light  = 0
  local EMPTYLINE = ""
  playerLines[k].Head       = EMPTYLINE
  --playerLines[k].Head_Link  = ev.itemLink     
  playerLines[k].Head_Type  = EMPTYLINE     
  playerLines[k].Chest  = EMPTYLINE
  --playerLines[k].Chest_Link  = ev.itemLink
  playerLines[k].Chest_Type  = EMPTYLINE     
  playerLines[k].Feet  = EMPTYLINE
  --playerLines[k].Feet_Link  = ev.itemLink          
  playerLines[k].Feet_Type  = EMPTYLINE     
  playerLines[k].Hands  = EMPTYLINE
  --playerLines[k].Hands_Link  = ev.itemLink          
  playerLines[k].Hands_Type  = EMPTYLINE
  playerLines[k].Legs  = EMPTYLINE
  --playerLines[k].Legs_Link  = ev.itemLink          
  playerLines[k].Legs_Type  = EMPTYLINE
  playerLines[k].Shoulders  = EMPTYLINE
  --playerLines[k].Shoulders_Link  = ev.itemLink
  playerLines[k].Shoulders_Type  = EMPTYLINE
  playerLines[k].Waist  = EMPTYLINE
 -- playerLines[k].Waist_Link  = ev.itemLink          
  playerLines[k].Waist_Type  = EMPTYLINE
  playerLines[k].Neck  = EMPTYLINE
  --playerLines[k].Neck_Link    = ev.itemLink          
  --playerLines[k].Neck_Quality = ev.quality
  playerLines[k].Ring2  = EMPTYLINE
  --playerLines[k].Ring2_Link    = ev.itemLink  
  --playerLines[k].Ring2_Quality = ev.quality
  playerLines[k].Ring1  = EMPTYLINE
  --playerLines[k].Ring1_Link    = ev.itemLink  
  --playerLines[k].Ring1_Quality = ev.quality
  playerLines[k].O1  = EMPTYLINE
  --playerLines[k].O1_Link  = ev.itemLink  
  --playerLines[k].O1_WeaponType  = ev.weaponType  
  playerLines[k].M1  = EMPTYLINE
  --playerLines[k].M1_Link  = ev.itemLink  
  --playerLines[k].M1_WeaponType  = ev.weaponType  
  playerLines[k].M2  = EMPTYLINE
  --playerLines[k].M2_Link  = ev.itemLink              
 -- playerLines[k].M2_WeaponType  = ev.weaponType  
  playerLines[k].O2  = "O2"
  --playerLines[k].O2_Link  = ev.itemLink  
  --playerLines[k].O2_WeaponType  = ev.weaponType  
  playerLines[k].M2  = EMPTYLINE
  --playerLines[k].M2_Link  = ev.itemLink  
  --playerLines[k].M2_WeaponType  = ev.weaponType  
  playerLines[k].Op  = EMPTYLINE
  --playerLines[k].Op_Link  = ev.itemLink
  playerLines[k].Mp  = EMPTYLINE
  --playerLines[k].Mp_Link  = ev.itemLink  
      
  --
  local elemT = ElderScrollsOfAlts.altData.players[k].equip
  if elemT == nil then
    return
  end

  if elemT.slots == nil then
    return
  end

  local equip = elemT.slots
  for ek, ev in pairs(equip) do
    if ek == nil then return end
    --ElderScrollsOfAlts.debugMsg(" equip " .. ek)
    local tarmortype = 0
    local lLine = ""
    --Armor Types
    if ev.armorType ~=nil then
      playerLines[k].armortype = 0
      if( ev.armorType == ARMORTYPE_HEAVY ) then
        lLine = "H"
        playerLines[k].heavy = playerLines[k].heavy +1
        tarmortype = 1
      elseif( ev.armorType == ARMORTYPE_MEDIUM ) then
        playerLines[k].medium = playerLines[k].medium +1
        lLine = "M"
        tarmortype = 2
      elseif( ev.armorType == ARMORTYPE_LIGHT ) then
        playerLines[k].light = playerLines[k].light +1
        lLine = "L"
        tarmortype = 3
      end
    end
    
    --Armor Types/Slots
    if ev.equipType == EQUIP_TYPE_HEAD then
      playerLines[k].Head       = lLine
      playerLines[k].Head_Link  = ev.itemLink     
      playerLines[k].Head_Type  = tarmortype     
    elseif ev.equipType == EQUIP_TYPE_CHEST then
      playerLines[k].Chest  = lLine
      playerLines[k].Chest_Link  = ev.itemLink
      playerLines[k].Chest_Type  = tarmortype     
    elseif ev.equipType == EQUIP_TYPE_FEET then --10
      playerLines[k].Feet  = lLine
      playerLines[k].Feet_Link  = ev.itemLink          
      playerLines[k].Feet_Type  = tarmortype     
    elseif ev.equipType == EQUIP_TYPE_HAND then
      playerLines[k].Hands  = lLine
      playerLines[k].Hands_Link  = ev.itemLink          
      playerLines[k].Hands_Type  = tarmortype
    elseif ev.equipType == EQUIP_TYPE_LEGS then
      playerLines[k].Legs  = lLine
      playerLines[k].Legs_Link  = ev.itemLink          
      playerLines[k].Legs_Type  = tarmortype
    elseif ev.equipType == EQUIP_TYPE_SHOULDERS then
      playerLines[k].Shoulders  = lLine
      playerLines[k].Shoulders_Link  = ev.itemLink
      playerLines[k].Shoulders_Type  = tarmortype
    elseif ev.equipType == EQUIP_TYPE_WAIST then
      playerLines[k].Waist  = lLine
      playerLines[k].Waist_Link  = ev.itemLink          
      playerLines[k].Waist_Type  = tarmortype
    elseif ev.equipType == EQUIP_TYPE_NECK then
      playerLines[k].Neck  = "O" --TODO lLine
      playerLines[k].Neck_Link    = ev.itemLink          
      playerLines[k].Neck_Quality = ev.quality
    elseif ev.equipType == EQUIP_TYPE_RING then
      if( ev.slotId == EQUIP_SLOT_RING1) then
        playerLines[k].Ring2  = "O"
        playerLines[k].Ring2_Link    = ev.itemLink  
        playerLines[k].Ring2_Quality = ev.quality
      elseif( ev.slotId == EQUIP_SLOT_RING2) then
        playerLines[k].Ring1  = "O"
        playerLines[k].Ring1_Link    = ev.itemLink  
        playerLines[k].Ring1_Quality = ev.quality
      end
      
    -- Weapon Types/Slots
    --sword:eq=5(EQUIP_TYPE_ONE_HAND),slot=4(EQUIP_SLOT_MAIN_HAND)
    --shield:eq=7(EQUIP_TYPE_OFF_HAND),slot=5(EQUIP_SLOT_OFF_HAND)
    --staff2/h:eq=6(EQUIP_TYPE_TWO_HAND),slot=20(EQUIP_SLOT_BACKUP_MAIN)
    --staff2/h:eq=6(EQUIP_TYPE_TWO_HAND),slot=4 (EQUIP_SLOT_MAIN_HAND)  
    elseif ev.equipType == EQUIP_TYPE_ONE_HAND then --5
      --debugMsg("1h1 itemLink: "..ev.itemLink .." slotid="..tostring(ev.slotId) )
      if( ev.slotId == EQUIP_SLOT_BACKUP_MAIN) then --20
        --debugMsg("Set O1 to "..ev.itemName)
        playerLines[k].O1  = "O"
        playerLines[k].O1_Link  = ev.itemLink  
        playerLines[k].O1_WeaponType  = ev.weaponType  
      elseif( ev.slotId == EQUIP_SLOT_MAIN_HAND) then --4
        playerLines[k].M1  = "O"
        playerLines[k].M1_Link  = ev.itemLink  
        playerLines[k].M1_WeaponType  = ev.weaponType  
      elseif( ev.slotId == EQUIP_SLOT_OFF_HAND) then --5
        playerLines[k].M2  = "O"
        playerLines[k].M2_Link  = ev.itemLink              
        playerLines[k].M2_WeaponType  = ev.weaponType  
      end
    elseif ev.equipType == EQUIP_TYPE_OFF_HAND then --7
      --debugMsg("1h2 itemLink: "..ev.itemLink .." slotid="..tostring(ev.slotId) )
      if( ev.slotId == EQUIP_SLOT_BACKUP_OFF) then --21
        --debugMsg("Set O2 to "..ev.itemName)
        playerLines[k].O2  = "O2"
        playerLines[k].O2_Link  = ev.itemLink  
        playerLines[k].O2_WeaponType  = ev.weaponType  
      elseif( ev.slotId == EQUIP_SLOT_OFF_HAND) then --5
        playerLines[k].M2  = "O"
        playerLines[k].M2_Link  = ev.itemLink  
        playerLines[k].M2_WeaponType  = ev.weaponType  
      end 
    elseif ev.equipType == EQUIP_TYPE_TWO_HAND then 
      --debugMsg("2h itemLink: "..ev.itemLink .." slotid="..tostring(ev.slotId) )
      if( ev.slotId == EQUIP_SLOT_BACKUP_MAIN) then
        --debugMsg("Set O1(b) to "..ev.itemName)
        playerLines[k].O1  = "O"
        playerLines[k].O1_Link  = ev.itemLink  
        playerLines[k].O1_WeaponType  = ev.weaponType  
      elseif( ev.slotId == EQUIP_SLOT_MAIN_HAND) then
        playerLines[k].M1  = "O"
        playerLines[k].M1_Link  = ev.itemLink  
        playerLines[k].M1_WeaponType  = ev.weaponType  
      end
    elseif ev.equipType == EQUIP_TYPE_POISON then
      if( ev.slotId == EQUIP_SLOT_BACKUP_POISON) then
        playerLines[k].Op  = "O"
        playerLines[k].Op_Link  = ev.itemLink
      elseif( ev.slotId == EQUIP_SLOT_POISON) then
        playerLines[k].Mp  = "O"
        playerLines[k].Mp_Link  = ev.itemLink  
      end
    end
  end --pairs(equip)
end

function ElderScrollsOfAlts:SetupGuiPlayerSkillsLines(playerLines,k)
  --Set Defaults
  --HACK! TODO fix
  local aTypes = {"Assault_Rank","Support_Rank","Legerdemain_Rank","Soul Magic_Rank","Werewolf_Rank","Vampire_Rank","Fighters Guild_Rank","Mages Guild_Rank","Undaunted_Rank","Thieves Guild_Rank","Dark Brotherhood_Rank","Psijic Order_Rank"}
  for rtK,rtV in pairs(aTypes) do
    --debugMsg("skills All "..k.." as="..rtK.." rtVT='"..tostring(rtV).."'")
    playerLines[k][rtV] = 0
  end
  --HACK! TODO fix
      
  -- Check if player even has skills
  local rTypes = {"ava","guild","world"}
  local skills = ElderScrollsOfAlts.altData.players[k].skills

  if(skills~=nil) then
    for rtK,rtV in pairs(rTypes) do
      --debugMsg("skills for "..k.." as="..rtK.." rtV="..tostring(rtV))
      if(skills[rtV]~=nil)then
        local skillO = skills[rtV]
        if(skillO~=nil)then  
          local skillL = skillO.typelist
          if(skillL~=nil)then
            for rtKT,rtVT in pairs(skillL) do
              --debugMsg("skills cont "..k.." as="..rtKT.." rtVT="..tostring(rtVT))
              playerLines[k][rtKT.."_Rank"] = rtVT.rank
              playerLines[k][rtKT.."_Name"] = rtVT.name
              --debugMsg("skills DD ["..rtKT.."_Rank]" .." as="..tostring(rtVT.rank))
            end
          end
        end
      end
    end
  end

  --misc
  local misc = ElderScrollsOfAlts.altData.players[k].misc
  playerLines[k].riding_inventory = -1
  playerLines[k].riding_speed     = -1
  playerLines[k].riding_stamina   = -1
  --playerLines[k].riding_cantrain  = false
  playerLines[k].riding_timeMs    = -1
  playerLines[k].riding_totalDurationMs = -1
  --playerLines[k].riding_timedisplay     = "--"
  playerLines[k].riding_trainingready   = nil    
    
  if(misc~=nil)then
    local riding = misc.riding
    if(riding~=nil)then
      playerLines[k].riding_inventory = riding.inventory
      playerLines[k].riding_speed     = riding.speed
      playerLines[k].riding_stamina   = riding.stamina
      playerLines[k].riding_timeMs          = riding.timeMs
      playerLines[k].riding_totalDurationMs = riding.totalDurationMs
      playerLines[k].riding_trainingready   = riding.trainingReadyAt
      
      --if(riding.timeMs~=nil and riding.timeMs>-1)then
        --playerLines[k].riding_timedisplay = ElderScrollsOfAlts:timeToDisplay( riding.timeMs, riding.timeDataTaken )
      --end
    end
  end
  
end

function ElderScrollsOfAlts:SetupGuiPlayerTradeLines(playerLines,k)
  --Setup Defaults
  local dEFvAL = 0
  playerLines[k].alchemy         = dEFvAL
  playerLines[k].alchemy_sunk    = dEFvAL
  playerLines[k].alchemy_sinkmax = dEFvAL
  playerLines[k].blacksmithing         = dEFvAL
  playerLines[k].blacksmithing_sunk    = dEFvAL
  playerLines[k].blacksmithing_sinkmax = dEFvAL   
  playerLines[k].clothing         = dEFvAL
  playerLines[k].clothing_sunk    = dEFvAL
  playerLines[k].clothing_sinkmax = dEFvAL   
  playerLines[k].enchanting          = dEFvAL
  playerLines[k].enchanting_sunk     = dEFvAL
  playerLines[k].enchanting_sinkmax  = dEFvAL 
  playerLines[k].enchanting_sunk2    = dEFvAL
  playerLines[k].enchanting_sinkmax2 = dEFvAL             
  playerLines[k].jewelry         = dEFvAL
  playerLines[k].jewelry_sunk    = dEFvAL
  playerLines[k].jewelry_sinkmax = dEFvAL 
  playerLines[k].provisioning          = dEFvAL
  playerLines[k].provisioning_sunk     = dEFvAL
  playerLines[k].provisioning_sinkmax  = dEFvAL              
  playerLines[k].provisioning_sunk2    = dEFvAL
  playerLines[k].provisioning_sinkmax2 = dEFvAL              
  playerLines[k].woodworking         = dEFvAL
  playerLines[k].woodworking_sunk    = dEFvAL
  playerLines[k].woodworking_sinkmax = dEFvAL              

  --
  local trade = ElderScrollsOfAlts.altData.players[k].skills.trade
  if trade ==nil then
    return
  end

  local tradeL = ElderScrollsOfAlts.altData.players[k].skills.trade.typelist
  if tradeL ==nil then
    return
  end
  
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
    playerLines[k].smithing= blacksmithing.rank   
    playerLines[k].blacksmithing_sunk    = blacksmithing.sunk
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
    playerLines[k].enchanting_sunk     = enchanting.sunk
    playerLines[k].enchanting_sinkmax  = enchanting.sinkmax
    playerLines[k].enchanting_sunk2    = enchanting.sunk2
    playerLines[k].enchanting_sinkmax2 = enchanting.sinkmax2
  else
    playerLines[k].enchanting = 0
    playerLines[k].enchanting_sunk     = 0
    playerLines[k].enchanting_sinkmax  = 0 
    playerLines[k].enchanting_sunk2    = 0
    playerLines[k].enchanting_sinkmax2 = 0             
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
    playerLines[k].provisioning_sunk     = provisioning.sunk
    playerLines[k].provisioning_sinkmax  = provisioning.sinkmax
    playerLines[k].provisioning_sunk2    = provisioning.sunk2
    playerLines[k].provisioning_sinkmax2 = provisioning.sinkmax2
  else
    playerLines[k].provisioning = 0
    playerLines[k].provisioning_sunk     = 0
    playerLines[k].provisioning_sinkmax  = 0              
    playerLines[k].provisioning_sunk2    = 0
    playerLines[k].provisioning_sinkmax2 = 0              
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

--RESEARCH
function ElderScrollsOfAlts:SetupGuiResearchPlayerLines(playerLines,k)
  local research = ElderScrollsOfAlts.altData.players[k].research
  --if research ==nil then
  --  return
  --end
  if k == nil then return end
    
  local rTypes = {"clothier","woodworking","blacksmithing","jewelcrafting"}
  -- Check if player even has this research slot
  --if( research ~= nil ) then 
    
  --rclothier1time,rclothier2time
  for rtK,rtV in pairs(rTypes) do
    ElderScrollsOfAlts.debugMsg("research for "..k.." as="..rtK.." rtV="..tostring(rtV))    
    --Defaults
    playerLines[k]["r"..rtV.."1time"] = "--------"
    playerLines[k]["r"..rtV.."2time"] = "--------"
    playerLines[k]["r"..rtV.."3time"] = "--------"
    playerLines[k]["r"..rtV.."1S"] = 0
    playerLines[k]["r"..rtV.."2S"] = 0
    playerLines[k]["r"..rtV.."3S"] = 0
    playerLines[k]["r"..rtV.."code"] = -1
    --Code = -1 is n/a, 0 is unk, 1 is READY, 
    if(research==nil or research[rtV]==nil)then
    else
      --Number of Slots = researchMS
      local researchMS = research[rtV].researchMS
      for kkiT = 1, 3 do
        local mKye = "r"..rtV..kkiT
        --debugMsg("ESOA: setup ResearchItem: playerLines[k][mKye.."S"] = timeS="
        if(researchMS==nil) then
          playerLines[k][mKye.."time"] = ""
          playerLines[k][mKye.."code"] = 0
        elseif(kkiT<=researchMS) then
          playerLines[k][mKye.."time"] = "[avail]"
          playerLines[k][mKye.."code"] = 1
        else
          playerLines[k][mKye.."time"] = "--------"
          playerLines[k][mKye.."code"] = 0
        end
      end
    end
  end
    
  -- Colate data for this research slot
  if(research~=nil)then
    for rtK,rtV in pairs(rTypes) do
      if(research[rtV]~=nil) then
        local kki = 1
        for kk, vv in pairs( research[rtV].ongoing ) do
          if kk == nil then return end
          ElderScrollsOfAlts.debugMsg("research kk=" .. kk.. " v="..tostring(vv) )
          --Get/Fix Time
          local nowDiff = GetDiffBetweenTimeStamps( GetTimeStamp() , ElderScrollsOfAlts.altData.players[k].research.now ) --secconds
          if(ElderScrollsOfAlts.altData.players[k].version==nil) then
            nowDiff = GetFrameTimeSeconds() - ElderScrollsOfAlts.altData.players[k].research.now
            --nowDiff = GetTimeStamp() - vv.timeTillReady
          end
          local timeS = vv.timeRemainingSecs - nowDiff          
          --if(ElderScrollsOfAlts.altData.players[k].version~=ElderScrollsOfAlts.version) then
            --timeS = vv.timeTillReady - GetTimeStamp()
          --end
          local timeM = math.floor(timeS/60)
          local timeH = math.floor(timeM/60)
          local timeD = math.floor(timeH/24)
          if(timeH>0) then
            timeM = timeM - (timeH*60)
          elseif(timeH<0) then
            timeH = 0
          end
          if(timeD>0) then
            timeH = timeH - (timeD*24)
          end          
          local mKye = "r"..rtV..kki
          local timeDisp2Str = ""
          if(timeS<=0) then
            timeDisp2Str = "[avail]"
            playerLines[k][mKye.."code"] = 1
          elseif(timeD>0) then
            timeDisp2Str = "<<1>>d<<2>>h<<3>>m"
          else
            timeDisp2Str = "<<2>>h<<3>>m"
          end
          if(timeS>0) then
            playerLines[k][mKye.."code"] = 2
          end
          local timeDisp2 = zo_strformat(timeDisp2Str, timeD,timeH,timeM )
          local timeDisp = timeD.."d" ..timeH.."h" ..timeM.."m"
          if(ElderScrollsOfAlts.altData.players[k].version==nil) then
            playerLines[k][mKye.."code"] = 3
            timeDisp2 = "*"..timeDisp2
          end          
          playerLines[k][mKye.."name"] = vv.name
          playerLines[k][mKye.."time"] = timeDisp2
          playerLines[k][mKye.."D"] = timeD
          playerLines[k][mKye.."H"] = timeH
          playerLines[k][mKye.."S"] = timeS
          --TODO timeTillReady
          --debugMsg("research for "..k.." mKye="..mKye.. " research: " .. vv.name .. " D="..timeD .." H="..timeH .." M="..timeM)
          playerLines[k][mKye.."TraitType"] = vv.traitType
          playerLines[k][mKye.."TraitDesc"] = vv.traitDescription
          playerLines[k][mKye.."Traitknown"] = vv.known
          --        
          kki = kki+1
        end 
      end
    end
  end
end


--EOF