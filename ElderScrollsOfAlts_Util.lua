
function ElderScrollsOfAlts.debugMsg(text)
	if ElderScrollsOfAlts.debug then
		d("(" .. ElderScrollsOfAlts.name .. ") " .. text);
	end
end

function ElderScrollsOfAlts:getColoredString(color, s)
	local c = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, color))
	return c:Colorize(s)
end


function ElderScrollsOfAlts:GetGenderText(genderId)
  local genderName = "They"
    if genderId == 0 then
      genderName = "Male"
    elseif genderId == 1 then
      genderName ="Female"
    end
    return genderName
end

