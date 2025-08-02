function Mt_Rugged_Upgrade_Block()
    if canHitBlocks() then
        if hasItem("hammer2") then
            return true
        end
    end
    return false
end

function GL_Mt_Rugged_Upgrade_Block()
    if canHitBlocks() then
        if hasItem("hammer2") then
            return true
        elseif canDoLakiTeleports() then
            return true
        end
    end
    return false
end

function Mt_Rugged_Slide_Coins()
    if canClimbShortLedges() or lakilester() or kooper() then
        return true
    end
    return false
end

function Mt_Rugged_Quake_Hammer()
    if parakarry() then
        return true
    end
    return false
end

function GL_Mt_Rugged_Quake_Hammer()
    if parakarry() then
        return true
    elseif lakilester() then
        return true
    end
    return false
end

function Mt_Rugged_Letter_By_Quake_Hammer()
    if parakarry() then
        return true
    elseif canClimbShortLedges() and kooper() then
        return true
    end
    return false
end

function GL_Mt_Rugged_Letter_By_Quake_Hammer()
    if parakarry() then
        return true
    elseif canClimbShortLedges() and kooper() then
        return true
    elseif lakilester() then
        return true
    end
    return false
end

function Mt_Rugged_Seed()
    return parakarry()
end

function GL_Mt_Rugged_Seed()
    if Mt_Rugged_Seed() then
        return true
    elseif canDoClippy() then
        return true
    elseif canRemapController() and hasItem("boots") then
        return true
    end
    return false
end

function Mt_Rugged_StarPiece_Coins()
    return parakarry()
end

function GL_Mt_Rugged_StarPiece_Coins()
    if Mt_Rugged_StarPiece_Coins() then
        return true
    elseif lakilester() and hasItem("boots") then
        return true
    elseif canDoClippy() then
        return true
    end
    return false
end
