function Toad_Town_Inside_Blue_House()
    return hasItem("oddkey_base") or hasItem("open_blue_house") or (bombette() and sushie() and hasItem("boots2"))
end

function GL_Toad_Town_Inside_Blue_House()
    return Toad_Town_Inside_Blue_House() or hasItem("hammer") or hasItem("boots")
end
