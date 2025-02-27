function canDoClippy()
    return lakilester()
end

function canDoLakiTeleports()
    return lakilester()
end

function canDoLakiClips()
    return lakilester()
end

function canDoBHS()
    return hasItem("boots")
end

function canDoLZS()
    return hasItem("boots")
end

function canClimbWeirdGeometry()
    return hasItem("boots")
end

function canDoToadLureHammerClip()
    return hasItem("hammer")
end

function canDoSushieGlitch()
    local has_other_partner = goombario() or kooper() or bombette() or parakarry() or bow() or watt() or lakilester()
    return sushie() and has_other_partner
end

function canRemapController()
    return true
end
