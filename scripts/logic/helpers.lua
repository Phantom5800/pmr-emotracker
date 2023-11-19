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
    if hasItem("watt") or hasItem("hidden_blocks_visible") then
        return 1
    else
        return 1, AccessibilityLevel.SequenceBreak
    end
end

function cookingAvailable()
    return hasItem("fryingpan_base") or hasItem("open_cooking")
end
