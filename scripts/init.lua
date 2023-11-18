-- SDK
ScriptHost:LoadScript("scripts/class.lua")
ScriptHost:LoadScript("scripts/custom_item.lua")
ScriptHost:LoadScript("scripts/logic/helpers.lua")

-- Item Sets
Tracker:AddItems("items/star_spirits.json")
Tracker:AddItems("items/star_spirit_lcl_icons.json")
Tracker:AddItems("items/partners.json")
Tracker:AddItems("items/upgrades.json")
Tracker:AddItems("items/prologue.json")
Tracker:AddItems("items/toadtown.json")
Tracker:AddItems("items/ch1.json")
Tracker:AddItems("items/ch2.json")
Tracker:AddItems("items/ch3.json")
Tracker:AddItems("items/ch4.json")
Tracker:AddItems("items/ch5.json")
Tracker:AddItems("items/ch6.json")
Tracker:AddItems("items/ch7.json")
Tracker:AddItems("items/letters.json")
Tracker:AddItems("items/koopakoot.json")

-- Tracker Settings
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/openareas.json")

-- Maps
ScriptHost:LoadScript("scripts/logic/region_access.lua")
Tracker:AddMaps("maps/maps.json")
ScriptHost:LoadScript("scripts/loadlocations.lua")

-- Layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/tracker.json")

-- Scripts
ScriptHost:LoadScript("scripts/lcl.lua")
