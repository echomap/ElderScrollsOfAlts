
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


function ElderScrollsOfAlts:tabletostring(t)
  d("tabletostring called ")
   for key,value in pairs(t) do print(key,value) end
   for key,value in ipairs(t) do print(key,value) end
end