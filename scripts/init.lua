-- SDK
ScriptHost:LoadScript("scripts/class.lua")
ScriptHost:LoadScript("scripts/custom_item.lua")
ScriptHost:LoadScript("scripts/logic/helpers.lua")
ScriptHost:LoadScript("scripts/logic/glitch_logic_helpers.lua")
ScriptHost:LoadScript("scripts/logic/presets.lua")

-- Item Sets
Tracker:AddItems("items/star_spirits.json")
Tracker:AddItems("items/star_spirit_lcl_icons.json")
Tracker:AddItems("items/difficulty.json")
Tracker:AddItems("items/dungeon_shuffle.json")
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
Tracker:AddItems("items/ch8.json")
Tracker:AddItems("items/letters.json")
Tracker:AddItems("items/koopakoot.json")

-- Tracker Settings
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/openareas.json")

-- Maps
if (string.find(Tracker.ActiveVariantUID, "Map_Tracker")) then
    ScriptHost:LoadScript("scripts/logic/region_access.lua")
    ScriptHost:LoadScript("scripts/logic/regions/GoombaRegion.lua")
    Tracker:AddMaps("maps/maps.json")
    ScriptHost:LoadScript("scripts/loadlocations.lua")
end

local blitzPreset = Preset("Blitz", "blitz_preset", "images/presets/Blitz.png")
local s3blitzPreset = Preset("S3 Blitz", "s3_blitz_preset", "images/presets/S3Blitz.png")
local s1RacePreset = Preset("Standard Race (S1)", "s1_race_preset", "images/presets/S1Race.png")
local extremePreset = Preset("Extreme", "extreme_preset", "images/presets/Extreme.png")

-- Layouts
if (string.find(Tracker.ActiveVariantUID, "_S")) then
    Tracker:AddLayouts("layouts/broadcast.json")
else
    Tracker:AddLayouts("layouts/broadcast_full.json")
end

Tracker:AddLayouts("layouts/item_groups.json")
if (string.find(Tracker.ActiveVariantUID, "Map_Tracker")) then
    if PopVersion then
        Tracker:AddLayouts("layouts/poptracker_map/items.json")
        Tracker:AddLayouts("layouts/poptracker_map/tracker.json")
    else
        Tracker:AddLayouts("layouts/full_map/items.json")
        Tracker:AddLayouts("layouts/full_map/tracker.json")
    end
else
    Tracker:AddLayouts("layouts/items_only/items.json")
    Tracker:AddLayouts("layouts/items_only/tracker.json")
end

-- Autotracking
if PopVersion then
    -- load AP autotracker
    if PopVersion >= "0.18.0" then
        ScriptHost:LoadScript("scripts/ap_autotracking/archipelago.lua")
    end
end

-- Bizhawk connector based tracking
ScriptHost:LoadScript("scripts/autotracking.lua")
