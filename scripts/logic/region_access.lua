--[[----------------------------------------------------------
    Prologue Region Access
------------------------------------------------------------]]
function GoombaVillageAccess()
    local open_prologue = hasItem("open_prologue")
    local boots = hasItem("boots")
    local hammer2 = hasItem("hammer2")

    if open_prologue and canClimbShortLedges() and canBreakYellowBlocks() then
        return 1
    elseif boots and hammer2 then
        return 1
    end
    return 0
end

function GoombaRoadAccess()
    local open_prologue = hasItem("open_prologue")
    local boots = hasItem("boots")
    local hammer2 = hasItem("hammer2")

    if open_prologue and (canClimbShortLedges()) then
        return 1
    elseif boots and hammer2 then
        return 1
    end
    return 0
end

function BlueHousePipeAccess()
    return canClimbShortLedges() and (hasItem("oddkey_base") or hasItem("open_blue_house"))
end

function ToadTownAccess()
    -- start == ToadTown or start == YoshisIsland
    -- start == DryDryOutpost and (parakarry or boots)
    -- start == GoombaVillage and (bombette or hammer)

    return 1
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
    return KoopaBrosFortressEntranceAccess()
end

--[[----------------------------------------------------------
    Chapter 2 Region Access
------------------------------------------------------------]]
function DryDryDesertAccess()
    local boots = hasItem("boots")
    local hammer2 = hasItem("hammer2")
    local bombette = bombette()
    local parakarry = parakarry()
    local open_rugged = hasItem("open_mt_rugged")
    local manual_rugged = ToadTownAccess() and bombette

    local sewer_access = boots and hammer2
    local mt_rugged_access = (manual_rugged or open_rugged) and boots and parakarry
    return sewer_access or mt_rugged_access
end

function MtRuggedAccess()
    local boots = hasItem("boots")
    local open_rugged = hasItem("open_mt_rugged")
    local manual_rugged = ToadTownAccess() and bombette()

    local toad_town_side = (open_rugged or manual_rugged) and boots
    local desert_side = DryDryDesertAccess() and canClimbShortLedges()

    return toad_town_side or desert_side
end

function DryDryRuinsEntranceAccess()
    return DryDryDesertAccess() and hasItem("pulse_stone")
end

function DryDryRuinsAccess()
    return DryDryRuinsEntranceAccess()
end

--[[----------------------------------------------------------
    Chapter 3 Region Access
------------------------------------------------------------]]
function ClosedForest()
    return not hasItem("open_forest")
end

function BoosMansionPipeRoomAccess()
    local boots2 = hasItem("boots2")
    local bombette = bombette()
    local sushie = sushie()

    if boots2 then
        return 1
    else
        return sushie and bombette and BlueHousePipeAccess()
    end
    return 0
end

function BoosMansionAccess()
    local boots = hasItem("boots")
    local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")

    return (BoosMansionPipeRoomAccess() or forest_pass) and boots
end

function ForeverForestAccess()
    local boots = hasItem("boots")
    local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")

    if forest_pass then
        return 1
    else
        return (BoosMansionPipeRoomAccess() and boots), AccessibilityLevel.SequenceBreak
    end
end

function GustyGulchAccess()
    local portrait = hasItem("boo_portrait_base")
    return BoosMansionAccess() and portrait
end

function TubbaCastleEntranceAccess()
    return GustyGulchAccess() and parakarry()
end

function TubbaCastleAccess()
    return TubbaCastleEntranceAccess()
end

--[[----------------------------------------------------------
    Chapter 4 Region Access
------------------------------------------------------------]]
function ToyBoxEntranceAccess()
    return ToadTownAccess() and (bow() or hasItem("open_toy_box")) and (hasItem("boots") or parakarry())
end

function ToyBoxAccess()
    return ToyBoxEntranceAccess()
end

function ToyBoxPinkAccess()
    return ToyBoxAccess() and hasItem("boots") and hasItem("toy_train_base")
end

function ToyBoxGreenAccess()
    if ToyBoxPinkAccess() then
        if cookingAvailable() and hasItem("cakemix") then
            return 1
        else
            return 1, AccessibilityLevel.SequenceBreak -- out of logic
        end
    end
    return 0
end

function ToyBoxRedAccess()
    local green,access = ToyBoxGreenAccess()
    if green == 1 and access == nil and hasItem("mystery_note_base") then
        return 1
    elseif green > 0 then
        return 1, AccessibilityLevel.SequenceBreak -- out of logic
    end
    return 0
end

--[[----------------------------------------------------------
    Chapter 5 Region Access
------------------------------------------------------------]]
function YoshisIslandAccess()
    local boots = hasItem("boots")
    local boots2 = hasItem("boots2")
    local hammer = hasItem("hammer")
    local bombette = bombette()
    local watt = watt()
    local sushie = sushie()

    -- Whale
    if hasItem("open_whale") or ((boots2 or hammer or bombette) and watt) then
        return 1
    -- shortcut pipe through blue house
    elseif BlueHousePipeAccess() and bombette then
        return 1
    -- shortcut pipe through main sewer entrance
    elseif boots2 and sushie then
        return 1
    end
    return 0
end

function VolcanoEntranceAccess()
    local jade_raven = hasItem("jade_raven_base")
    local sushie = sushie()
    local jump = hasItem("boots") or parakarry()
    local hammer = hasItem("hammer")

    return YoshisIslandAccess() and sushie and jade_raven and jump and hammer
end

function VolcanoAccess()
    return VolcanoEntranceAccess()
end

--[[----------------------------------------------------------
    Chapter 6 Region Access
------------------------------------------------------------]]
function FlowerFieldsGateAccess()
    return ToadTownAccess() and hasItem("seed1") and hasItem("seed2") and hasItem("seed3") and hasItem("seed4")
end

function FlowerFieldsAccess()
    return FlowerFieldsGateAccess()
end

--[[----------------------------------------------------------
    Chapter 7 Region Access
------------------------------------------------------------]]
function ShiverCityAccess()
    local boots2 = hasItem("boots2")
    local boots3 = hasItem("boots3")
    local open7 = hasItem("open_ch7_bridge")
    local bombette = bombette()
    local sushie = sushie()

    if ToadTownAccess() then
        -- bridge room access
        if (BlueHousePipeAccess() and bombette) or (boots2 and sushie) then
            -- cross already open bridge
            if open7 then
                return canClimbShortLedges()
            -- activate bridge
            elseif boots3 then
                return hiddenBlocks()
            end
        end
    end
    return 0
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
    return CrystalPalaceEntranceAccess()
end
