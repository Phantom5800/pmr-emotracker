--[[----------------------------------------------------------
    LCL
------------------------------------------------------------]]
function ch1Required()
    return hasItem("ch1_lcl")
end
function ch2Required()
    return hasItem("ch2_lcl")
end
function ch3Required()
    return hasItem("ch3_lcl")
end
function ch4Required()
    return hasItem("ch4_lcl")
end
function ch5Required()
    return hasItem("ch5_lcl")
end
function ch6Required()
    return hasItem("ch6_lcl")
end
function ch7Required()
    return hasItem("ch7_lcl")
end

--[[----------------------------------------------------------
    Dungeon Entrances
------------------------------------------------------------]]
function DungeonAccessible(dungeon)
    local entranceAccessibleFn = {
        KoopaBrosFortressEntranceAccess,
        DryDryRuinsEntranceAccess,
        TubbaCastleEntranceAccess,
        ToyBoxEntranceAccess,
        VolcanoEntranceAccess,
        FlowerFieldsGateAccess,
        CrystalPalaceEntranceAccess,
        BowsersCastleEntranceAccess
    }

    if hasItem("dungeon_setting") then
        for i=1,8,1 do
            local dungeon_entrance = "ch"..i.."_dungeon_0"
            if itemStage(dungeon_entrance) == dungeon then
                return entranceAccessibleFn[i]()
            end
        end

        return false
    end

    return entranceAccessibleFn[dungeon]()
end

function SewersShortcutPipesAccess()
    local boots = hasItem("boots")
    local boots3 = hasItem("boots3")
    local hammer2 = hasItem("hammer2")

    if ToadTownAccess() then
        if boots and hammer2 then
            return true
        elseif boots3 then
            return true, AccessibilityLevel.SequenceBreak
        elseif parakarry() and hammer2 and KoopaVillageAccess() then
            return true, AccessibilityLevel.SequenceBreak
        end
    end
    return false
end

--[[----------------------------------------------------------
    Prologue Region Access
------------------------------------------------------------]]
function GoombaVillageAccess()
    if ToadTownAccess() then
        -- glitchless path
        local open_prologue = hasItem("open_prologue")
        if open_prologue and canClimbShortLedges() and canBreakYellowBlocks() then
            return true
        end

        -- clip through yellow block from the right
        if open_prologue and canClimbShortLedges() then
            return true, AccessibilityLevel.SequenceBreak
        end
    end
    return SewersShortcutPipesAccess()
end

function GoombaRoadAccess()
    if ToadTownAccess() then
        local open_prologue = hasItem("open_prologue")
        local boots = hasItem("boots")
        local hammer2 = hasItem("hammer2")

        if open_prologue and (canClimbShortLedges()) then
            return true
        end
    end
    local shortcut_access,level = SewersShortcutPipesAccess()
    return shortcut_access and canBreakYellowBlocks(), level
end

-- assume goomba village access
function GoombaPlaygroundAccess()
    if canBreakYellowBlocks() then
        return true
    elseif canDoLakiTeleports() then
        return true, AccessibilityLevel.SequenceBreak
    end
    return false
end

function BlueHousePipeAccess()
    if ToadTownAccess() and canClimbShortLedges() then
        if hasItem("oddkey_base") or hasItem("open_blue_house") then
            return true
        elseif canDoBHS() or canDoLakiClips() or canDoToadLureHammerClip() then
            return true, AccessibilityLevel.SequenceBreak
        end
    end

    return false
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
    return ToadTownAccess() and canHitTrees() and canClimbShortLedges()
end

function KoloradoAccess()
    if DryDryDesertAccess() or (hasItem("mamar") and KoopaVillageAccess()) then
        return true
    end
    return false
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
        local logical = false
        local can_access = false

        local boots = hasItem("boots")
        local from_train = hasItem("open_mt_rugged") or bombette()
        if from_train then
            if boots then
                logical = true
                can_access = true
            elseif canDoClippy() and canDoLakiTeleports() then
                can_access = true
            end
        end

        local from_sewers,level = SewersShortcutPipesAccess()
        if from_sewers then
            can_access = true
            if ~logical then
                if level == nil then
                    logical = true
                end
            end
        end
        
        if can_access then
            if logical then
                return true
            else
                return true, AccessibilityLevel.SequenceBreak
            end
        end
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
            blue_house_access,level = BlueHousePipeAccess()
            return (hasItem("boots") and sushie() and bombette() and blue_house_access), level
        end
    end
    return false
end

function BoosMansionAccess()
    if ToadTownAccess() then
        local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")
        -- logically need boots to enter mansion
        if forest_pass and hasItem("boots") then
            return true
        elseif forest_pass and parakarry() then
            return mansion_room, AccessibilityLevel.SequenceBreak
        else
            return BoosMansionPipeRoomAccess()
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
            return BoosMansionPipeRoomAccess(), AccessibilityLevel.SequenceBreak
        end
    end
    return false
end

function GustyGulchAccess()
    local boos_mansion_access,level = BoosMansionAccess()
    if boos_mansion_access then
        if hasItem("boo_portrait_base") then
            if hasItem("boots") or hasItem("weight_base") then
                return true, level
            end
        end
    end

    local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")
    local ch3_shortcut,level = BoosMansionPipeRoomAccess()
    if (forest_pass or ch3_shortcut) and (canDoLakiTeleports() or canDoLZS()) then
        return true, AccessibilityLevel.SequenceBreak
    end
    return false
end

function TubbaCastleEntranceAccess()
    if parakarry() then
        return GustyGulchAccess()
    elseif hasItem("boots") or canDoClippy() then
        return GustyGulchAccess(), AccessibilityLevel.SequenceBreak
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
    if ToadTownAccess() then
        local front_door = bow() or hasItem("open_toy_box")
        if front_door then
            return canClimbShortLedges()
        elseif canDoToadLureHammerClip() then
            return canClimbShortLedges(), AccessibilityLevel.SequenceBreak
        end
    end
    return false
end

function ToyBoxAccess()
    return DungeonAccessible(4)
end

function ToyBoxPinkAccess()
    local can_place_train,level = ToyBoxEntranceAccess()
    if ToyBoxAccess() then
        return hasItem("boots") and hasItem("toy_train_base"), level
    end
    return false
end

function ToyBoxGreenAccess()
    local can_take_train,level = ToyBoxPinkAccess()
    if can_take_train then
        if cookingAvailable() and hasItem("cakemix") and hasItem("cake") then
            return true, level
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
    local blue_house_access,level = BlueHousePipeAccess()

    -- Whale
    if hasItem("open_whale") or ((boots2 or hammer or bombette) and watt()) then
        return true
    -- shortcut pipe through blue house
    elseif blue_house_access and bombette then
        return true, level
    -- shortcut pipe through main sewer entrance
    elseif boots2 and sushie() then
        return true
    end
    return false
end

function VolcanoEntranceAccess()
    local ch5_access,level = YoshisIslandAccess()
    if ch5_access then
        if sushie() and hasItem("jade_raven_base") and hasItem("boots") and hasItem("hammer") then
            return true, level
        elseif parakarry() or canClimbWeirdGeometry() or canDoLakiTeleports() then
            return true, AccessibilityLevel.SequenceBreak
        end
    end
    return false
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
        local blue_house_access,level = BlueHousePipeAccess()
        -- bridge room access
        if (blue_house_access and bombette()) or (hasItem("boots2") and sushie()) then
            -- cross already open bridge
            if hasItem("open_ch7_bridge") then
                return canClimbShortLedges(), level
            -- activate bridge
            elseif hasItem("boots3") then
                return hiddenBlocks(), level
            elseif hasItem("boots2") then
                return true, AccessibilityLevel.SequenceBreak
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

--[[----------------------------------------------------------
    Chapter 8 Region Access
------------------------------------------------------------]]
function BowsersCastleEntranceAccess()
    -- need a way to verify star road access
    return true
end

function BowsersCastleAccess()
    return DungeonAccessible(8)
end
