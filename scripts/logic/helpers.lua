function hasItem(item)
    return Tracker:ProviderCountForCode(item) > 0
end

function itemCount(item)
    return Tracker:ProviderCountForCode(item)
end

function itemStage(item)
    return Tracker:FindObjectForCode(item).CurrentStage
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

function canHitTrees()
    return bombette() or hasItem("hammer")
end

function canHitSwitches()
    return hasItem("boots") or hasItem("hammer") or kooper() or bombette()
end

function canFlipPanels()
    return hasItem("boots2") or hasItem("hammer3")
end

function hiddenBlocks()
    if watt() or hasItem("hidden_blocks_visible") then
        return true
    else
        return true, AccessibilityLevel.SequenceBreak
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
