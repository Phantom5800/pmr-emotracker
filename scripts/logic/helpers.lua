function hasItem(item)
    return Tracker:ProviderCountForCode(item) > 0
end

function canBreakYellowBlocks()
    return bombette() or hasItem("hammer")
end

function canClimbShortLedges()
    return hasItem("boots") or parakarry()
end

function canHitBlocks()
    return hasItem("boots") or kooper()
end

function canHitGroundedBlocks()
    return hasItem("hammer") or kooper() or bombette() or hasItem("boots2")
end

function canHitSwitches()
    return hasItem("boots") or hasItem("hammer") or kooper() or bombette()
end

function hiddenBlocks()
    if watt() or hasItem("hidden_blocks_visible") then
        return 1
    else
        return 1, AccessibilityLevel.SequenceBreak
    end
end

function cookingAvailable()
    return hasItem("fryingpan_base") or hasItem("open_cooking")
end

-- Partners
function kooper()
    return hasItem("kooper") or hasItem("partners_always")
end

function bombette()
    return hasItem("bombette") or hasItem("partners_always")
end

function parakarry()
    return hasItem("parakarry") or hasItem("partners_always")
end

function bow()
    return hasItem("bow") or hasItem("partners_always")
end

function watt()
    return hasItem("watt") or hasItem("partners_always")
end

function sushie()
    return hasItem("sushie") or hasItem("partners_always")
end

function lakilester()
    return hasItem("lakilester") or hasItem("partners_always")
end

-- Kolorado Location
function kolorado_in_desert()
    return not hasItem("mamar")
end
