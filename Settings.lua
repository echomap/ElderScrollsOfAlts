-- Settings menu.
function ElderScrollsOfAlts.LoadSettings()
  local LAM = LibStub("LibAddonMenu-2.0")

  local panelData = {
      type = "panel",
      name         = ElderScrollsOfAlts.name,
      displayName  = ElderScrollsOfAlts.Colorize(ElderScrollsOfAlts.menuName),
      author       = ElderScrollsOfAlts.Colorize(ElderScrollsOfAlts.author, "AAF0BB"),
      version      = ElderScrollsOfAlts.Colorize(ElderScrollsOfAlts.version, "AA00FF"),
      slashCommand = "/ElderScrollsOfAlts",
      registerForRefresh  = true,
      registerForDefaults = true,
  }
  LAM:RegisterAddonPanel(ElderScrollsOfAlts.menuName, panelData)
  local optionsTable = {}
  
  ---- -- --- -- --- ----
  -- ACCOUNT SETTINGS  --
  ---- -- --- -- --- ----
  optionsTable[1] = {
    type  = "header",
    name  = "Account Wide Settings",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "slider",
    name = "Char name field width", -- or string id or function returning a string
    getFunc = function() return ElderScrollsOfAlts.altData.fieldWidthForName end,
    setFunc = function(value) ElderScrollsOfAlts.altData.fieldWidthForName = value end,
    min = 50,
    max = 300,
    step = 1, --(optional)
    clampInput = false, -- boolean, if set to false the input won't clamp to min and max and allow any number instead (optional)
    decimals = 0, -- when specified the input value is rounded to the specified number of decimals (optional)
    autoSelect = false, -- boolean, automatically select everything in the text input field when it gains focus (optional)
    inputLocation = "below", -- or "right", determines where the input field is shown. This should not be used within the addon menu and is for custom sliders (optional) 
    tooltip = "Width of Name field displayed.", -- or string id or function returning a string (optional)
    width = "full", --or "half" (optional)
    warning = "Don't set this to a negative number or too big, that's on you!", -- or string id or function returning a string (optional)
    requiresReload = false, -- boolean, if set to true, the warning text will contain a notice that changes are only applied after an UI reload and any change to the value will make the "Apply Settings" button appear on the panel which will reload the UI when pressed (optional)
    default = 160, -- default value or function that returns the default value (optional)
    reference = "ESOA_NameSlider" -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type    = "colorpicker",
    name    = "Skill at MAX Color",
    tooltip = "What Color to use when a skill is at the current MAX.",
    getFunc = function()               
      if(ElderScrollsOfAlts.savedVariables.colors==nil or ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax==nil) then
          ElderScrollsOfAlts.SetupDefaultColors()
      end
      return              
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.r,
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.g,
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.b,
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.a      
    end,
    setFunc = 	function(r,g,b,a)
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax = {}
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.r = r
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.g = g
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.b = b
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsMax.a = a
    end,
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type    = "colorpicker",
    name    = "Skill at nearly MAX Color",
    tooltip = "What Color to use when a skill is near the current MAX.",
    getFunc = function()               
      if(ElderScrollsOfAlts.savedVariables.colors==nil or ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax==nil) then
          ElderScrollsOfAlts.SetupDefaultColors()
      end
      return              
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.r,
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.g,
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.b,
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.a      
    end,
    setFunc = 	function(r,g,b,a)
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax = {}
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.r = r
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.g = g
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.b = b
      ElderScrollsOfAlts.savedVariables.colors.colorSkillsNearMax.a = a
    end,
    width = "full",	--or "half" (optional)
  }
  
  
  -- Account Settings --

  ---- -- --- -- --- ----
  -- CHAR SETTINGS     --
  ---- -- --- -- --- ----
  optionsTable[#optionsTable+1] = {
    type  = "header",
    name  = "Character Settings",
    width = "full",	--or "half" (optional)
  }
  optionsTable [#optionsTable+1] = {
    type    = "checkbox",
    name    = "Show Button",
    tooltip = "On or off.",
    getFunc = function() return ElderScrollsOfAlts.GetUIButtonShown() end,
    setFunc = function(value)   ElderScrollsOfAlts.SetUIButtonShown(value)  end,
    width   = "half",	--or "half" (optional)
  }
  optionsTable [#optionsTable+1] = {
    type    = "checkbox",
    name    = "Mouse Hightlight On/Off",
    tooltip = "On or off.",
    getFunc = function() return ElderScrollsOfAlts.GetUIViewMouseHighlightShown() end,
    setFunc = function(value)   ElderScrollsOfAlts.SetUIViewMouseHighlightShown(value)  end,
    width   = "half",	--or "half" (optional)
  }
  optionsTable [#optionsTable+1] = {
    type    = "checkbox",
    name    = "Use dropdown for Views, instead of buttons.",
    tooltip = "On or off.",
    getFunc = function() return ElderScrollsOfAlts.GetUIViewDropDownShown() end,
    setFunc = function(value)   ElderScrollsOfAlts.SetUIViewDropDownShown(value)  end,
    width   = "half",	--or "half" (optional)
  }
  
  optionsTable[#optionsTable+1] = {
    type  = "header",
    name  = "Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type    = "colorpicker",
    name    = "Timer  Done Soon Color",
    tooltip = "What Color to use when a timer is near to completion.",
    getFunc = function()               
      if(ElderScrollsOfAlts.savedVariables.colors==nil or ElderScrollsOfAlts.savedVariables.colors.colorTimerNear==nil) then
          ElderScrollsOfAlts.SetupDefaultColors()
      end
      return              
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.r,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.g,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.b,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.a      
    end,
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      --local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear = {}
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.r = r
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.g = g
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.b = b
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNear.a = a
    end,
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name = "Timer Done Sooner Color",
    tooltip = "What Color to use when a timer is nearer(!) to completion.",
    getFunc = function()               
      if(ElderScrollsOfAlts.savedVariables.colors==nil or ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer==nil) then
          ElderScrollsOfAlts.SetupDefaultColors()
      end
      return              
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.r,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.g,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.b,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.a      
    end,
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      --local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer = {}
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.r = r
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.g = g
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.b = b
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNearer.a = a
    end,
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name = "Timer N/A or not set Color",
    tooltip = "What Color to use when a timer is NOT set or n/a.",
    getFunc = function()               
      if(ElderScrollsOfAlts.savedVariables.colors==nil or ElderScrollsOfAlts.savedVariables.colors.colorTimerNone==nil) then
          ElderScrollsOfAlts.SetupDefaultColors()
      end
      return              
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.r,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.g,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.b,
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.a      
    end,
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      --local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone = {}
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.r = r
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.g = g
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.b = b
      ElderScrollsOfAlts.savedVariables.colors.colorTimerNone.a = a
    end,
    width = "full",	--or "half" (optional)
  }
  -- Character Base Options --
  
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
    reference = "ESOA_SETTINGS_CHARMAIN_Select",--TODO refresh me
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Delete",
    tooltip = "Delete selected Character's Data!",
    func  = function()  ElderScrollsOfAlts:DoDeleteSelectedCharacter() end,
    width = "full",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  }
  -- Character Maintanance Options --
  
  optionsTable[#optionsTable+1] = {
    type = "header",
    name = "Views (BETA BETA BETA)",
    width = "full",	--or "half" (optional)
  }    
  --New from template
  --TODO template dropdown to pick from
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Template View Names",
    tooltip = "Select one of these to do 'New from Template' .",
    choices = ElderScrollsOfAlts:SettingsListOfViewTemplateNames(),
    getFunc = function() return tostring(ElderScrollsOfAlts.savedVariables.selected.viewTemplate) end,
    setFunc = function(var) ElderScrollsOfAlts.savedVariables.selected.viewTemplate = (var) end,
    width = "full",	--or "half" (optional)
    reference = "ESOA_SETTINGS_TV_SelectView",
  }    
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "New From Template",
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
    reference = "ESOA_SETTINGS_DD_SelectView",
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
    getFunc = function() return ElderScrollsOfAlts.GetEditSelectedViewText() end,
    setFunc = function(text) ElderScrollsOfAlts.SetEditSelectedViewText(text) end,
    width = "full",	--or "half" (optional)
    isMultiline = true,
    isExtraWide = true,
    reference = "ESOASettingsViewEditbox" -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Test",
    tooltip = "Test selected View",
    func = function()  ElderScrollsOfAlts:DoTestSelectedView() end,
    width = "half",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Save",
    tooltip = "Save selected View!",
    func = function()  ElderScrollsOfAlts:DoSaveSelectedView() end,
    width = "half",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  }
  --https://github.com/sirinsidiator/ESO-LibAddonMenu/blob/master/LibAddonMenu-2.0/exampleoptions.lua
  --optionsTable[#optionsTable+1] = {
  --    type  = "submenu",
  --    name  = "All Allowable Entries in a View",
  --      controls = {
  --        [1] = {
  --        },
  --      }  
  --}
  optionsTable[#optionsTable+1] = {
    type = "editbox",
    name = "All Allowable Entries",
    --tooltip = "Edit selected View!",
    getFunc = function() return ElderScrollsOfAlts.GetAllAllowedViewEntries() end,
    setFunc = function(text) ElderScrollsOfAlts.SetAllAllowedViewEntries(text) end,
    width = "full",	--or "half" (optional)
    isMultiline = true,
    isExtraWide = true,
    --reference = "ESOASettingsViewEditbox" -- unique global reference to control (optional)
  }
  
  
  -- VIEWS --
  --
  --
    LAM:RegisterOptionControls(ElderScrollsOfAlts.menuName, optionsTable)
end