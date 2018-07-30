-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ESOA_MESSAGE  = " addon is loaded",
    -- Keybindings.
    SI_BINDING_NAME_ESOA_DISPLAY = "Display ESOA",
}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end