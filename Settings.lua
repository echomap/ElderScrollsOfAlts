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

    local optionsTable = {
        [1] = {
            type = "header",
            name = "Main",
            width = "full",	--or "half" (optional)
        },
        [2] = {
            type = "description",
            --title = "My Title",	--(optional)
            title = nil,	--(optional)
            text = "ESOA - Options and Configuration.",
            width = "full",	--or "half" (optional)
        },
        [3] = {
            type = "checkbox",
            name = "Show Button",
            tooltip = "On or off.",
            getFunc = function() return ElderScrollsOfAlts.GetUIButtonShown() end,
            setFunc = function(value) ElderScrollsOfAlts.SetUIButtonShown(value)  end,
            width = "half",	--or "half" (optional)
        },     
        [4] = {
            type = "header",
            name = "Character Maintanance",
            text = "Character Maintanance",
            tooltip = "Character Maintanance Utils",	--(optional)
        },
        [5] = {
            type = "dropdown",
            name = "Character",
            tooltip = "Select Character.",
            choices = ElderScrollsOfAlts:ListOfPlayers(),
            getFunc = function() return "Select" end,
            setFunc = function(var) ElderScrollsOfAlts:SelectCharacterName(var) end,
            width = "half",	--or "half" (optional)
        },
        [6] = {
            name = "Commands",
            type = "description",
            --title = "My Title",	--(optional)
            title = nil,	--(optional)
            text = "ESOA - Options and Configuration.",
            width = "full",	--or "half" (optional)
        },
        [7] = {
            type = "button",
            name = "Delete",
            tooltip = "Delete selected Character's Data!",
            func = function()  ElderScrollsOfAlts:DoDeleteSelectedCharacter() end,
            width = "half",	--or "half" (optional)
            warning = "Will need to reload the UI.",	--(optional)
        },
        
    }
    LAM:RegisterOptionControls(ElderScrollsOfAlts.menuName, optionsTable)
end