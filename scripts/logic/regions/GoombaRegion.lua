function Goomba_Region_Goombaria_Dolly()
    return has("dolly_base")
end

function Goomba_Region_Goompa_Tape()
    return has("koot_talk_3")
end

function Goomba_Region_Goompapa_Letter_1()
    return parakarry() and has("goompapa1_base")
end

function Goomba_Region_Goompapa_Letter_2()
    return parakarry() and has("goompapa2_base")
end

function Goomba_Region_Goompa_Letter()
    return parakarry() and has("goompa_base")
end

function Goomba_Region_Ledge_Starpiece()
    return hasItem("boots")
end

function Goomba_Region_Tree_Near_Starpiece()
    return hasItem("boots") and canHitTrees()
end

function Goomba_Region_Repel_Gel()
    if hasItem("hammer2") and canHitBlocks() then
        return hiddenBlocks()
    elseif hasItem("boots") and (kooper() or bombette() or parakarry()) then
        return true,AccessibilityLevel.SequenceBreak
    elseif parakarry() and lakilester() and (kooper() or bombette()) then
        return true,AccessibilityLevel.SequenceBreak
    elseif hasItem("boots") and lakilester() then
        return true,AccessibilityLevel.SequenceBreak
    end
    return false
end
