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

function GL_DungeonAccessible(dungeon)
    local entranceAccessibleFn = {
        GL_KoopaBrosFortressEntranceAccess,
        GL_DryDryRuinsEntranceAccess,
        GL_TubbaCastleEntranceAccess,
        GL_ToyBoxEntranceAccess,
        GL_VolcanoEntranceAccess,
        GL_FlowerFieldsGateAccess,
        GL_CrystalPalaceEntranceAccess,
        GL_BowsersCastleEntranceAccess
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
    local hammer2 = hasItem("hammer2")

    if ToadTownAccess() then
        if boots and hammer2 then
            return true
        end
    end
    return false
end

function GL_SewersShortcutPipesAccess()
    local boots = hasItem("boots")
    local boots3 = hasItem("boots3")
    local hammer2 = hasItem("hammer2")

    if ToadTownAccess() then
        if boots and hammer2 then
            return true -- glitchless case
        elseif boots3 then
            return true
        elseif parakarry() and hammer2 and KoopaVillageAccess() then
            return true
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
        if hasItem("open_prologue") and canClimbShortLedges() and canBreakYellowBlocks() then
            return true
        end
    end
    return SewersShortcutPipesAccess()
end

function GL_GoombaVillageAccess()
    if GoombaVillageAccess() then
        return true
    end
    if ToadTownAccess() then
        -- clip through yellow block from the right
        if hasItem("open_prologue") and canClimbShortLedges() then
            return true
        end
    end
    return GL_SewersShortcutPipesAccess()
end

function GoombaRoadAccess()
    if ToadTownAccess() then
        if hasItem("open_prologue") and (canClimbShortLedges()) then
            return true
        end
    end
    return SewersShortcutPipesAccess() and canBreakYellowBlocks()
end

function GL_GoombaRoadAccess()
    if GoombaRoadAccess() then
        return true
    end
    -- TODO: Reverse Goomba King Bridge
    return GL_SewersShortcutPipesAccess() and canBreakYellowBlocks()
end

-- assume goomba village access
function GoombaPlaygroundAccess()
    if GoombaVillageAccess() then
        if canBreakYellowBlocks() then
            return true
        end
    end
    return false
end

function GL_GoombaPlaygroundAccess()
    if GoombaPlaygroundAccess() then
        return true
    end
    if GoombaVillageAccess() or GL_GoombaVillageAccess() then
        return canDoLakiTeleports()
    end
    return false
end

function BlueHousePipeAccess()
    if ToadTownAccess() and canClimbShortLedges() then
        return hasItem("oddkey_base") or hasItem("open_blue_house")
    end

    return false
end

function GL_BlueHousePipeAccess()
    if BlueHousePipeAccess() then
        return true
    end
    if ToadTownAccess() and canClimbShortLedges() then
        return canDoBHS() or canDoLakiClips() or canDoToadLureHammerClip()
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

function GL_KoopaBrosFortressEntranceAccess()
    if KoopaBrosFortressEntranceAccess() then
        return true
    end

    if KoopaVillageAccess() and canDoLakiClips() then -- laki clip into invisible bridge
        return true
    end

    return false
end

function KoopaBrosFortressAccess()
    return DungeonAccessible(1)
end

function GL_KoopaBrosFortressAccess()
    return GL_DungeonAccessible(1)
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

function GL_DryDryDesertAccess()
    if DryDryDesertAccess() then
        return true
    end
    if ToadTownAccess() then
        if hasItem("boots3") then -- sewers access with ultra boots
            return true
        end
        -- TODO: Jumpless Mt Rugged
    end

    return false
end

function MtRuggedAccess()
    -- TODO: first check if Desert Start
    if ToadTownAccess() then
        local boots = hasItem("boots")
        local from_train = hasItem("open_mt_rugged") or bombette()

        return (from_train and boots) or (SewersShortcutPipesAccess())
    end

    return false
end

function GL_MtRuggedAccess()
    if MtRuggedAccess() then
        return true
    end

    -- TODO: first check if Desert Start
    if ToadTownAccess() then
        local can_access = false

        -- check traversal from train side
        if hasItem("open_mt_rugged") or bombette() then
            can_access = hasItem("boots") or canDoLakiTeleports()
        end
        -- if can't access, check from sewers
        if can_access == false then
            can_access = GL_SewersShortcutPipesAccess()
        end
        
        return can_access
    end

    return false
end

function DryDryRuinsEntranceAccess()
    return DryDryDesertAccess() and hasItem("pulse_stone")
end

function GL_DryDryRuinsEntranceAccess()
    if DryDryRuinsEntranceAccess() then
        return true
    end

    if GL_DryDryDesertAccess() then
        return canDoLakiJumps() or hasItem("boots3")
    end

    return false
end

function DryDryRuinsAccess()
    return DungeonAccessible(2)
end

function GL_DryDryRuinsAccess()
    return GL_DungeonAccessible(2)
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
            return (hasItem("boots") and sushie() and bombette() and BlueHousePipeAccess())
        end
    end
    return false
end

function GL_BoosMansionPipeRoomAccess()
    if BoosMansionPipeRoomAccess() then
        return true
    end
    if ToadTownAccess() then
        if hasItem("boots2") then
            return true
        else
            return (hasItem("boots") and sushie() and bombette() and GL_BlueHousePipeAccess())
        end
    end
    return false
end

function BoosMansionAccess()
    if ToadTownAccess() then
        local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")
        -- logically need boots to enter mansion
        return (forest_pass and hasItem("boots")) or BoosMansionPipeRoomAccess()
    end
    return false
end

function GL_BoosMansionAccess()
    if BoosMansionAccess() then
        return true
    end
    if ToadTownAccess() then
        local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")
        return (forest_pass and canClimbShortLedges()) or GL_BoosMansionPipeRoomAccess()
    end
    return false
end

function ForeverForestAccess()
    if ToadTownAccess() then
        return hasItem("forest_pass_base") or hasItem("open_forest")
    end
    return false
end

function GL_ForeverForestAccess()
    if ToadTownAccess() then
        return hasItem("forest_pass_base") or hasItem("open_forest") or GL_BoosMansionPipeRoomAccess()
    end
    return false
end

function GustyGulchAccess()
    -- can climb stairs and turn in boo portrait
    if BoosMansionAccess() then
        return hasItem("boo_portrait_base") and hasItem("boots")
    end

    return false
end

function GL_GustyGulchAccess()
    if GustyGulchAccess() then
        return true
    end

    if GL_BoosMansionAccess() then
        if hasItem("boo_portrait_base") then
            if hasItem("boots") or (canClimbShortLedges() and hasItem("weight_base")) then
                return true
            end
        end
    end

    local forest_pass = hasItem("forest_pass_base") or hasItem("open_forest")
    local ch3_shortcut = GL_BoosMansionPipeRoomAccess()
    if (forest_pass or ch3_shortcut) and (canDoLakiTeleports() or canDoLZS()) then
        return true
    end
    return false
end

function TubbaCastleEntranceAccess()
    return parakarry() and GustyGulchAccess()
end

function GL_TubbaCastleEntranceAccess()
    if TubbaCastleEntranceAccess() then
        return true
    end
    return (canClimbShortLedges() or canDoClippy()) and GL_GustyGulchAccess()
end

function TubbaCastleAccess()
    return DungeonAccessible(3)
end

function GL_TubbaCastleAccess()
    return GL_DungeonAccessible(3)
end

--[[----------------------------------------------------------
    Chapter 4 Region Access
------------------------------------------------------------]]
function ToyBoxEntranceAccess()
    if ToadTownAccess() then
        if bow() or hasItem("open_toy_box") then
            return canClimbShortLedges()
        end
    end
    return false
end

function GL_ToyBoxEntranceAccess()
    if ToyBoxEntranceAccess() then
        return true
    end
    if ToadTownAccess() then
        return canDoToadLureHammerClip() and canClimbShortLedges()
    end
    return false
end

function ToyBoxAccess()
    return DungeonAccessible(4)
end

function GL_ToyBoxAccess()
    return GL_DungeonAccessible(4)
end

function ToyBoxPinkAccess()
    local can_place_train = ToyBoxEntranceAccess()
    if ToyBoxAccess() and can_place_train then
        return hasItem("boots") and hasItem("toy_train_base")
    end
    return false
end

function GL_ToyBoxPinkAccess()
    return ToyBoxPinkAccess()
end

function ToyBoxGreenAccess()
    if ToyBoxPinkAccess() then
        if cookingAvailable() and hasItem("cakemix") and hasItem("cake") then
            return true
        end
    end
    return false
end

function GL_ToyBoxGreenAccess()
    if ToyBoxGreenAccess() then
        return true
    end
    if GL_ToyBoxPinkAccess() then
        if hasItem("cake") then
            return true -- out of logic with just cake item
        end
    end
    return false
end

function ToyBoxRedAccess()
    if hasItem("hammer") then
        if ToyBoxGreenAccess() then
            if hasItem("mystery_note_base") and hasItem("dictionary_base") then
                return true
            end
        end
    end
    return false
end

function GL_ToyBoxRedAccess()
    if ToyBoxRedAccess() then
        return true
    end
    if hasItem("hammer") then
        return GL_ToyBoxGreenAccess()
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
    local blue_house_access = BlueHousePipeAccess()

    -- Whale
    if hasItem("open_whale") or ((boots2 or hammer or bombette) and watt()) then
        return true
    -- shortcut pipe through blue house
    elseif blue_house_access and bombette then
        return true
    -- shortcut pipe through main sewer entrance
    elseif boots2 and sushie() then
        return true
    end
    return false
end

function GL_YoshisIslandAccess()
    return YoshisIslandAccess() or (GL_BlueHousePipeAccess() and bombette())
end

function VolcanoEntranceAccess()
    if YoshisIslandAccess() then
        if sushie() and hasItem("jade_raven_base") and hasItem("boots") and hasItem("hammer") then
            return true
        end
    end
    return false
end

function GL_VolcanoEntranceAccess()
    if VolcanoEntranceAccess() then
        return true
    end
    if GL_YoshisIslandAccess() then
        if parakarry() or canClimbWeirdGeometry() or canDoLakiTeleports() then
            return true
        end
    end
    return false
end

function VolcanoAccess()
    return DungeonAccessible(5)
end

function GL_VolcanoAccess()
    return GL_DungeonAccessible(5)
end

--[[----------------------------------------------------------
    Chapter 6 Region Access
------------------------------------------------------------]]
function FlowerFieldsGateAccess()
    return ToadTownAccess() and hasItem("seed1") and hasItem("seed2") and hasItem("seed3") and hasItem("seed4")
end

function GL_FlowerFieldsGateAccess()
    return FlowerFieldsGateAccess()
end

function FlowerFieldsAccess()
    return DungeonAccessible(6)
end

function GL_FlowerFieldsAccess()
    return GL_DungeonAccessible(6)
end

--[[----------------------------------------------------------
    Chapter 7 Region Access
------------------------------------------------------------]]
function ShiverCityAccess()
    if ToadTownAccess() then
        local blue_house_access = BlueHousePipeAccess()
        -- bridge room access
        if (blue_house_access and bombette()) or (hasItem("boots2") and sushie()) then
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

function GL_ShiverCityAccess()
    if ShiverCityAccess() then
        return true
    end
    if ToadTownAccess() then
        local blue_house_access = GL_BlueHousePipeAccess()
        -- bridge room access
        if (blue_house_access and bombette()) or (hasItem("boots2") and sushie()) then
            -- cross already open bridge
            if hasItem("open_ch7_bridge") then
                return canClimbShortLedges()
            -- activate bridge
            elseif hasItem("boots2") or hasItem("boots3") then
                return true
            end
        end
    end
    return false
end

function ShiverMountainAccess()
    local a = ShiverCityAccess()
    return a and hasItem("warehouse_key") and hasItem("scarf") and hasItem("bucket")
end

function GL_ShiverMountainAccess()
    if ShiverMountainAccess() then
        return true
    end
    if GL_ShiverCityAccess() then
        if hasItem("warehouse_key") or canDoLakiClips() then
            if hasItem("scarf") and hasItem("bucket") then
                return true
            elseif canDoSushieGlitch() then
                return true
            end
        end
    end
    return false
end

function ShiverMountainPart2Access()
    return ShiverMountainAccess() and kooper()
end

function GL_ShiverMountainPart2Access()
    if ShiverMountainPart2Access() then
        return true
    end
    return GL_ShiverMountainAccess() and (kooper() or canDoSushieGlitch())
end

function CrystalPalaceEntranceAccess()
    return ShiverMountainPart2Access() and hasItem("star_stone")
end

function GL_CrystalPalaceEntranceAccess()
    return GL_ShiverMountainPart2Access() and hasItem("star_stone")
end

function CrystalPalaceAccess()
    return DungeonAccessible(7)
end

function GL_CrystalPalaceAccess()
    return GL_DungeonAccessible(7)
end

--[[----------------------------------------------------------
    Chapter 8 Region Access
------------------------------------------------------------]]
function BowsersCastleEntranceAccess()
    -- need a way to verify star road access
    return true
end

function GL_BowsersCastleEntranceAccess()
    return BowsersCastleEntranceAccess()
end

function BowsersCastleAccess()
    return DungeonAccessible(8)
end

function GL_BowsersCastleAccess()
    return GL_DungeonAccessible(8)
end
