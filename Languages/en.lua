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
    ESOA_VIEW_HOME     ="Home",
    ESOA_VIEW_EQUIP    ="Equip",
    ESOA_VIEW_RESEARCH ="Research",
    ESOA_VIEW_SKILLS   ="Skills",
    --ESOA_VIEW_OTHER    ="Other",
    
    ESOA_GENDER_MALE   = "Male",
    ESOA_GENDER_FEMALE = "Female",
    ESOA_GENDER_OTHER  = "Other",
    ESOA_GENDER_MALE_S   = "M",
    ESOA_GENDER_FEMALE_S = "F",
    ESOA_GENDER_OTHER_S  = "O",

    ESOA_CLASS_DEFAULT      = "UK",
    ESOA_CLASS_DRAGONKNIGHT = "Dragonknight",
    ESOA_CLASS_SORCERER     = "Sorcerer",
    ESOA_CLASS_NIGHTBLADE   = "Nightblade",
    ESOA_CLASS_TEMPLAR      = "Templar",
    ESOA_CLASS_WARDEN       = "Warden",
    ESOA_CLASS_NECRO        = "Necromancer",
    
    ESOA_CLASS_DEFAULT_ABBREV      = "UK",
    ESOA_CLASS_DRAGONKNIGHT_ABBREV = "DK",
    ESOA_CLASS_SORCERER_ABBREV     = "Sorc",
    ESOA_CLASS_NIGHTBLADE_ABBREV   = "Night",
    ESOA_CLASS_TEMPLAR_ABBREV      = "Temp",
    ESOA_CLASS_WARDEN_ABBREV       = "Ward",
    ESOA_CLASS_NECRO_ABBREV        = "Necr",

    ESOA_RACE_UNKNOWN  = "UK",
    ESOA_RACE_HIGHELF  = "High Elf",    
    ESOA_RACE_WOODELF  = "Wood Elf",
    ESOA_RACE_KHAJIIT  = "Khajiit",
    ESOA_RACE_ARGONIAN = "Argonian",
    ESOA_RACE_DARKELF  = "Dark Elf",
    ESOA_RACE_NORD     = "Nord",
    ESOA_RACE_BRETON   = "Breton",
    ESOA_RACE_ORC      = "Orc",
    ESOA_RACE_REDGUARD = "Redguard",
    
    ESOA_RACE_HIGHELF_ABBREV   = "H.Elf",
    ESOA_RACE_HIGHELF_ABBREV2  = "High",
    ESOA_RACE_WOODELF_ABBREV   = "W.Elf",
    ESOA_RACE_WOODELF_ABBREV2  = "Wood",
    ESOA_RACE_KHAJIIT_ABBREV   = "Kaji",
    ESOA_RACE_KHAJIIT_ABBREV2  = "Kaj",
    ESOA_RACE_ARGONIAN_ABBREV  = "Argon",
    ESOA_RACE_ARGONIAN_ABBREV2 = "Argo",
    ESOA_RACE_NORD_ABBREV      = "Nord",
    ESOA_RACE_DARKELF_ABBREV   = "D.Elf",      
    ESOA_RACE_DARKELF_ABBREV2  = "Dark",
    ESOA_RACE_BRETON_ABBREV    = "Breton",
    ESOA_RACE_ORC_ABBREV       = "Orc",
    ESOA_RACE_REDGUARD_ABBREV  = "Red",
     
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

    ESOA_BITE_WERE_ABILITY  = "Bloodmoon",
    ESOA_BITE_WERE_COOLDOWN = "Bloodmoon Cooldown",
    ESOA_BITE_VAMP_ABILITY  = "Blood Ritual",
    ESOA_BITE_VAMP_COOLDOWN = "Fed on ally", --Blood Ritual Cooldown",

}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end
