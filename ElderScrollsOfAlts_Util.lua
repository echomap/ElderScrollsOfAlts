
function ElderScrollsOfAlts:debugMsg(text)
    if text == nil then
      return
    end  
	if ElderScrollsOfAlts.debug then
		d("(" .. ElderScrollsOfAlts.name .. ") " .. text);
	end
end
function ElderScrollsOfAlts.debugMsg(self,text)
    if text == nil then
      return
    end
    if ElderScrollsOfAlts.debug then
      d("(" .. ElderScrollsOfAlts.name .. ") " .. text);
    end
end

function ElderScrollsOfAlts:getColoredString(color, s)
	local c = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, color))
	return c:Colorize(s)
end

function ElderScrollsOfAlts:GetGenderText(genderId)
  local genderName = "O"
    if genderId == 0 then
      genderName = "M"
    elseif genderId == 1 then
      genderName ="F"
    end
    return genderName
end

function ElderScrollsOfAlts:GetClassText(className)
  local classX = "UK"
    if className == "Dragonknight" then
      classX = "DK"
    elseif className == "Sorcerer" then
      classX ="Sorc"
    elseif className == "Nightblade" then
      classX ="Night"
    elseif className == "Templar" then
      classX ="Temp"
    elseif className == "Warden" then
      classX ="Ward"
    end
    return classX
end

function ElderScrollsOfAlts:GetRaceText1(raceName)
  local raceX = raceName
    if raceName == "High Elf" then
      raceX = "H.Elf"
    elseif raceName == "Wood Elf" then
      raceX ="W.Elf"
    elseif raceName == "Khajiit " then
      raceX ="Kaji"
    elseif raceName == "Argonian " then
      raceX ="Argon"
    elseif raceName == "Dark Elf" then
      raceX ="D.Elf"
    end
    return raceX
end
function ElderScrollsOfAlts:GetRaceText2(raceName)
  local raceX = "UK"
    if raceName == "High Elf" then
      raceX = "High"
    elseif raceName == "Wood Elf" then
      raceX ="Wood"
    elseif raceName == "Khajiit " then
      raceX ="Kaj"
    elseif raceName == "Argonian " then
      raceX ="Argo"
    elseif raceName == "Nord " then
      raceX ="Nord"
    elseif raceName == "Dark Elf" then
      raceX ="Dark"
    elseif raceName == "Breton " then
      raceX ="Breton"
    elseif raceName == "Orc " then
      raceX ="Orc"
    elseif raceName == "Redguard " then
      raceX ="Red"      
    end
    return raceX
end

-- Wraps text with a color.
function ElderScrollsOfAlts.Colorize(text, color)
    -- Default to addon's .color.
    if not color then color = ElderScrollsOfAlts.color end
    text = "|c" .. color .. text .. "|r"
    return text
end

function ElderScrollsOfAlts:tabletostring(t)
  d("tabletostring called ")
   for key,value in pairs(t) do print(key,value) end
   for key,value in ipairs(t) do print(key,value) end
end

function ElderScrollsOfAlts:matchStringList(str,itemlist)
  for _, v in ipairs(itemlist) do
      if v == str then
          return true
      end
  end
  return false;
end