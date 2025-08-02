function Toad_Town_Tunnels_Ch7_Bridge_Blocks()
    if hasItem("boots2") then
        if hasItem("open_ch7_bridge") then
            return true
        end
    elseif hasItem("boots3") then
        return hiddenBlocks()
    end
    return false
end

function GL_Toad_Town_Tunnels_Ch7_Bridge_Blocks()
    return hasItem("boots2") or hasItem("boots3")
end

function Toad_Town_Tunnels_Winding_Path()
    if lakilester() and hasItem("boots") then
        if sushie() and hasItem("boots2") then
            return true
        elseif bombette() then
            return BlueHousePipeAccess()
        end
    end
    return false
end

function GL_Toad_Town_Tunnels_Winding_Path()
    if lakilester() and hasItem("boots") then
        if sushie() and hasItem("boots2") then
            return true
        elseif bombette() then
            return GL_BlueHousePipeAccess()
        end
    end
    return false
end

function Toad_Town_Tunnels_Before_Ultra_Boots()
    return hasItem("hammer2")
end

function GL_Toad_Town_Tunnels_Before_Ultra_Boots()
    return hasItem("hammer2") or canDoClippy()
end

function Toad_Town_Tunnels_Ultra_Boots()
    return hasItem("hammer3")
end

function GL_Toad_Town_Tunnels_Ultra_Boots()
    return hasItem("hammer3") or canDoClippy()
end
