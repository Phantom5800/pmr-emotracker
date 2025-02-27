function Mt_Rugged_Upgrade_Block()
    if canHitBlocks() then
        if hasItem("hammer2") then
            return true
        elseif canDoLakiTeleports() then
            return true,AccessibilityLevel.SequenceBreak
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
    elseif lakilester() then
        return true,AccessibilityLevel.SequenceBreak
    end
    return false
end

function Mt_Rugged_Letter_By_Quake_Hammer()
    if parakarry() then
        return true
    elseif canClimbShortLedges() and kooper() then
        return true
    elseif lakilester() then
        return true,AccessibilityLevel.SequenceBreak
    end
    return false
end

function Mt_Rugged_Seed()
    if parakarry() then
        return true
    elseif canDoClippy() then
        return true,AccessibilityLevel.SequenceBreak
    elseif canRemapController() and hasItem("boots") then
        return true,AccessibilityLevel.SequenceBreak
    end
    return false
end

function Mt_Rugged_StarPiece_Coins()
    if parakarry() then
        return true
    elseif lakilester() and hasItem("boots") then
        return true,AccessibilityLevel.SequenceBreak
    elseif canDoClippy() then
        return true,AccessibilityLevel.SequenceBreak
    end
    return false
end
