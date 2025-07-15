-- Helper functions to apply sequence break logic to favors that required cooking
function OneItemCooking()
    if cookingAvailable() then
        return nil
    end
    return AccessibilityLevel.SequenceBreak
end

function TwoItemCooking()
    if cookingAvailable() and hasItem("cookbook") then
        return nil
    end
    return AccessibilityLevel.SequenceBreak
end

-- Koopa Koot Favor 1
function CanStartKoopaKoot0()
    return KoopaVillageAccess() and hasItem("hammer")
end

function CanCompleteKoopaKoot0()
    return hasItem("koopa_legends_base") and CanStartKoopaKoot0()
end

-- Koopa Koot Favor 2
function CanStartKoopaKoot1()
    return hasItem("koopa_legends")
end

function CanCompleteKoopaKoot1()
    return hasItem("sleepy_sheep_base") and CanStartKoopaKoot1()
end

-- Koopa Koot Favor 3
function CanStartKoopaKoot2()
    return hasItem("sleepy_sheep") and itemCount("star_spirit") >= 1
end

function CanCompleteKoopaKoot2()
    return hasItem("tape_base") and CanStartKoopaKoot2()
end

-- Koopa Koot Favor 4
function CanStartKoopaKoot3()
    return hasItem("tape") and itemCount("star_spirit") >= 1
end

function CanCompleteKoopaKoot3()
    return hasItem("koopa_tea_base") and CanStartKoopaKoot3(), OneItemCooking()
end

-- Koopa Koot Favor 5
function CanStartKoopaKoot4()
    return hasItem("koopa_tea") and itemCount("star_spirit") >= 1, OneItemCooking()
end

function CanCompleteKoopaKoot4()
    return hasItem("luigi_autograph_base") and CanStartKoopaKoot4(), OneItemCooking()
end

-- Koopa Koot Favor 6
function CanStartKoopaKoot5()
    return hasItem("luigi_autograph") and itemCount("star_spirit") >= 2, OneItemCooking()
end

function CanCompleteKoopaKoot5()
    return hasItem("wallet_base") and CanStartKoopaKoot5(), OneItemCooking()
end

-- Koopa Koot Favor 7
function CanStartKoopaKoot6()
    return hasItem("wallet") and itemCount("star_spirit") >= 2, OneItemCooking()
end

function CanCompleteKoopaKoot6()
    return hasItem("tasty_tonic_base") and CanStartKoopaKoot6(), OneItemCooking()
end

-- Koopa Koot Favor 8
function CanStartKoopaKoot7()
    return hasItem("tasty_tonic") and itemCount("star_spirit") >= 2, OneItemCooking()
end

function CanCompleteKoopaKoot7()
    return hasItem("merluvlee_autograph_base") and CanStartKoopaKoot7(), OneItemCooking()
end

-- Koopa Koot Favor 9
function CanStartKoopaKoot8()
    return hasItem("merluvlee_autograph") and itemCount("star_spirit") >= 3, OneItemCooking()
end

function CanCompleteKoopaKoot8() -- news sign
    return CanStartKoopaKoot8() and ToadTownAccess(), OneItemCooking()
end

-- Koopa Koot Favor 10
function CanStartKoopaKoot9()
    return itemCount("star_spirit") >= 3 and CanCompleteKoopaKoot8(), OneItemCooking()
end

function CanCompleteKoopaKoot9()
    return hasItem("life_shroom_base") and CanStartKoopaKoot9(), TwoItemCooking()
end

-- Koopa Koot Favor 11
function CanStartKoopaKoot10()
    return hasItem("life_shroom") and itemCount("star_spirit") >= 3, TwoItemCooking()
end

function CanCompleteKoopaKoot10()
    return hasItem("nutty_cake_base") and CanStartKoopaKoot10(), TwoItemCooking()
end

-- Koopa Koot Favor 12
function CanStartKoopaKoot11() -- neighbors
    return hasItem("nutty_cake") and itemCount("star_spirit") >= 4, TwoItemCooking()
end

function CanCompleteKoopaKoot11()
    return hasItem("eldstar") and bombette() and CanStartKoopaKoot11(), TwoItemCooking()
end

-- Koopa Koot Favor 13
function CanStartKoopaKoot12()
    return itemCount("star_spirit") >= 4 and CanCompleteKoopaKoot11(), TwoItemCooking()
end

function CanCompleteKoopaKoot12()
    return hasItem("old_photo_base") and CanStartKoopaKoot12(), TwoItemCooking()
end

-- Koopa Koot Favor 14
function CanStartKoopaKoot13()
    return hasItem("old_photo") and itemCount("star_spirit") >= 4, TwoItemCooking()
end

function CanCompleteKoopaKoot13()
    return hasItem("koopasta_base") and CanStartKoopaKoot13(), TwoItemCooking()
end

-- Koopa Koot Favor 15
function CanStartKoopaKoot14()
    return hasItem("koopasta") and itemCount("star_spirit") >= 5, TwoItemCooking()
end

function CanCompleteKoopaKoot14()
    return hasItem("glasses_base") and CanStartKoopaKoot14(), TwoItemCooking()
end

-- Koopa Koot Favor 16
function CanStartKoopaKoot15()
    return hasItem("glasses") and itemCount("star_spirit") >= 5, TwoItemCooking()
end

function CanCompleteKoopaKoot15()
    return hasItem("lime_base") and CanStartKoopaKoot15(), TwoItemCooking()
end

-- Koopa Koot Favor 17
function CanStartKoopaKoot16()
    return hasItem("lime") and itemCount("star_spirit") >= 5, TwoItemCooking()
end

function CanCompleteKoopaKoot16()
    return hasItem("kooky_cookie_base") and CanStartKoopaKoot16(), TwoItemCooking()
end

-- Koopa Koot Favor 18
function CanStartKoopaKoot17()
    return hasItem("kooky_cookie") and itemCount("star_spirit") >= 6, TwoItemCooking()
end

function CanCompleteKoopaKoot17()
    return hasItem("package_base") and CanStartKoopaKoot17(), TwoItemCooking()
end

-- Koopa Koot Favor 19
function CanStartKoopaKoot18()
    return hasItem("package") and itemCount("star_spirit") >= 6, TwoItemCooking()
end

function CanCompleteKoopaKoot18()
    return hasItem("coconut_base") and CanStartKoopaKoot18(), TwoItemCooking()
end

-- Koopa Koot Favor 20
function CanStartKoopaKoot19()
    return hasItem("coconut") and itemCount("star_spirit") >= 6, TwoItemCooking()
end

function CanCompleteKoopaKoot19()
    return hasItem("red_jar_base") and CanStartKoopaKoot19(), TwoItemCooking()
end
