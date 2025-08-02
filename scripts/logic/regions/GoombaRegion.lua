function Goomba_Region_Goombaria_Dolly()
    return hasItem("dolly_base")
end

function Goomba_Region_Goompa_Tape()
    return CanStartKoopaKoot2()
end

function Goomba_Region_Goompapa_Letter_1()
    return parakarry() and hasItem("goompapa1_base")
end

function Goomba_Region_Goompapa_Letter_2()
    return parakarry() and hasItem("goompapa2_base")
end

function Goomba_Region_Goompa_Letter()
    return parakarry() and hasItem("goompa_base")
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
    end
    return false
end

function GL_Goomba_Region_Repel_Gel()
    if hasItem("hammer2") and canHitBlocks() then
        return hiddenBlocks()
    elseif hasItem("boots") and (kooper() or bombette() or parakarry() or lakilester()) then
        return true
    elseif parakarry() and lakilester() and (kooper() or bombette()) then
        return true
    end
    return false
end
