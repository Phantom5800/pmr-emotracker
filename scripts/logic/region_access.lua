function GoombaVillageAccess()
    local open_prologue = Tracker:ProviderCountForCode("open_prologue") > 0
    local boots = Tracker:ProviderCountForCode("boots") > 0
    local hammer = Tracker:ProviderCountForCode("hammer") > 0
    local bombette = Tracker:ProviderCountForCode("bombette") > 0
    local parakarry = Tracker:ProviderCountForCode("parakarry") > 0
    local hammer2 = Tracker:ProviderCountForCode("hammer2") > 0

    if open_prologue and (boots or parakarry) and (hammer or bombette) then
        print("Gooma Access")
        return 1
    elseif hammer2 and boots then
        return 1
    end
    return 0
end

function GoombaRoadAccess()
    local open_prologue = Tracker:ProviderCountForCode("open_prologue") > 0
    local boots = Tracker:ProviderCountForCode("boots") > 0
    local parakarry = Tracker:ProviderCountForCode("parakarry") > 0
    local hammer2 = Tracker:ProviderCountForCode("hammer2") > 0

    if open_prologue and (boots or parakarry) then
        print("Gooma Access")
        return 1
    elseif hammer2 and boots then
        return 1
    end
    return 0
end

function KoopaVillageAccess()
    local boots = Tracker:ProviderCountForCode("boots") > 0
    local hammer = Tracker:ProviderCountForCode("hammer") > 0
    local bombette = Tracker:ProviderCountForCode("bombette") > 0
    local parakarry = Tracker:ProviderCountForCode("parakarry") > 0

    if (hammer or bombette) and (boots or parakarry) then
        return 1
    end

    return 0
end
