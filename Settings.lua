-- Settings menu.
function ElderScrollsOfAlts.LoadSettings()
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelData = {
        type = "panel",
        name = ElderScrollsOfAlts.name,
        displayName = ElderScrollsOfAlts.Colorize(ElderScrollsOfAlts.menuName),
        author = ElderScrollsOfAlts.Colorize(ElderScrollsOfAlts.author, "AAF0BB"),
        version = ElderScrollsOfAlts.Colorize(ElderScrollsOfAlts.version, "AA00FF"),
        slashCommand = "/ElderScrollsOfAlts",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LAM:RegisterAddonPanel(ElderScrollsOfAlts.menuName, panelData)

    local optionsTable = {}
    optionsTable[1] = {
            type = "header",
            name = "Main",
            width = "full",	--or "half" (optional)
    }
    optionsTable[#optionsTable+1] = {
            type = "description",
            --title = "My Title",	--(optional)
            title = nil,	--(optional)
            text = "ESOA - Options and Configuration.",
            width = "full",	--or "half" (optional)
    }
    optionsTable [#optionsTable+1] = {
            type = "checkbox",
            name = "Show Button",
            tooltip = "On or off.",
            getFunc = function() return ElderScrollsOfAlts.GetUIButtonShown() end,
            setFunc = function(value) ElderScrollsOfAlts.SetUIButtonShown(value)  end,
            width = "half",	--or "half" (optional)
    }
    optionsTable [#optionsTable+1] = {
            type = "header",
            name = "Character Maintanance",
            text = "Character Maintanance",
            tooltip = "Character Maintanance Utils",	--(optional)
    }
    optionsTable[#optionsTable+1] = {
            type = "dropdown",
            name = "Character",
            tooltip = "Select Character.",
            choices = ElderScrollsOfAlts:ListOfCharacterNames(),
            getFunc = function() return "Select" end,
            setFunc = function(var) ElderScrollsOfAlts:SelectCharacterName(var) end,
            width = "half",	--or "half" (optional)
    }
    optionsTable[#optionsTable+1] = {
            name = "Commands",
            type = "description",
            --title = "My Title",	--(optional)
            title = nil,	--(optional)
            text = "ESOA - Options and Configuration.",
            width = "full",	--or "half" (optional)
    }
    optionsTable[#optionsTable+1] = {
            type = "button",
            name = "Delete",
            tooltip = "Delete selected Character's Data!",
            func = function()  ElderScrollsOfAlts:DoDeleteSelectedCharacter() end,
            width = "full",	--or "half" (optional)
            warning = "No confirmation if you do this!",	--(optional)
    }
    -- VIEWS --
    optionsTable[#optionsTable+1] = {
      type = "header",
      name = "Views",
      width = "full",	--or "half" (optional)
    }    
    --New from template
    optionsTable[#optionsTable+1] = {
      type = "button",
      name = "NewFromTemplate",
      tooltip = "New View!",
      func = function()  ElderScrollsOfAlts:DoAddNewViewData() end,
      width = "half",	--or "half" (optional)
      warning = "No confirmation if you do this!",	--(optional)
    }
    optionsTable[#optionsTable+1] = {
      type = "dropdown",
      name = "SelectView",
      tooltip = "Select View.",
      choices = ElderScrollsOfAlts:SettingsListOfViews(),
      getFunc = function() return tostring(ElderScrollsOfAlts.savedVariables.selected.viewidx) end,
      setFunc = function(var) ElderScrollsOfAlts.savedVariables.selected.viewidx = tonumber(var) end,
      width = "full",	--or "half" (optional)
    }
    optionsTable[#optionsTable+1] = {
      type = "button",
      name = "Edit",
      tooltip = "Edit selected View!",
      func = function()  ElderScrollsOfAlts:DoEditSelectedView() end,
      width = "half",	--or "half" (optional)
      warning = "No confirmation if you do this!",	--(optional)
    }
    optionsTable[#optionsTable+1] = {
      type = "button",
      name = "Delete",
      tooltip = "Delete selected View!",
      func = function()  ElderScrollsOfAlts:DoDeleteSelectedView() end,
      width = "half",	--or "half" (optional)
      warning = "No confirmation if you do this!",	--(optional)
    }
    optionsTable[#optionsTable+1] = {
      type = "editbox",
      name = "Edit View Name",
      tooltip = "Edit selected View!",
      getFunc = function() return ElderScrollsOfAlts:GetEditSelectedViewName() end,
      setFunc = function(text) ElderScrollsOfAlts:SetEditSelectedViewName(text) end,
      width = "half",	--or "half" (optional)
      isMultiline = false,
      isExtraWide = false,
      default = "", -- default value or function that returns the default value (optional)      
      reference = "ESOASettingsTitleEditbox" -- unique global reference to control (optional)
    }
    optionsTable[#optionsTable+1] = {
      type = "editbox",
      name = "Edit View Data",
      tooltip = "Edit selected View!",
      getFunc = function() return ElderScrollsOfAlts:GetEditSelectedViewText() end,
      setFunc = function(text) ElderScrollsOfAlts:SetEditSelectedViewText(text) end,
      width = "full",	--or "half" (optional)
      isMultiline = true,
      isExtraWide = true,
      reference = "ESOASettingsViewEditbox" -- unique global reference to control (optional)
    }
    optionsTable[#optionsTable+1] = {
      type = "button",
      name = "Save",
      tooltip = "Save selected View!",
      func = function()  ElderScrollsOfAlts:DoSaveSelectedView() end,
      width = "half",	--or "half" (optional)
      warning = "No confirmation if you do this!",	--(optional)
    }
    -- VIEWS --
    
    --
    LAM:RegisterOptionControls(ElderScrollsOfAlts.menuName, optionsTable)
end