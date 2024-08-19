function DungeonAccessible(dungeon)
    local entranceAccessibleFn = {
        KoopaBrosFortressEntranceAccess,
        DryDryRuinsEntranceAccess,
        TubbaCastleEntranceAccess,
        ToyBoxEntranceAccess,
        VolcanoEntranceAccess,
        FlowerFieldsGateAccess,
        CrystalPalaceEntranceAccess
    }

    if hasItem("dungeon_setting") then
        for i=1,7,1 do
            local dungeon_entrance = "ch"..i.."_dungeon_0"
            if itemStage(dungeon_entrance) == dungeon then
                return entranceAccessibleFn[i]()
            end
        end

        return false
    end

    return entranceAccessibleFn[dungeon]()
end

--[[----------------------------------------------------------
    Prologue Region Access
------------------------------------------------------------]]
function GoombaVillageAccess()
    if ToadTownAccess() then
        local open_prologue = hasItem("open_prologue")
        local boots = hasItem("boots")
        local hammer2 = hasItem("hammer2")
        if open_prologue and canClimbShortLedges() and canBreakYellowBlocks() then
            return true
        elseif boots and hammer2 then
            return true
        end
    end
    return false
end

function GoombaRoadAccess()
    if ToadTownAccess() then
        local open_prologue = hasItem("open_prologue")
        local boots = hasItem("boots")
        local hammer2 = hasItem("hammer2")

        if open_prologue and (canClimbShortLedges()) then
            return true
        elseif boots and hammer2 then
            return true
        end
    end
    return false
end

function BlueHousePipeAccess()
    return ToadTownAccess() and canClimbShortLedges() and (hasItem("oddkey_base") or hasItem("open_blue_house"))
end

function ToadTownAccess()
    -- start == ToadTown or start == YoshisIsland
    -- start == DryDryOutpost and (parakarry or boots)
    -- start == GoombaVillage and (bombette or hammer)

    return true
end

--[[----------------------------------------------------------
    Chapter 1 Region Access
------------------------------------------------------------]]
function KoopaVillageAccess()
    return ToadTownAccess() and canBreakYellowBlocks() and canClimbShortLedges()
end

function KoopaBrosFortressEntranceAccess()
    return KoopaVillageAccess() and kooper()
end

function KoopaBrosFortressAccess()
    return DungeonAccessible(1)
end

--[[----------------------------------------------------------
    Chapter 2 Region Access
------------------------------------------------------------]]
function DryDryDesertAccess()
    -- TODO: first check if Desert Start
    -- Toad Town -> Desert
    if ToadTownAccess() then
        local boots = hasItem("boots")

        -- can access the desert through the sewers
        if boots and hasItem("hammer2") then
            return true
        end

        -- can traverse mt rugged to get to the desert
        return (hasItem("open_mt_rugged") or bombette()) and boots and parakarry()
    end

    return false
end

function MtRuggedAccess()
    -- TODO: first check if Desert Start
    if ToadTownAccess() then
        local boots = hasItem("boots")
        local from_train = (hasItem("open_mt_rugged") or bombette()) and boots
        local from_sewers = boots and hasItem("hammer2")
        return from_train or from_sewers
    end

    return false
end

function DryDryRuinsEntranceAccess()
    return DryDryDesertAccess() and hasItem("pulse_stone")
end

function DryDryRuinsAccess()
    return DungeonAccessible(2)
end

--[[----------------------------------------------------------
    Chapter 3 Region Access
------------------------------------------------------------]]
function ClosedForest()
    return not hasItem("open_forest")
end

function BoosMansionPipeRoomAccess()
    if ToadTownAccess() then
        if hasItem("boots2") then
            return true
        else
            return sushie() and bombette() and BlueHousePipeAccess()
        end
    end
    return false
end

function BoosMansionAccess()
    if ToadTownAccess() then
        local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")
        local mansion_room = (BoosMansionPipeRoomAccess() or forest_pass)
        -- logically need boots to enter mansion
        if hasItem("boots") then
            return mansion_room
        elseif parakarry() then
            return mansion_room, AccessibilityLevel.SequenceBreak
        end
    end
    return false
end

function ForeverForestAccess()
    if ToadTownAccess() then
        local boots = hasItem("boots")
        local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")

        if forest_pass then
            return true
        else
            return (BoosMansionPipeRoomAccess() and boots), AccessibilityLevel.SequenceBreak
        end
    end
    return false
end

function GustyGulchAccess()
    if hasItem("boo_portrait_base") and hasItem("boots") then
        return BoosMansionAccess()
    end
    return false
end

function TubbaCastleEntranceAccess()
    if parakarry() then
        return GustyGulchAccess()
    end
    return false
end

function TubbaCastleAccess()
    return DungeonAccessible(3)
end

--[[----------------------------------------------------------
    Chapter 4 Region Access
------------------------------------------------------------]]
function ToyBoxEntranceAccess()
    return ToadTownAccess() and (bow() or hasItem("open_toy_box")) and (hasItem("boots") or parakarry())
end

function ToyBoxAccess()
    return DungeonAccessible(4)
end

function ToyBoxPinkAccess()
    return ToyBoxAccess() and ToyBoxEntranceAccess() and hasItem("boots") and hasItem("toy_train_base")
end

function ToyBoxGreenAccess()
    if ToyBoxPinkAccess() then
        if cookingAvailable() and hasItem("cakemix") and hasItem("cake") then
            return true
        elseif hasItem("cake") then
            return true, AccessibilityLevel.SequenceBreak -- out of logic
        end
    end
    return false
end

function ToyBoxRedAccess()
    if hasItem("hammer") then
        local green,access = ToyBoxGreenAccess()
        if green then
            if  access == nil and hasItem("mystery_note_base") and hasItem("dictionary_base") then
                return true
            else
                return true, AccessibilityLevel.SequenceBreak -- out of logic
            end
        end
    end
    return false
end

--[[----------------------------------------------------------
    Chapter 5 Region Access
------------------------------------------------------------]]
function YoshisIslandAccess()
    local boots = hasItem("boots")
    local boots2 = hasItem("boots2")
    local hammer = hasItem("hammer")
    local bombette = bombette()

    -- Whale
    if hasItem("open_whale") or ((boots2 or hammer or bombette) and watt()) then
        return true
    -- shortcut pipe through blue house
    elseif BlueHousePipeAccess() and bombette then
        return true
    -- shortcut pipe through main sewer entrance
    elseif boots2 and sushie() then
        return true
    end
    return false
end

function VolcanoEntranceAccess()
    return YoshisIslandAccess() and sushie() and hasItem("jade_raven_base") and hasItem("boots") and hasItem("hammer")
end

function VolcanoAccess()
    return DungeonAccessible(5)
end

--[[----------------------------------------------------------
    Chapter 6 Region Access
------------------------------------------------------------]]
function FlowerFieldsGateAccess()
    return ToadTownAccess() and hasItem("seed1") and hasItem("seed2") and hasItem("seed3") and hasItem("seed4")
end

function FlowerFieldsAccess()
    return DungeonAccessible(6)
end

--[[----------------------------------------------------------
    Chapter 7 Region Access
------------------------------------------------------------]]
function ShiverCityAccess()
    if ToadTownAccess() then
        -- bridge room access
        if (BlueHousePipeAccess() and bombette()) or (hasItem("boots2") and sushie()) then
            -- cross already open bridge
            if hasItem("open_ch7_bridge") then
                return canClimbShortLedges()
            -- activate bridge
            elseif hasItem("boots3") then
                return hiddenBlocks()
            end
        end
    end
    return false
end

function ShiverMountainAccess()
    local a,b = ShiverCityAccess()
    return a and hasItem("warehouse_key") and hasItem("scarf") and hasItem("bucket"), b
end

function ShiverMountainPart2Access()
    local a,b = ShiverMountainAccess()
    return a and kooper(), b
end

function CrystalPalaceEntranceAccess()
    local a,b = ShiverMountainPart2Access()
    return a and hasItem("star_stone"), b
end

function CrystalPalaceAccess()
    return DungeonAccessible(7)
end
