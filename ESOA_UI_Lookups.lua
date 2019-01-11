
-----------
-- HELPER -- 

function ElderScrollsOfAlts.GuiCharLineLookupPopulateData(viewname,viewKey,eline,playerLine)
  if(viewKey=="Special") then
    local werewolf = playerLine["Werewolf"]
    local vampire  = playerLine["Vampire"] 
    eline.special = 0
    if werewolf then
      eline.special = 1
      eline:SetTexture("/esoui/art/icons/store_werewolfbite_01.dds")
      eline.tooltip = playerLine.name .. " is a ".."Werewolf (" .. tostring(playerLine.special_bitetimerDisplay) ..")"
    end
    if vampire then
      eline:SetTexture("/esoui/art/icons/store_vampirebite_01.dds")
      eline.special = 2
      eline.tooltip = playerLine.name .. " is a ".."Vampire (" .. tostring(playerLine.special_bitetimerDisplay) ..")"
    end
    --TODO timers
  elseif(viewKey=="SpecialBiteTimer") then
    eline:SetText( playerLine.special_bitetimerDisplay )
    local canBite = ""
    if( playerLine.special_bitetimer~=nil and playerLine.special_bitetimer<=0)then
      canBite = " Can Bite"
    end
    eline.tooltip = "("..tostring(playerLine.special_bitetimerDisplay) ..")"..canBite
    --TODO eline.tooltip = playerLine.name .. " is a ".."Vampire (" .. tostring(playerLine.special_bitetimerDisplay) ..")"
  elseif(viewKey=="Note") then
    if( playerLine["note"]==nil or playerLine["note"]=="")then --TODO string.len (s)?
      eline:SetTexture("/esoui/art/icons/heraldrybg_onion_01.dds")
    else
      eline:SetTexture("/esoui/art/icons/quest_letter_001.dds")
      eline.tooltip = playerLine["note"]
    end
    eline:SetHandler("OnMouseDoubleClick", function(...) ElderScrollsOfAlts:GUILineDoubleClick(...) end )
    --eline:SetHandler('OnMouseDoubleClick',function(control, button)
    --    ElderScrollsOfAlts:GUILineDoubleClick(control, button)
    --end)
  elseif(viewKey=="Alliance") then
    local pAlliance = playerLine["alliance"]
    eline.alliance = pAlliance
    if pAlliance ~= nil then
      local pAllIcon = ElderScrollsOfAlts:GetAllianceIcon(pAlliance);
      eline:SetTexture(pAllIcon)      
    end
  elseif(viewKey=="Class") then
    eline:SetText( ElderScrollsOfAlts:GetClassText(playerLine["class"]) )
    eline.tooltip = playerLine.name .. " is a ".. ElderScrollsOfAlts:GetClassText(playerLine["class"])
  elseif(viewKey=="Level") then
    if playerLine["champion"] == nil then
      eline:SetText( playerLine["level"])
    else
      eline:SetText( playerLine["level"] .."("..playerLine["champion"]..")" )      
    end
  elseif(viewKey=="Race") then
    eline:SetText( ElderScrollsOfAlts:GetRaceText1(playerLine["race"]) )
    eline.tooltip = playerLine.name .. " is a ".. playerLine["race"] 
  elseif(viewKey=="Gender") then
    local genderText = ElderScrollsOfAlts:GetGenderText(playerLine["gender"])
    eline:SetText( genderText )
    eline.tooltip = playerLine.name .. " is a ".. ElderScrollsOfAlts:GetGenderFullText(playerLine["gender"])
  --
  elseif(viewKey=="Assault" or viewKey=="Support" or viewKey=="Legerdemain" or viewKey=="Soul Magic" or viewKey=="Werewolf" or viewKey=="Vampire" or viewKey=="Fighters Guild" or viewKey=="Mages Guild" or viewKey=="Undaunted" or viewKey=="Thieves Guild" or viewKey=="Dark Brotherhood" or viewKey=="Psijic Order" and playerLine[viewKey.."_Rank"]~=nil ) then
    eline:SetText( playerLine[viewKey.."_Rank"]  )
    eline.tooltip = playerLine.name .." has ".. viewKey .." skill of ".. playerLine[viewKey.."_Rank"] 
  --
  elseif(viewKey=="Alchemy") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"alchemy")--,"alchemy_sunk","alchemy_sunk2")    
  elseif(viewKey=="Smithing") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"blacksmithing")
  elseif(viewKey=="Clothing") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"clothing")
  elseif(viewKey=="Enchanting") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"enchanting")
  elseif(viewKey=="JC") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"jewelry")
  elseif(viewKey=="Jewelry") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"jewelry")
 elseif(viewKey=="Provisioning") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"provisioning")
  elseif(viewKey=="Woodworking") then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,"woodworking")
  --
  elseif(viewKey=="Clothier Research 1") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"clothier",1)
  elseif(viewKey=="Clothier Research 2") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"clothier",2)
  elseif(viewKey=="Clothier Research 3") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"clothier",3)
  elseif(viewKey=="Blacksmithing Research 1") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"blacksmithing",1)
  elseif(viewKey=="Blacksmithing Research 2") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"blacksmithing",2)
  elseif(viewKey=="Blacksmithing Research 3") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"blacksmithing",3)
  elseif(viewKey=="Woodworking Research 1") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"woodworking",1)
  elseif(viewKey=="Woodworking Research 2") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"woodworking",2)
  elseif(viewKey=="Woodworking Research 3") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"woodworking",3)
  elseif(viewKey=="Jewelcrafting Research 1") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"jewelcrafting",1)
  elseif(viewKey=="Jewelcrafting Research 2") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"jewelcrafting",2)
  elseif(viewKey=="Jewelcrafting Research 3") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,"jewelcrafting",3)
  -- 
  elseif(viewKey=="Heavy" or viewKey=="Medium" or viewKey=="Light") then    
    ElderScrollsOfAlts:GuiCharLineLookupPopulateEquipData(viewKey,eline,playerLine, viewKey:lower())
  --  
  elseif(viewKey=="Head" or viewKey=="Shoulders" or viewKey=="Chest" or viewKey=="Waist" or viewKey=="Legs" or viewKey=="Hands" or viewKey=="Feet" ) then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateEquipData(viewKey,eline,playerLine, viewKey )
  elseif(viewKey=="Neck" or viewKey=="Ring1" or viewKey=="Ring2" ) then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateEquipData(viewKey,eline,playerLine, viewKey )
  elseif(viewKey=="M1" or viewKey=="M2" or viewKey=="Mp" or viewKey=="O1" or viewKey=="O2" or viewKey=="Op" ) then
    ElderScrollsOfAlts:GuiCharLineLookupPopulateEquipData(viewKey,eline,playerLine, viewKey )
  --
  --
  elseif(viewKey=="BagSpace") then
    local bu = playerLine["backpackUsed"] 
    local bs = playerLine["backpackSize"]
    local bf = playerLine["backpackFree"]
    if bs == nil then bs = "---" end
    local bagText = string.format("%3d/%3d",bu, bs)
    eline:SetText(bagText)
    if(bf~=nil) then
      eline.tooltip = playerLine.name .. " has a ".. bf .. " free bag slots"
    end
  elseif(viewKey=="BagSpaceFree") then
    local bu = playerLine["backpackUsed"] 
    local bs = playerLine["backpackSize"]
    local bf = playerLine["backpackFree"]
    if bs == nil then bs = "---" end
    if( bf==nil or bf=="" ) then bf= tonumber(bs-bu) end
    eline:SetText(bf)  
    eline.tooltip = playerLine.name .. " has a ".. bf .. " free bag slots"
  elseif(viewKey=="Skillpoints") then
    eline:SetText(playerLine["skillpoints"])  
    eline.tooltip = zo_strformat("<<1>> has <<2>> free skillpoints", playerLine.name,playerLine["skillpoints"])
    --eline.sortKey
  --
  --
  elseif(viewKey=="Riding Speed" or viewKey=="Riding Stamina" or viewKey=="Riding Inventory") then        
    local newKey = string.lower(viewKey)
    newKey = newKey:gsub(" ","_")
    if( playerLine[ newKey ] ~=nil ) then
      eline:SetText( playerLine[newKey]  )
      eline.tooltip = zo_strformat("<<1>> has <<2>> in <<3>> skill", playerLine.name,  playerLine[newKey], viewKey )
    else
      eline:SetText(playerLine[viewKey])
      eline.tooltip = zo_strformat("<<1>> has <<2>> in <<3>> skill", playerLine.name,  playerLine[viewKey], viewKey )
    end
  elseif(viewKey=="Riding Timer") then
    local timeMS     = playerLine["riding_timeMs"]
    local expireTime = playerLine["riding_trainingready"]  
    local nowTime    = GetTimeStamp()
    local timeDiff   = nil
    if(expireTime~=nil)then
      --timeDiff = expireTime - nowTime
      timeDiff = GetDiffBetweenTimeStamps(expireTime , nowTime)
      --ElderScrollsOfAlts.outputMsg("name="..tostring(playerLine["name"]) .. " timeDiff="..tostring(timeDiff) )
    end
    eline.timeMS = timeMS
    local rtType = -1
    if( timeDiff ~= nil )then
      if( timeDiff <= 0 ) then
        eline.tooltip = "Now"
        eline:SetText("Now")
        rtType = 1
      else
        local timeD = ElderScrollsOfAlts:timeToDisplay( (timeDiff*1000),false,true)
        eline.tooltip = timeD
        eline:SetText(timeD)      
        rtType = 0
      end      
    else
      eline.tooltip = "--"
      eline:SetText("--")  
    end
    --Riding Timer
    if(rtType>0)then
      if( ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer~=nil) then
        eline:SetText( ElderScrollsOfAlts.ColorText( ElderScrollsOfAlts.savedVariables.colors.colorTimerNone, eline:GetText() ) )
      end
    end
  elseif(viewKey=="SecondsPlayed" or viewKey=="TimePlayed")then
    eline:SetText( playerLine[string.lower(viewKey)]  )
    eline.tooltip = zo_strformat("<<1>> has played for <<2>> (account total=<<3>>s)",
        playerLine.name, playerLine[string.lower(viewKey)], 
        ElderScrollsOfAlts:timeToDisplay( (ElderScrollsOfAlts.view.accountData.secondsplayed*1000) ,true,false),
        ElderScrollsOfAlts.view.accountData.secondsplayed
      )
  --
  --
  else
    if( playerLine[viewKey.."_Rank"] ~=nil ) then
      eline:SetText( playerLine[viewKey.."_Rank"]  )
      return
    end
    local newKey = string.lower(viewKey)
    newKey = newKey:gsub(" ","_")
    --debugMsg("Newkey='"..newKey.."'")
    if( playerLine[ newKey ] ~=nil ) then
      eline:SetText( playerLine[newKey]  )
      eline.tooltip = viewKey .. " is " .. playerLine[string.lower(viewKey)]
      return
    end
      
    if( playerLine[string.lower(viewKey)] ~=nil) then
      eline:SetText( playerLine[string.lower(viewKey)]  )
      eline.tooltip = viewKey .. " is " .. playerLine[string.lower(viewKey)]
    elseif( playerLine[(viewKey)] ~=nil) then
      eline:SetText( playerLine[(viewKey)]  )
      eline.tooltip = viewKey .. " is " .. playerLine[(viewKey)]
    end
 
  end
end

function ElderScrollsOfAlts:GuiCharLineLookupPopulateEquipData(viewKey,eline,playerLine,equipName)
  local mKye1 = string.format("%s%s", equipName,"_Link")
  eline:SetText( playerLine[equipName] )
  eline.itemlink = playerLine[mKye1]
  eline.datatype = "Equip"
  --eline:SetMouseEnabled(true)
  eline:SetHandler('OnMouseEnter',function(self)
    ElderScrollsOfAlts:EquipTipEnter(self, viewKey )
  end)
  eline:SetHandler('OnMouseExit',function(self)
    ElderScrollsOfAlts:EquipTipExit(self)
  end)   
  eline:SetHandler('OnMouseUp',function(self)
    ElderScrollsOfAlts:EquipShowTip(self)
  end)
end

--rclothier2time
function ElderScrollsOfAlts:GuiCharLineLookupPopulateResearchData(viewKey,eline,playerLine,tradeName,numkey)
  --local vkey = "r"..tradeName.."time"
  local mKyeS  = string.format("%s%s%s%s","r",tradeName,numkey,"S")
  local mKyeC  = string.format("%s%s%s%s","r",tradeName,numkey,"code")
  local mKye1  = string.format("%s%s%s%s","r",tradeName,numkey,"time") --display time
  local mKyeN  = string.format("%s%s%s%s","r",tradeName,numkey,"name")
  local mKyeMS = string.format("%s%s%s%s","r",tradeName,numkey,"researchMS")
  local mKyeTT = string.format("%s%s%s%s","r",tradeName,numkey,"TraitType")
  local mKyeTD = string.format("%s%s%s%s","r",tradeName,numkey,"TraitDesc")  
  local mKyeTK = string.format("%s%s%s%s","r",tradeName,numkey,"Traitknown")           
  --local mKye1 = zo_strformat("<<1>><<2>><<3>><<4>>", "r",tradeName,numkey,"time")
  
  eline.data_val = playerLine[mKye1]
  eline.sort_data = playerLine[mKyeMS]
  eline:SetText( playerLine[mKye1] )
  eline:SetMaxLineCount( eline:GetWidth() )
  eline.name       = playerLine[mKyeN] 
  eline.traitType  = playerLine[mKyeTT]
  eline.traitDesc  = playerLine[mKyeTD]
  eline.traitKnown = playerLine[mKyeTK]
  
  --https://en.wikipedia.org/wiki/Web_colors
  --red  |cFF0000 |r
  --blue |c0000FF |r?
  -- 	FF4500 40E0D0
  local tradeTimeS = playerLine[mKyeS]  
  local codeS = playerLine[mKyeC]   --  > 0 ok
  if(codeS==3) then
    --eline:SetText( "[Refresh]" )   
    eline.traitDesc = "Old data! Refresh asap!!"
  elseif( (tradeTimeS==nil or codeS < 1) and ElderScrollsOfAlts.savedVariables.colors.colorTimerNone~=nil) then
    eline:SetText( ElderScrollsOfAlts.ColorText( ElderScrollsOfAlts.savedVariables.colors.colorTimerNone, playerLine[mKye1]) )
  elseif( codeS == 1 and ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer~=nil ) then
    eline:SetText( ElderScrollsOfAlts.ColorText(ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer,playerLine[mKye1]) )
  elseif( tradeTimeS < 43200 and ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer~=nil ) then
    eline:SetText( ElderScrollsOfAlts.ColorText(ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer,playerLine[mKye1]) )
  elseif( tradeTimeS < 86400 or codeS == 1 and ElderScrollsOfAlts.savedVariables.colors.colorTimerNear~=nil) then
    eline:SetText( ElderScrollsOfAlts.ColorText(ElderScrollsOfAlts.savedVariables.colors.colorTimerNear, playerLine[mKye1]) )
  end
  
  eline.datatype = "Research"
  --eline:SetMouseEnabled(true)
  eline:SetHandler('OnMouseEnter',function(self)
    ElderScrollsOfAlts:ResearchTipEnter(self, viewKey )
  end)
  eline:SetHandler('OnMouseExit',function(self)
    ElderScrollsOfAlts:ResearchTipExit(self)
  end)  
  --eline:SetFont(ZoFontGame)
end
  
function ElderScrollsOfAlts:GuiCharLineLookupPopulateTradeData(viewKey,eline,playerLine,tradeName)
  eline.data_val    = playerLine[tradeName]
  eline.data_sunk   = playerLine[tradeName.."_sunk"] 
  eline.data_sunk2  = playerLine[tradeName.."_sunk2"] 
  if eline.data_sunk ~=nil and eline.data_sunk > 0 then
    eline:SetText(eline.data_val.."("..eline.data_sunk..")" )      
  else
    eline:SetText(eline.data_val .. "  ")
  end
  --eline:SetMouseEnabled(true)
  eline:SetHandler('OnMouseEnter',function(self)
    ElderScrollsOfAlts:CraftTipEnter(self, viewKey )
  end)
  eline:SetHandler('OnMouseExit',function(self)
    ElderScrollsOfAlts:CraftTipExit(self)
  end)
  eline.datatype = "Trade"
end


function ElderScrollsOfAlts.GuiCharLineLookupDisplayType(view,viewKey,lineName,parent)
  local line = nil
  -- ESOA_GUI2_Body_ListHolder_Line_"..charName    
  --local eline = parent:GetNamedChild('_'..entry )    
  --    if(eline==nil)then
  --      eline = WINDOW_MANAGER:CreateControlFromVirtual(lineName.."_"..entry, parent, "ESOA_RowTemplate_Label")        
  --    end
  if(viewKey=="Special" or viewKey=="Alliance" or viewKey=="Note") then
    line = parent:GetNamedChild('_'..viewKey)
    if(line==nil)then
      line = WINDOW_MANAGER:CreateControlFromVirtual(lineName.."_"..viewKey, parent, "ESOA_RowTemplate_Texture")
    end
  else
    line = parent:GetNamedChild('_'..viewKey )
    if(line==nil)then
      line = WINDOW_MANAGER:CreateControlFromVirtual(lineName.."_"..viewKey, parent, "ESOA_RowTemplate_Label")      
    end
    line:SetText( ElderScrollsOfAlts.GuiSortBarLookupDisplayText(viewKey) )--TODO get function to get display name            
  end
  return line
end

--What's this used for?
function ElderScrollsOfAlts.GuiSortBarLookupSearchText(viewKey)
  if(viewKey=="Smithing") then
    return "blacksmithing"
  end
  return viewKey
end

function ElderScrollsOfAlts.GuiSortBarLookupSortText(viewKey)
  if(viewKey==nil) then return nil end
  --viewKey = viewKey:lower()
  if(viewKey=="Clothier Research 1") then
    return "rclothier1S"
  elseif(viewKey=="Clothier Research 2") then
    return "rclothier2S"
  elseif(viewKey=="Clothier Research 3") then
    return "rclothier3S"
  elseif(viewKey=="Blacksmithing Research 1") then
    return "rblacksmithing1S"
  elseif(viewKey=="Blacksmithing Research 2") then
    return "rblacksmithing2S"
  elseif(viewKey=="Blacksmithing Research 3") then
    return "rblacksmithing3S"
  elseif(viewKey=="Woodworking Research 1") then
    return "rwoodworking1S"
  elseif(viewKey=="Woodworking Research 2") then
    return "rwoodworking2S"
  elseif(viewKey=="Woodworking Research 3") then
    return "rwoodworking3S"
  elseif(viewKey=="Jewelcrafting Research 1") then
    return "rjewelcrafting1S"
  elseif(viewKey=="Jewelcrafting Research 2") then
    return "rjewelcrafting2S"
  elseif(viewKey=="Jewelcrafting Research 3") then
    return "rjewelcrafting3S"
  elseif(viewKey=="bagspaceFree" or viewKey=="bagspacefree" or viewKey=="BagSpaceFree") then
    return "backpackFree"
  elseif(viewKey=="bagspace" or viewKey=="BagSpace") then
    return "backpackSize"
  elseif(viewKey=="Head" or viewKey=="Shoulders" or viewKey=="Chest" or viewKey=="Waist" or viewKey=="Legs" or viewKey=="Hands" or viewKey=="Feet" ) then
    return viewKey
  elseif(viewKey=="Neck" or viewKey=="Ring1" or viewKey=="Ring2" ) then
    return viewKey
  elseif(viewKey=="M1" or viewKey=="M2" or viewKey=="Mp" or viewKey=="O1" or viewKey=="O2" or viewKey=="Op" ) then
    return viewKey
  elseif(viewKey=="Riding Speed" or viewKey=="Riding Stamina" or viewKey=="Riding Inventory") then
    return viewKey:gsub(" ","_"):lower()
  elseif( viewKey=="Riding Timer") then  
    return "riding_timeMs"
  elseif( viewKey=="Vampire" or viewKey=="Werewolf") then  
    return viewKey
  elseif(viewKey=="Assault" or viewKey=="Support" or viewKey=="Legerdemain" or viewKey=="Soul Magic" or viewKey=="Werewolf" or viewKey=="Vampire" or viewKey=="Fighters Guild" or viewKey=="Mages Guild" or viewKey=="Undaunted" or viewKey=="Thieves Guild" or viewKey=="Dark Brotherhood" or viewKey=="Psijic Order") then
    return viewKey.."_Rank"
  end
  return viewKey:lower()
end

function ElderScrollsOfAlts.GuiSortBarLookupDisplayWidth(viewKey)
  if(viewKey=="Name") then
    return ElderScrollsOfAlts.altData.fieldWidthForName
  elseif(viewKey=="Special") then
    return 24
  elseif(viewKey=="SpecialBiteTimer") then
    return 60
  elseif(viewKey=="SecondsPlayed" or viewKey=="TimePlayed") then  
    return 60
  elseif(viewKey=="Alliance") then
    return 25
  elseif(viewKey=="Note") then
    return 35
  elseif(viewKey=="Class") then
    return 60
  elseif(viewKey=="Level") then
    return 40
  elseif(viewKey=="Race") then
    return 75
  elseif(viewKey=="Gender") then
    return 25
  elseif(viewKey=="Alchemy" or viewKey=="Smithing" or viewKey=="Clothing" or viewKey=="Enchanting" or viewKey=="JC" or viewKey=="Jewelry" or viewKey=="Woodworking" or viewKey=="Provisioning") then
    return 45
  elseif(viewKey=="BagSpace") then
    return 60
  elseif(viewKey=="BagSpaceFree") then
    return 45
  elseif(viewKey=="Skillpoints") then
    return 45
  elseif(viewKey=="Assault" or viewKey=="Support" or viewKey=="Legerdemain" or viewKey=="Soul Magic" or viewKey=="Werewolf" or viewKey=="Vampire" or viewKey=="Fighters Guild" or viewKey=="Mages Guild" or viewKey=="Undaunted" or viewKey=="Thieves Guild" or viewKey=="Dark Brotherhood" or viewKey=="Psijic Order") then
    return 45
  elseif(viewKey=="Riding Speed" or viewKey=="Riding Stamina" or viewKey=="Riding Inventory") then
    return 35
  elseif(viewKey=="Riding Timer") then
    return 60
  elseif(viewKey=="Clothier Research 1" or viewKey=="Clothier Research 2" or viewKey=="Clothier Research 3") then
    return 65
  elseif(viewKey=="Blacksmithing Research 1" or viewKey=="Blacksmithing Research 2" or viewKey=="Blacksmithing Research 3") then
    return 65
  elseif(viewKey=="Woodworking Research 1" or viewKey=="Woodworking Research 2" or viewKey=="Woodworking Research 3") then
    return 65
  elseif(viewKey=="Jewelcrafting Research 1" or viewKey=="Jewelcrafting Research 2" or viewKey=="Jewelcrafting Research 3") then
    return 65
  elseif(viewKey=="Heavy" or viewKey=="Medium" or viewKey=="Light") then        
    return 30
  elseif(viewKey=="Head" or viewKey=="Shoulders" or viewKey=="Chest" or viewKey=="Waist" or viewKey=="Legs" or viewKey=="Hands" or viewKey=="Feet" ) then
    return 35
  elseif(viewKey=="Neck" or viewKey=="Ring1" or viewKey=="Ring2" ) then
    return 30
  elseif(viewKey=="M1" or viewKey=="M2" or viewKey=="Mp" or viewKey=="O1" or viewKey=="O2" or viewKey=="Op" ) then
    return 30
  --
  else
    return 100
  end
end

function ElderScrollsOfAlts.GuiSortBarLookupDisplayText(viewKey)
  if(viewKey=="Special") then
    return "Spc"    
  elseif(viewKey=="SpecialBiteTimer") then
    return "Bite"
  elseif(viewKey=="SecondsPlayed" ) then
    return "STime"    
  elseif(viewKey=="TimePlayed" ) then
    return "PTime"    
  elseif(viewKey=="Alliance") then
    return "Aly"
  elseif(viewKey=="Note") then
    return "Note"
  elseif(viewKey=="Class") then
    return "Class"
  elseif(viewKey=="Level") then
    return "Lvl"
  elseif(viewKey=="Gender") then
    return "G"
  elseif(viewKey=="Alchemy") then
    return "Alc"
  elseif(viewKey=="Smithing") then
    return "Smth"
  elseif(viewKey=="Clothing") then
    return "Clth"
  elseif(viewKey=="JC" or viewKey=="Jewelry") then
    return "JC"
  elseif(viewKey=="Provisioning") then
    return "Prov"
  elseif(viewKey=="Woodworking") then
    return "Wood"
  elseif(viewKey=="Enchanting") then
    return "Ench"    
  elseif(viewKey=="BagSpace") then
    return "Bags"
  elseif(viewKey=="BagSpaceFree") then
    return "B.Free"
  elseif(viewKey=="Skillpoints") then
    return "SkPt"
    
  elseif(viewKey=="Assault") then
    return "Asslt"
  elseif(viewKey=="Support") then
    return "Spprt"
  elseif(viewKey=="Legerdemain") then
    return "Lege"
  elseif(viewKey=="Soul Magic") then
    return "Soul"
  elseif(viewKey=="Werewolf") then
    return "Were"
  elseif(viewKey=="Vampire") then
    return "Vamp"
  elseif(viewKey=="Fighters Guild") then
    return "Fight"
  elseif(viewKey=="Mages Guild") then
    return "Mage"
  elseif(viewKey=="Undaunted") then
    return "Unda"
  elseif(viewKey=="Thieves Guild") then
    return "Thief"
  elseif(viewKey=="Dark Brotherhood") then
    return "Dark"
  elseif(viewKey=="Psijic Order") then
    return "Psij"
  elseif(viewKey=="Riding Speed") then
    return "Spee"
  elseif(viewKey=="Riding Stamina") then
    return "RStam"
  elseif(viewKey=="Riding Inventory") then
    return "RInve"
  elseif(viewKey=="Riding Timer") then
    return "RTime"
  elseif(viewKey=="Clothier Research 1") then
    return "Cloth1"
  elseif(viewKey=="Clothier Research 2") then
    return "Cloth2"
  elseif(viewKey=="Clothier Research 3") then
    return "Cloth3"
  elseif(viewKey=="Blacksmithing Research 1") then
    return "Smith1"
  elseif(viewKey=="Blacksmithing Research 2") then
    return "Smith2"
  elseif(viewKey=="Blacksmithing Research 3") then
    return "Smith3"
  elseif(viewKey=="Woodworking Research 1") then
    return "Wood1"
  elseif(viewKey=="Woodworking Research 2") then
    return "Wood2"
  elseif(viewKey=="Woodworking Research 3") then
    return "Wood3"
  elseif(viewKey=="Jewelcrafting Research 1") then
    return "JC1"
  elseif(viewKey=="Jewelcrafting Research 2") then
    return "JC2"
  elseif(viewKey=="Jewelcrafting Research 3") then
    return "JC3"

  else
    return viewKey
  end
end

-- HELPER -- 
-----------
