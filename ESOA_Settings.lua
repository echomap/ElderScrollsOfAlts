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
    local vals = ElderScrollsOfAlts:SettingsListOfViews()
    myFpsLabelControl:UpdateChoices(vals )
  else
    ElderScrollsOfAlts.outputMsg("WARN: Dropdown not found, changes will not be reflected until /reloadui")
  end

end

function ElderScrollsOfAlts:DoDeleteSelectedView()
  --TODO
end

function ElderScrollsOfAlts:DoAddNewViewData()
  local newView= {}
  newView["name"] = "New View"
  newView["view"] = ElderScrollsOfAlts:deepcopy( ElderScrollsOfAlts.view.guiTemplates["Home"]["view"] )
  table.insert( ElderScrollsOfAlts.savedVariables.gui, newView )
  ElderScrollsOfAlts:RefreshSettingsDropdowns()
end

function ElderScrollsOfAlts:DoTestSelectedView()
--TODO
end

--Save DATA from FORM
function ElderScrollsOfAlts:DoSaveSelectedView()
  --TODO
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    guiLine["name"] = ElderScrollsOfAlts.view.SettingsViewName
    --guiLine["view"] = ElderScrollsOfAlts.view.SettingsViewData 
    local viewText = (ElderScrollsOfAlts.view.SettingsViewData)
    ElderScrollsOfAlts.debugMsg("DoSaveSelectedView: viewText=", viewText)
    local tempTable = {}
    --for k, v in string.gmatch(tostring(viewText), "(%b{})" ) do    
    for k, v in viewText:gmatch("(%b{})" ) do    
      local val = tostring(k)
      val = val:gsub("{","")
      val = val:gsub("}","")
      table.insert( tempTable, val  )
      --tempTable[tostring(k)] = tostring(k)
      ElderScrollsOfAlts.outputMsg("DoSaveSelectedView: match k=",tostring(k)," v=", tostring(v) )
    end
    --TODO output fails etc
    --for kk,vv in pairs(tempTable) do
    --  ElderScrollsOfAlts.outputMsg( "tempTable: k="..tostring(kk).." v=",tostring(vv) )
    --end
    --Test names, check in ElderScrollsOfAlts.allowedViewEntries
    local goodEntries = {}
    for kk,vv in pairs(tempTable) do
      local fEntry = ElderScrollsOfAlts.allowedViewEntries[tostring(vv)]      
      ElderScrollsOfAlts.outputMsg( "Check value: k="..tostring(kk).." v="..tostring(vv) )
      if(fEntry~=nil)then
        ElderScrollsOfAlts.outputMsg( "Validated")
        table.insert(goodEntries, tostring(vv) )
      else
        ElderScrollsOfAlts.outputMsg("DoSaveSelectedView: entry failed as k="..tostring(kk).." v="..tostring(vv))
      end
    end
    guiLine["view"] = goodEntries
  
    for k2,v2 in pairs(guiLine.view) do
      ElderScrollsOfAlts.outputMsg("DoSaveSelectedView: k="..tostring(k2).." v="..tostring(v2) )
    end
    --TODO
    --ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx].name = ElderScrollsOfAlts.view.newViewName
    --ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx].veiw = ElderScrollsOfAlts.view.newViewEntry
  else
    ElderScrollsOfAlts.outputMsg("DoSaveSelectedView: Can't find data line")
  end
end--DoSaveSelectedView

--Edit button puts data into FORM
function ElderScrollsOfAlts:DoEditSelectedView()
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  local viewText = ""
  if(guiLine~=nil)then
    --ElderScrollsOfAlts.outputMsg("Edit view found as <".. tostring(guiLine.name)..">" )
    --test guiLine
    --translate guiLine
    ElderScrollsOfAlts.view.SettingsViewName = guiLine.name
    local vName = guiLine["name"]
    local vView = guiLine["view"]
    --ElderScrollsOfAlts.outputMsg("Edit view text as <".. tostring(vName)..">" )
    --
    if(vView~=nil)then
      for i = 1, #vView do
        local entry = vView[i]      
        viewText = zo_strformat( "<<1>>{<<2>>} ", viewText, entry )
      end
    end    
  end
  ElderScrollsOfAlts.view.SettingsViewData = viewText
end

function ElderScrollsOfAlts:GetEditSelectedViewName()
  local retVal = ElderScrollsOfAlts.view.SettingsViewName
  --[[
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    --ElderScrollsOfAlts.outputMsg("Edit view name as <".. tostring(guiLine.name)..">" )
    retVal = (guiLine.name)
  end
  --]]
  return retVal
end

function ElderScrollsOfAlts:SetEditSelectedViewName(newName)
  --[[
  local guiLine = ElderScrollsOfAlts.savedVariables.gui[ElderScrollsOfAlts.savedVariables.selected.viewidx]
  if(guiLine~=nil)then
    guiLine["name"] = newName
    ElderScrollsOfAlts.view.newViewName = newName
  end 
  --]]
  ElderScrollsOfAlts.view.SettingsViewName = newName
end

--Called when Box looses focus
function ElderScrollsOfAlts.SetEditSelectedViewText(newText)
  ElderScrollsOfAlts.view.SettingsViewData = newText
  ElderScrollsOfAlts.debugMsg("SetEditSelectedViewText: set text as=",newText)
end

function ElderScrollsOfAlts.GetEditSelectedViewText()
  return (ElderScrollsOfAlts.view.SettingsViewData)
end


--EOF