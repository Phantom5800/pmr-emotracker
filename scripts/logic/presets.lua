Preset = CustomItem:extend()

local ALL_PRESETS = {}

function Preset:init(name, code, imagePath)
    self:createItem(name)
    self.code = code
    self:setProperty("active", false)
    self.activeImage = ImageReference:FromPackRelativePath(imagePath)
    self.disabledImage = ImageReference:FromImageReference(self.activeImage, "@disabled")
    self.ItemInstance.PotentialIcon = self.activeImage

    self:updateIcon()

    table.insert(ALL_PRESETS, self)
end

function Preset:setActive(active)
    self:setProperty("active", active)
end

function Preset:getActive()
    return self:getProperty("active")
end

function Preset:updateIcon()
    if self:getActive() then
        self.ItemInstance.Icon = self.activeImage
    else
        self.ItemInstance.Icon = self.disabledImage
    end
end

function Preset:onLeftClick()
    for i,preset in ipairs(ALL_PRESETS) do
        preset:setActive(false)
        preset:updateIcon()
    end

    --                prologue      cooking       rugged        toybox        ch7
    --                       blue house    hidden        forest        whale
        openareas = { false, false, false, false, false, false, false, false, false }

    --                shop          merlow        panels        coin block    letters       koot          upgrades      dungeon
    --                       rowf          keysanity     coins         foliage       dojo          event toad    multicoin
        settings  = { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }

    if self.code == "blitz_preset" then
        openareas = { true,  false, true,  true,  false, true,  false, false, false }
        settings  = { true,  true,  false, true,  false, false, false, false, false, false, false, false, false, false, false }

        Tracker:FindObjectForCode("boots").CurrentStage = 1
        Tracker:FindObjectForCode("hammer").CurrentStage = 1
        Tracker:FindObjectForCode("ultrastone").Active = true
        Tracker:FindObjectForCode("cookbook_base").Active = true
        Tracker:FindObjectForCode("seed1").Active = true
        Tracker:FindObjectForCode("seed2").Active = true
    elseif self.code == "s1_race_preset" then
        openareas = { true,  false, false, false, false, true,  false, false, false }
        settings  = { true,  true,  true,  true,  false, false, false, false, false, false, false, false, false, false, false }

        Tracker:FindObjectForCode("boots").CurrentStage = 1
        Tracker:FindObjectForCode("hammer").CurrentStage = 1
        Tracker:FindObjectForCode("seed1").Active = true
        Tracker:FindObjectForCode("seed2").Active = true
    elseif self.code == "extreme_preset" then
        openareas = { false, false, false, false, false, true,  false, false, true }
        settings  = { true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true }
    end

    Tracker:FindObjectForCode("shopsanity_setting").Active = settings[1]
    Tracker:FindObjectForCode("rowf_setting").Active = settings[2]
    Tracker:FindObjectForCode("merlow_setting").Active = settings[3]
    Tracker:FindObjectForCode("keysanity_setting").Active = settings[4]
    Tracker:FindObjectForCode("panels_setting").Active = settings[5]
    Tracker:FindObjectForCode("coins_setting").Active = settings[6]
    Tracker:FindObjectForCode("coin_block_setting").Active = settings[7]
    Tracker:FindObjectForCode("foliage_setting").Active = settings[8]
    Tracker:FindObjectForCode("letters_setting").Active = settings[9]
    Tracker:FindObjectForCode("dojo_setting").Active = settings[10]
    Tracker:FindObjectForCode("koot_setting").Active = settings[11]
    Tracker:FindObjectForCode("trading_setting").Active = settings[12]
    Tracker:FindObjectForCode("upgrades_setting").Active = settings[13]
    Tracker:FindObjectForCode("multicoin_setting").Active = settings[14]
    Tracker:FindObjectForCode("dungeon_setting").Active = settings[15]

    Tracker:FindObjectForCode("open_prologue").Active = openareas[1]
    Tracker:FindObjectForCode("open_blue_house").Active = openareas[2]
    Tracker:FindObjectForCode("open_cooking").Active = openareas[3]
    Tracker:FindObjectForCode("hidden_blocks_visible").Active = openareas[4]
    Tracker:FindObjectForCode("open_mt_rugged").Active = openareas[5]
    Tracker:FindObjectForCode("open_forest").Active = openareas[6]
    Tracker:FindObjectForCode("open_toy_box").Active = openareas[7]
    Tracker:FindObjectForCode("open_whale").Active = openareas[8]
    Tracker:FindObjectForCode("open_ch7_bridge").Active = openareas[9]

    self:setActive(true)
    self:updateIcon()
end

function Preset:onRightClick()
end

function Preset:canProvideCode(code)
    return code == self.code
end

function Preset:advanceToCode(code)
    if code == nil or code == self.code then
        self:setActive(true)
    end
end

function Preset:save()
    local saveData = {}
    saveData["active"] = self:getActive()
    return saveData
end

function Preset:load(data)
    if data["active"] ~= nil then
        self:setActive(data["active"])
    end
    return true
end

function Preset:propertyChanged(key, value)
    self:updateIcon()
end
