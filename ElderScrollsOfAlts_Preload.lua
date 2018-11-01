

--
function ElderScrollsOfAlts:InitText(textKey,defaultValue)
  local textVal = GetString(textKey)
  if(textVal~=nil) then
    return textVal
  end
  return defaultValue
end