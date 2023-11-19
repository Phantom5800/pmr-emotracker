function hasItem(item)
    return Tracker:ProviderCountForCode(item) > 0
end

function canBreakYellowBlocks()
    return hasItem("bombette") or hasItem("hammer")
end

function canClimbShortLedges()
    return hasItem("boots") or hasItem("parakarry")
end

function canHitBlocks()
    return hasItem("boots") or hasItem("kooper")
end

function hiddenBlocks()
    local watt = hasItem("watt")
    if watt then
        return 1
    else
        return 1, AccessibilityLevel.SequenceBreak
    end
end
