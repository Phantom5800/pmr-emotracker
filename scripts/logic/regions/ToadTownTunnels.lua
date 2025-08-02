function Toad_Town_Tunnels_Ch7_Bridge_Blocks()
    if hasItem("boots2") then
        if hasItem("open_ch7_bridge") then
            return returnNormalAccess()
        else
            return returnSequenceBreak()
        end
    elseif hasItem("boots3") then
        return hiddenBlocks()
    end
    return returnNoAccess()
end

function Toad_Town_Tunnels_Winding_Path()
    if lakilester() and hasItem("boots") then
        if sushie() and hasItem("boots2") then
            return true
        elseif bombette() then
            return BlueHousePipeAccess()
        end
    end
    return returnNoAccess()
end

function Toad_Town_Tunnels_Before_Ultra_Boots()
    if hasItem("hammer2") then
        return returnNormalAccess()
    elseif canDoClippy() then
        return returnSequenceBreak()
    end
    return returnNoAccess()
end

function Toad_Town_Tunnels_Ultra_Boots()
    if hasItem("hammer3") then
        return returnNormalAccess()
    elseif canDoClippy() then
        return returnSequenceBreak()
    end
    return returnNoAccess()
end
