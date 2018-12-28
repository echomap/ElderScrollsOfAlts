--
--name
--menuName

function ElderScrollsOfAlts:GetUIButtonShown()
   return ElderScrollsOfAlts.savedVariables.uibutton.shown
end

function ElderScrollsOfAlts:SetUIButtonShown(value)
  ElderScrollsOfAlts.savedVariables.uibutton.shown = value
  if not value then
    ElderScrollsOfAlts.HideUIButton()
  else
    ElderScrollsOfAlts.ShowUIButton()
  end  
end

--Returns a list of character names
function ElderScrollsOfAlts:ListOfCharacterNames()
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  if ElderScrollsOfAlts.altData.players ~= nil then
    for k, v in pairs(ElderScrollsOfAlts.altData.players) do
      --debugMsg(ElderScrollsOfAlts.name .. " k " .. k)
      table.insert(validChoices, k ) --v.rawname)--v.bio.name )
    end
  end
  return validChoices 
end


--SETTINGS For use by Settings dropdown
function ElderScrollsOfAlts:SelectCharacterName(choiceText)
  ElderScrollsOfAlts.savedVariables.selected.charactername = choiceText
end


--SETTINGS For use by Settings dropdown
function ElderScrollsOfAlts:DoDeleteSelectedCharacter()
  local charname = ElderScrollsOfAlts.savedVariables.selected.charactername
  ElderScrollsOfAlts:debugMsg("DoDeleteSelectedCharacter: Name=" .. tostring(charname))
  if(ElderScrollsOfAlts.altData.players[charname]~=nil)then
    ElderScrollsOfAlts.altData.players[charname] = nil
    ElderScrollsOfAlts.outputMsg("ESOA deleted character: Name=" .. tostring(charname) )
  end
end


--EOF