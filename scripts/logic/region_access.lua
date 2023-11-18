--[[----------------------------------------------------------
    Prologue Region Access
------------------------------------------------------------]]
function GoombaVillageAccess()
    local open_prologue = hasItem("open_prologue")
    local boots = hasItem("boots")
    local hammer = hasItem("hammer")
    local bombette = hasItem("bombette")
    local parakarry = hasItem("parakarry")
    local hammer2 = hasItem("hammer2")

    if open_prologue and (boots or parakarry) and (hammer or bombette) then
        return 1
    elseif hammer2 and boots then
        return 1
    end
    return 0
end

function GoombaRoadAccess()
    local open_prologue = hasItem("open_prologue")
    local boots = hasItem("boots")
    local parakarry = hasItem("parakarry")
    local hammer2 = hasItem("hammer2")

    if open_prologue and (boots or parakarry) then
        return 1
    elseif hammer2 and boots then
        return 1
    end
    return 0
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
    local boots = hasItem("boots")
    local hammer = hasItem("hammer")
    local bombette = hasItem("bombette")
    local parakarry = hasItem("parakarry")

    if (hammer or bombette) and (boots or parakarry) then
        return 1
    end

    return 0
end

--[[----------------------------------------------------------
    Chapter 2 Region Access
------------------------------------------------------------]]
function DryDryDesertAccess()
    local boots = hasItem("boots")
    local hammer2 = hasItem("hammer2")
    local bombette = hasItem("bombette")
    local parakarry = hasItem("parakarry")

    if (boots and hammer2) or (bombette and boots and parakarry) then
        return 1
    end
    return 0
end

function MtRuggedAccess()
    local boots = hasItem("boots")
    local open_rugged = boots and hasItem("open_mt_rugged")
    local manual_rugged = boots and (ToadTownAccess() and hasItem("bombette"))

    if boots then
        return open_rugged or manual_rugged or DryDryDesertAccess()
    end
    return 0
end

--[[----------------------------------------------------------
    Chapter 4 Region Access
------------------------------------------------------------]]
function ToyBoxEntranceAccess()
    return ToadTownAccess() and (hasItem("bow") or hasItem("open_toy_box")) and (hasItem("boots") or hasItem("parakarry"))
end

function ToyBoxPinkAccess()
    return ToyBoxEntranceAccess() and hasItem("boots") and hasItem("toy_train_base")
end

function ToyBoxGreenAccess()
    if ToyBoxPinkAccess() then
        if hasItem("fryingpan_base") and hasItem("cakemix") then
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
    local bombette = hasItem("bombette")
    local parakarry = hasItem("parakarry")
    local watt = hasItem("watt")
    local sushie = hasItem("sushie")
    local oddkey = hasItem("oddkey_base") or hasItem("open_blue_house")

    -- Whale
    if hasItem("open_whale") or ((boots2 or hammer or bombette) and watt) then
        return 1
    -- shortcut pipe through blue house
    elseif oddkey and bombette and (boots or parakarry) then
        return 1
    -- shortcut pipe through main sewer entrance
    elseif boots2 and sushie then
        return 1
    end
    return 0
end

--[[----------------------------------------------------------
    Chapter 7 Region Access
------------------------------------------------------------]]
function ShiverCityAccess()
    local boots = hasItem("boots")
    local boots2 = hasItem("boots2")
    local boots3 = hasItem("boots3")
    local oddkey = hasItem("oddkey_base") or hasItem("open_blue_house")
    local open7 = hasItem("open_ch7_bridge")
    local bombette = hasItem("bombette")
    local parakarry = hasItem("parakarry")
    local sushie = hasItem("sushie")
    local watt = hasItem("watt")

    if ToadTownAccess() then
        -- bridge room access
        if (oddkey and bombette) or (boots2 and sushie) then
            -- cross already open bridge
            if open7 then
                return boots or parakarry
            -- activate bridge
            elseif boots3 then
                if watt then
                    return 1
                else
                    return 1, AccessibilityLevel.SequenceBreak
                end
            end
        end
    end
    return 0
end
