
function ElderScrollsOfAlts:debugMsg(text)
    if text == nil then
      return
    end  
	if ElderScrollsOfAlts.altData.debug then
		d("(" .. ElderScrollsOfAlts.name .. ") " .. text);
	end
end
function ElderScrollsOfAlts.debugMsg(self,text)
    if text == nil then
      return
    end
    if ElderScrollsOfAlts.altData.debug then
      d("(" .. ElderScrollsOfAlts.name .. ") " .. text);
    end
end

function ElderScrollsOfAlts:getColoredString(color, s)
	local c = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, color))
	return c:Colorize(s)
end

--
function ElderScrollsOfAlts:InitText(self,textKey,defaultValue)
  local textVal = GetString(textKey)
  if(textVal~=nil) then
    self:SetText(textVal)
  end
  if(defaultValue~=nil) then
    self:SetText(defaultValue)
  end
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

--
function ElderScrollsOfAlts:GetAllianceIcon(alliance)
  --if( alliance == 1 ) then
  --else if XXX then
  --end
  return ZO_GetAllianceIcon(alliance)
end

-- Wraps text with a color.
function ElderScrollsOfAlts.Colorize(text, color)
    -- Default to addon's .color.
    if not color then color = ElderScrollsOfAlts.color end
    text = "|c" .. color .. text .. "|r"
    return text
end

--[[
function ElderScrollsOfAlts:tabletostring(t)
  d("tabletostring called ")
   for key,value in pairs(t) do print(key,value) end
   for key,value in ipairs(t) do print(key,value) end
end
]]--

function ElderScrollsOfAlts:has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function ElderScrollsOfAlts:matchStringList(str,itemlist)
  for _, v in ipairs(itemlist) do
      if v == str then
          return true
      end
  end
  return false;
end

function ElderScrollsOfAlts:timeToDisplay(timeMS,incDay,incSec)
  if(timeMS==nil)then
    return "--"
  end
  --d("GetTimeMS="..tostring(GetFrameTimeMilliseconds()) .. " timeDataTaken="..tostring(timeDataTaken))
  --d("nowDiff="..tostring(nowDiff) .. " timeMS="..tostring(timeMS) )

  local timeS  = math.floor(timeMS/1000)
  local timeM  = math.floor(timeS/60)
  local timeH  = math.floor(timeM/60)
  local timeD  = math.floor(timeH/24)
  if(timeH>0) then
    timeM = timeM - (timeH*60)
  end
  if(timeD>0) then
    timeH = timeH - (timeD*24)
  end
  local hdrStr = ""
  if(incDay and incSec)then
    hdrStr = string.format("%sd%sh%sm%ss", timeD, timeH, timeM, timeS)
  elseif(incDay)then
    hdrStr = string.format("%sd%sh%sm",    timeD, timeH, timeM)
  elseif(incSec)then
    hdrStr = string.format("%sh%sm%ss",    timeH, timeM, timeS)
  else
    hdrStr = string.format("%sh%sm",       timeH, timeM)
  end
  return hdrStr
end
