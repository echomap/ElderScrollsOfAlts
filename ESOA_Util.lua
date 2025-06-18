--[[ ESOA Utils ]]-- 
 
----------------------------------------
-- Utility Functions 
----------------------------------------

------------------------------
--
function ElderScrollsOfAlts.errorMsg(text)
  d("(" .. ElderScrollsOfAlts.name .. ") " .. text )
end

------------------------------
-- 
function ElderScrollsOfAlts.starts_with(str, start)
  return str:sub(1, #start) == start
end

------------------------------
-- 
function ElderScrollsOfAlts.ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

------------------------------
-- 
function ElderScrollsOfAlts:istable(t)
  return type(t) == 'table'
end

------------------------------
--
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
  local val = zo_strformat( "(<<1>>) <<2>>",ElderScrollsOfAlts.name,printResult)
  d(val)
end

------------------------------
--
function ElderScrollsOfAlts.outputMsg(...)
  local arg={...}
  if arg == nil then
    return
  end
  local printResult = ""
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

------------------------------
--
function ElderScrollsOfAlts:matchStringList(str,itemlist)
  if(itemlist==nil) then
	return false
  end
  for _, v in ipairs(itemlist) do
      if v == str then
          return true
      end
  end
  return false;
end

------------------------------
--
function ElderScrollsOfAlts:has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

------------------------------
--
function ElderScrollsOfAlts:tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


------------------------------
-- Sets my(self)'s text if isnt null, or sets default
function ElderScrollsOfAlts:InitText(self,textKey,defaultValue)
  local textVal = GetString(textKey)
  if(textVal~=nil) then
    self:SetText(textVal)
  end
  if(defaultValue~=nil) then
    self:SetText(defaultValue)
  end
end

------------------------------
--
function ElderScrollsOfAlts:deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[ElderScrollsOfAlts:deepcopy(orig_key)] = ElderScrollsOfAlts:deepcopy(orig_value)
        end
        setmetatable(copy, ElderScrollsOfAlts:deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

------------------------------
-- TODO not used, remove
function ElderScrollsOfAlts:getColoredString(color, s)
	local c = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, color))
	return c:Colorize(s)
end

------------------------------
--
function ElderScrollsOfAlts.ColorText(colors,text)
	--colorized text and write it out
	--check cache
	if(colors==nil) then
		return text
	end
	if(text==nil) then
		return text
	end
	local cCD = nil
	if(colors.r==nil) then
		cCD = ZO_ColorDef:New( colors[1], colors[2], colors[3], colors[4] )
	else
		cCD = ZO_ColorDef:New(colors.r, colors.g, colors.b, colors.a)
	end
	local text2 = cCD:Colorize(text)
	return text2
end

------------------------------
-- Wraps text with a color.
function ElderScrollsOfAlts.Colorize(text, color)
    -- Default to addon's .color.
    if not color then color = ElderScrollsOfAlts.color end
    text = "|c" .. color .. text .. "|r"
    return text
end

------------------------------
-- IN: Milliseconds
function ElderScrollsOfAlts:timeToDisplay(timeMS,incDay,incSec)
  if(timeMS==nil)then
    return "--"
  end
  --debugMsg("GetTimeMS="..tostring(GetFrameTimeMilliseconds()) .. " timeDataTaken="..tostring(timeDataTaken))
  --debugMsg("nowDiff="..tostring(nowDiff) .. " timeMS="..tostring(timeMS) )
  local totalS = math.floor(timeMS/1000)
  local timeM  = math.floor(totalS/60)
  local timeH  = math.floor(timeM/60)
  local timeD  = math.floor(timeH/24)
  local timeS  = math.floor(timeMS/1000)
  if(timeM>0) then
    timeS = math.floor( totalS - (timeM*60) )
  end  
  if(timeH>0) then
    timeM = timeM - (timeH*60)
    totalS = totalS - (timeM*60)
    if(totalS<0) then totalS=0 end
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
    hdrStr = string.format("%sh%sm%ss",    timeH, timeM, timeS)
  else
    hdrStr = string.format("%sh%sm",       timeH, timeM)
  end
  return hdrStr
end

--From DolgubonsWritCrafter!!!
-- HOW the HECK does this work??? TODO
--TODO NA vs EU
function ElderScrollsOfAlts:dailyReset()
	stamp = GetTimeStamp()
	local date = {}
	local day = 86400
	local hour = 3600
	local till = {}
	stamp = stamp-1451606400
	stamp = stamp%day
	date["hour"] = math.floor(stamp/hour)
	stamp = stamp%hour
	date["minute"] = math.floor(stamp/60)
	stamp = stamp%60
	ElderScrollsOfAlts.debugMsg("DATE 1: hour="..tostring(date["hour"]) .. " min=".. tostring(date["minute"]) )
	if date["hour"]>5 then 
		till["hour"] = 24-date["hour"]+5
	else
		till["hour"] = 6- date["hour"] -1
	end
	till["minute"] = 60-date["minute"]
	ElderScrollsOfAlts.debugMsg("TILL 2: hour="..tostring(till["hour"]) .. " min=".. tostring(till["minute"]) )
	return till["hour"], till["minute"]
	--TODO NA vs EU
	--return 5, 0
end

function ElderScrollsOfAlts:GetFontDescriptor(font)
    ElderScrollsOfAlts.debugMsg("font type='"  ..tostring(font[ElderScrollsOfAlts.FONT_TYPE])  .."'")
    ElderScrollsOfAlts.debugMsg("font style='" ..tostring(font[ElderScrollsOfAlts.FONT_STYLE]) .."'")
    ElderScrollsOfAlts.debugMsg("font size='"  ..tostring(font[ElderScrollsOfAlts.FONT_SIZE])  .."'")
    ElderScrollsOfAlts.debugMsg("font weight='"..tostring(font[ElderScrollsOfAlts.FONT_WEIGHT]).."'")
	--
	--local preFont = ESOAFontBold
	--ElderScrollsOfAlts.debugMsg("font preFont='"..tostring(preFont).."'")
	--
	local fontPath = font[ElderScrollsOfAlts.FONT_TYPE] == "custom" and font[ElderScrollsOfAlts.FONT_STYLE] or font[ElderScrollsOfAlts.FONT_TYPE]
    ElderScrollsOfAlts.debugMsg("fontPath='"..tostring(fontPath).."'")
	--
	if font[ElderScrollsOfAlts.FONT_WEIGHT] and font[ElderScrollsOfAlts.FONT_WEIGHT] ~= "normal" then
		local str = string.format("%s|%s|%s", fontPath, font[ElderScrollsOfAlts.FONT_SIZE], font[ElderScrollsOfAlts.FONT_WEIGHT])
		ElderScrollsOfAlts.debugMsg("font str='"..(str).."'")
		return str
	else
		local str =  string.format("%s|%s", fontPath, font[ElderScrollsOfAlts.FONT_SIZE])
		ElderScrollsOfAlts.debugMsg("font str='"..(str).."'")
		return str
	end
end

--
function ElderScrollsOfAlts:getValueOrDefault(baseValue,defaultValue)
  if(baseValue==nil) then
    return defaultValue
  else
    return baseValue
  end
end

--
function ElderScrollsOfAlts:dumpTable(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. ElderScrollsOfAlts:dumpTable(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--
function ElderScrollsOfAlts:dumpPrintTable(o)
   if type(o) == 'table' then
    d('')
	ElderScrollsOfAlts.outputMsg( "{" )
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
		 ElderScrollsOfAlts.outputMsg( "[",k,"] =", ElderScrollsOfAlts:dumpPrintTable(v), ",")
      end
	  ElderScrollsOfAlts.outputMsg( "} " )
   else
      d( tostring(o) )
   end
end


------------------------------
-- EOF