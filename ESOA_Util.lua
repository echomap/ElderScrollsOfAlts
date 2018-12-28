-----------
--ESOA UTIL
-----------

function ElderScrollsOfAlts.outputMsg(text)
  d("(" .. ElderScrollsOfAlts.name .. ") " .. text )
end

function ElderScrollsOfAlts.errorMsg(text)
  d("(" .. ElderScrollsOfAlts.name .. ") " .. text )
end

function ElderScrollsOfAlts.debugMsg(...)
  if not ElderScrollsOfAlts.altData.debug then
    return
  end
  local arg={...}
  if arg == nil then
    return
  end
  --debugMsg("arg="..tostring(arg))
  --debugMsg("argtype='"..type(arg) .."'")
  local printResult = ""
  --if(type(arg)==nil) then
  --elseif(type(arg) == "string")then
  --  debugMsg("(" .. ElderScrollsOfAlts.name .. ") " .. arg );
  --  return
  --end
  if(arg~=nil)then
    for i,v in ipairs(arg) do
      if(v==nil) then 
        printResult = printResult .. "nil"
      else
        printResult = printResult .. tostring(v) --.. " "
      end
    end
  end

  if printResult == nil then
    return
  end  
	d("(" .. ElderScrollsOfAlts.name .. ") " .. printResult )
end

function ElderScrollsOfAlts:matchStringList(str,itemlist)
  for _, v in ipairs(itemlist) do
      if v == str then
          return true
      end
  end
  return false;
end

function ElderScrollsOfAlts:has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end
--Sets my(self)'s text if isnt null, or sets default
function ElderScrollsOfAlts:InitText(self,textKey,defaultValue)
  local textVal = GetString(textKey)
  if(textVal~=nil) then
    self:SetText(textVal)
  end
  if(defaultValue~=nil) then
    self:SetText(defaultValue)
  end
end

function ElderScrollsOfAlts:deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[EchoExperience:deepcopy(orig_key)] = EchoExperience:deepcopy(orig_value)
        end
        setmetatable(copy, EchoExperience:deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
--
function ElderScrollsOfAlts:getColoredString(color, s)
	local c = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, color))
	return c:Colorize(s)
end

-- Wraps text with a color.
function EchoesOfLore.Colorize(text, color)
    -- Default to addon's .color.
    if not color then color = EchoesOfLore.color end
    text = "|c" .. color .. text .. "|r"
    return text
end

function ElderScrollsOfAlts:timeToDisplay(timeMS,incDay,incSec)
  if(timeMS==nil)then
    return "--"
  end
  --debugMsg("GetTimeMS="..tostring(GetFrameTimeMilliseconds()) .. " timeDataTaken="..tostring(timeDataTaken))
  --debugMsg("nowDiff="..tostring(nowDiff) .. " timeMS="..tostring(timeMS) )

  local timeS  = math.floor(timeMS/1000)
  local timeM  = math.floor(timeS/60)
  local timeH  = math.floor(timeM/60)
  local timeD  = math.floor(timeH/24)
  if(timeH>0) then
    timeM = timeM - (timeH*60)
    timeS = timeS - (timeM*60)
    if(timeS<0) then timeS=0 end
  end
  if(timeD>0) then
    timeH = timeH - (timeD*24)
  end
  local hdrStr = ""
  if(incDay and incSec)then
    hdrStr = string.format("%sd%sh%sm", timeD, timeH, timeM, timeS)
  elseif(incDay)then
    hdrStr = string.format("%sd%sh%sm",    timeD, timeH, timeM)
  elseif(incSec)then
    hdrStr = string.format("%sh%sm",    timeH, timeM, timeS)
  else
    hdrStr = string.format("%sh%sm",       timeH, timeM)
  end
  return hdrStr
end

--EOF