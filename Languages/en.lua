-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ESOA_MESSAGE  = " addon is loaded",
    -- Keybindings.
    SI_BINDING_NAME_ESOA_DISPLAY  = "Display ESOA",
    SI_BINDING_NAME_ESOA_DISPLAY2 = "Show Home",
    SI_BINDING_NAME_ESOA_DISPLAY3 = "Show Equip",
}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end