--
--name
--menuName

function ElderScrollsOfAlts:GetUIButtonShown()
   return (ElderScrollsOfAlts.savedVariables.uibutton.shown)
end

function ElderScrollsOfAlts.SetUIButtonShown(value)
  ElderScrollsOfAlts.savedVariables.uibutton.shown = value
  ElderScrollsOfAlts.debugMsg("SetUIButtonShown: value=",tostring(value) )
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
      if(k~=nil) then
        local displayName = k
        if(v~=nil and v.bio~=nil) then
            displayName = k .."("..v.bio.name..")"
        end
        --debugMsg(ElderScrollsOfAlts.name .. " k " .. k)
        table.insert(validChoices, displayName ) --v.rawname)--v.bio.name )
      end
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
  --local displayName = k.."("..v.bio.name..")"
  local iStart, iEnd = string.find(charname, "%(" )
  local charKey = string.sub(charname,0,iStart-1) 
  ElderScrollsOfAlts:debugMsg("DoDeleteSelectedCharacter: charKey=" , tostring(charKey))
  if(ElderScrollsOfAlts.altData.players[charKey]~=nil)then
    ElderScrollsOfAlts.altData.players[charKey] = nil
    ElderScrollsOfAlts.outputMsg("ESOA deleted character: Name=" .. tostring(charname) )
  end
end

---VIEWS

--Returns a list of view Indexes
function ElderScrollsOfAlts:SettingsListOfViews()
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  local viewCnt = 0
  for viewIdx = 1, #ElderScrollsOfAlts.savedVariables.gui do
    local guiLine = ElderScrollsOfAlts.savedVariables.gui[viewIdx]
    local viewName = guiLine.name
    table.insert(validChoices, viewIdx)-- viewName )  
  end
  return validChoices 
end

--REMOVE
--function ElderScrollsOfAlts:SettingsSelectView(choiceText)
--  ElderScrollsOfAlts.savedVariables.selected.viewidx = choiceText
--end

function ElderScrollsOfAlts:RefreshSettingsDropdowns()
  --
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("ESOA_SETTINGS_DD_SelectView", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:SettingsListOfViews()
    myFpsLabelControl:UpdateChoices(vals )
  else
    EchoExperience.outputMsg("WARN: Dropdown not found, changes will not be reflected until /reloadui")
  end

end

function ElderScrollsOfAlts:DoDeleteSelectedView()
  --TODO
end

function ElderScrollsOfAlts:DoAddNewViewData()
  local newView= {}
  newView["name"] = "New View"
  newView["view"] = ElderScrollsOfAlts:deepcopy( ElderScrollsOfAlts.view.guiTemplates["Home"] )
  table.insert( ElderScrollsOfAlts.savedVariables.gui, newView )
  ElderScrollsOfAlts:RefreshSettingsDropdowns()
end

--Save DATA from FORM
function ElderScrollsOfAlts:DoSaveSelectedView()
  --TODO
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil and guiLine.view~=nil)then
    for k,v in pairs(guiLine.view) do
      ElderScrollsOfAlts.outputMsg( "DoSaveSelectedView: k="..k.." v="..v)
    end
    --TODO
    --ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx].name = ElderScrollsOfAlts.view.newViewName
    --ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx].veiw = ElderScrollsOfAlts.view.newViewEntry
  end
end

--Edit button puts data into FORM
function ElderScrollsOfAlts:DoEditSelectedView()
  local myViewEditControl = WINDOW_MANAGER:GetControlByName("ESOASettingsViewEditbox", "")
  if(myViewEditControl~=nil) then
    --test ElderScrollsOfAlts.savedVariables.selected.viewidx
    local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
    --ElderScrollsOfAlts.outputMsg("Edit view found as <".. tostring(guiLine.name)..">" )
    --test guiLine
    --tranlsate guiLine
    myViewEditControl:UpdateValue(false, guiLine.name)
  else
    ElderScrollsOfAl5ts.outputMsg("No edit view found to output data to")
  end
end

function ElderScrollsOfAlts:GetEditSelectedViewName()
  local retVal = ""
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    --ElderScrollsOfAlts.outputMsg("Edit view name as <".. tostring(guiLine.name)..">" )
    retVal = (guiLine.name)
  end
  return retVal
end

function ElderScrollsOfAlts:SetEditSelectedViewName(newName)
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    guiLine["name"] = newName
    ElderScrollsOfAlts.view.newViewName = newName
  end  
end

--Called when Box looses focus
function ElderScrollsOfAlts:SetEditSelectedViewText(newText)
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    local t = {}
    --s = "{one}{two}"
    for k, v in string.gmatch(newText, "(%b{})" ) do    
      t[k] = v
    end
    for k,v in pairs(t) do
      ElderScrollsOfAlts.outputMsg( "k="..k.." v="..v)
    end
    --Test names, check in ElderScrollsOfAlts.allowedViewEntries
    local goodEntries = {}
    for k,v in pairs(t) do
      local fEntry = ElderScrollsOfAlts.allowedViewEntries [v]
      if(fEntry~=nil)then
        table.insert(goodEntries,fEntry)
      end
    end
    ElderScrollsOfAlts.view.newViewEntry = goodEntries
  end
end

function ElderScrollsOfAlts:GetEditSelectedViewText()
  local retVal = ""
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    local vName = guiLine["name"]
    local vView = guiLine["view"]
    --ElderScrollsOfAlts.outputMsg("Edit view text as <".. tostring(vName)..">" )
    --
    if(vView~=nil)then
      retVal = ""
      for i = 1, #vView do
        local entry = vView[i]      
        retVal = zo_strformat( "<<1>>{<<2>>} ", retVal, entry )
      end
    else
      retVal = (vName)
    end
  end
  return retVal
end


--EOF