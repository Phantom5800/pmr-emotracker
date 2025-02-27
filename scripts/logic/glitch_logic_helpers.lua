function canDoClippy()
    return lakilester()
end

function canDoLakiTeleports()
    return lakilester()
end

function canDoSushieGlitch()
    local has_other_partner = goombario() or kooper() or bombette() or parakarry() or bow() or watt() or lakilester()
    return sushie() and has_other_partner
end

function canRemapController()
    return true
end
