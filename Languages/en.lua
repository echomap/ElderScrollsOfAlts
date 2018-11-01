-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ESOA_MESSAGE  = " addon is loaded",
    -- Keybindings
    SI_BINDING_NAME_ESOA_DISPLAY     = "Display ESOA",
    SI_BINDING_NAME_ESOA_DISPLAY2    = "Show Home",
    SI_BINDING_NAME_ESOA_DISPLAY3    = "Show Equip",
    SI_BINDING_NAME_ESOA_DISPLAY_NEXTVIEW = "Next View",
    
    --
    ESOA_NAME    ="name",
    ESOA_BAGS    ="Bags",
    ESOA_Unknown ="Unknown",

    --Views
    ESOA_VIEW_HOME    ="Home",
    ESOA_VIEW_EQUIP   ="Equip",
    ESOA_VIEW_RESEARCH="Research",
    ESOA_VIEW_OTHER   ="Other",

    --Abbrevs
    ESOA_ABBR_ALLY = "Aly",
    ESOA_ABBR_CLASS="Class",
    ESOA_ABBR_LVL  ="Lvl",
    ESOA_ABBR_G    ="G",
    ESOA_ABBR_RACE ="Race",
    ESOA_ABBR_ALC  ="Alc",
    ESOA_ABBR_SMTH ="Smth",
    ESOA_ABBR_CLTH ="Clth",
    ESOA_ABBR_ENCH ="Ench",
    ESOA_ABBR_JC   ="JC",
    ESOA_ABBR_PROV ="Prov",
    ESOA_ABBR_WOOD ="Wood",

}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end
