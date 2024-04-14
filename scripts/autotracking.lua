-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
-------------------------------------------------------
function autotracker_started()
    print("Autotracking Active")
    -- Invoked when the auto-tracker is activated/connected
end

U8_READ_CACHE = 0
U8_READ_CACHE_ADDRESS = 0

U16_READ_CACHE = 0
U16_READ_CACHE_ADDRESS = 0

OFFSET_ITEM_REGISTRY    = 0x80356B00
OFFSET_MOD_FLAGS        = 0x80357000  -- 0x80357220 (max)
OFFSET_BASE_GAME_FLAGS  = 0x800DBC70  -- 0x800DBD6F (max)

gameActive = false

function InvalidateReadCaches()
    U8_READ_CACHE_ADDRESS = 0
    U16_READ_CACHE_ADDRESS = 0
end

function ReadS8(segment, address)
    local u = ReadU8(segment, address)

    if u == 255 then return -1 else return u end
end

function ReadU8(segment, address)
    if U8_READ_CACHE_ADDRESS ~= address then
        U8_READ_CACHE = segment:ReadUInt8(address)
        U8_READ_CACHE_ADDRESS = address
    end

    return U8_READ_CACHE
end

function ReadU16(segment, address)
    if U16_READ_CACHE_ADDRESS ~= address then
        U16_READ_CACHE = segment:ReadUInt16(address)
        U16_READ_CACHE_ADDRESS = address
    end

    return U16_READ_CACHE
end

function updateProgressiveItemFromBytes(segment, code, address, quantity)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = 0
        for i = 0, quantity-1, 1 do
            if ReadU8(segment, address+i) > 0 then
                value = value + 1
            end
        end
        if item.CurrentStage ~= value then
            print(item.Name .. ": " .. value)
            item.CurrentStage = value
        end
    end
end

function updateLetters(segment, address)
    local item = Tracker:FindObjectForCode("letters")
    if item then
        local value = 0
        for i = 0, 30, 1 do
            if ReadU8(segment, address+i) > 0 and i ~= 9 and i~= 12 and i~= 13 and i~= 14 and i ~= 23 and i~= 29 then
                value = value + 1
            end
        end
        if value > 3 then
            value = 3
        end
        if item.AcquiredCount ~= value then
            print(item.Name .. ": " .. value)
            item.AcquiredCount = value
        end
    end
end

function updateProgressiveToggleStateFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value > 0 then
            if item.ItemState.toggle == false then
                print(item.Name .. " left object Obtained")
                item.ItemState.toggle = true
            end
        else
            item.ItemState.toggle = false
        end
        item.ItemState:updateIcon()
    end
end

function updateProgressiveToggleStateFromByteAndFlag(segment, code, address, flag)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        local flagTest = value & flag
        if flagTest ~= 0 then
            if item.ItemState.toggle == false then
                print(item.Name .. " left object Obtained")
                item.ItemState.toggle = true
            end
        else
            item.ItemState.toggle = false
        end
        item.ItemState:updateIcon()
    end
end

function updateProgressiveToggleStageFromBytes(segment, code, address, quantity)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = 0
        for i = 0, quantity-1, 1 do
            if ReadU8(segment, address+i) > 0 then
                value = value + 1
            end
        end
        if item.AcquiredCount ~= value then
            print(item.Name .. ": " .. value)
            item.AcquiredCount = value
            --item.ItemState:updateIcon()
        end
    end
end

function updateProgressiveToggleStageFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if item.ItemState.stage ~= value+1 then
            print(item.Name .. ": " .. value)
            item.ItemState.stage = value+1
            item.ItemState:updateIcon()
        end
    end
end

function updateProgressiveItemFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if item.ItemState.stage ~= value then
            print(item.Name .. ": " .. value)
            item.CurrentStage = value
        end
    end
end

function updateProgressiveGearFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadS8(segment, address)
        if item.ItemState.stage ~= value+1 then
            print(item.Name .. ": " .. value)
            item.CurrentStage = value+1
        end
    end
end

function updateToggleItemFromByte(segment, code, address, canSetFalse)
    canSetFalse = (canSetFalse ~= false) -- default parameter to true unless false is passed in
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value > 0 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            if canSetFalse then
                item.Active = false
            end
        end
    end
end

function updateToggleItemFromByteAndFlag(segment, code, address, flag, canSetFalse)
    canSetFalse = (canSetFalse ~= false) -- default parameter to true unless false is passed in
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value & flag ~= 0 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            if canSetFalse then
                item.Active = false
            end
        end
    end
end

function updateToggleFromFlag(segment, code, address, flag, canSetFalse)
    canSetFalse = (canSetFalse ~= false) -- default parameter to true unless false is passed in
    local item = Tracker:FindObjectForCode(code)
    if item then
        local offset = flag // 0x20             -- number of 4 byte-wide offsets to shift by
        local bitflag = flag - 0x20 * offset    -- which bit corresponds to the flag in this region
        -- byte swap the 32 bit region
        local value =   (ReadU8(segment, address + offset*4 + 0x3)) |
                        (ReadU8(segment, address + offset*4 + 0x2) <<  8) |
                        (ReadU8(segment, address + offset*4 + 0x1) << 16) |
                        (ReadU8(segment, address + offset*4 + 0x0) << 24)
        if canSetFalse then
            item.Active = (value & (1 << bitflag)) ~= 0
        else
            -- this is used for some flags where we don't want to allow autotracking to
            -- disable the item in the tracker
            if (value & (1 << bitflag)) ~= 0 then
                item.Active = true
            end
        end
    end
end

function updateGameStatus()
    -- check game status
    if AutoTracker:ReadU8(0x800A0841) >= 4 and AutoTracker:ReadU8(0x800A0841) < 12 then
        gameActive = true
    else
        gameActive = false
    end
end

function ScanKeyItems(segment) --for debugging
    for i = 0, 0x204, 1 do
        if ReadU8(segment, OFFSET_ITEM_REGISTRY+i) > 0 then
            print ("Address " .. string.format("%x",i) .. ": " .. ReadU8(segment, OFFSET_ITEM_REGISTRY+i))
        end
    end
end

function updateKeyItems(segment)
    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateGameStatus()
        if gameActive then
            updateToggleItemFromByte(segment,"ultrastone",0xF+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"pulse_stone",0x12+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"palace_key",0x14+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"lunar_stone",0x15+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"pyramid_stone",0x16+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"diamond_stone",0x17+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"kooper_shell_base",0x19+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"forest_pass_base",0x1B+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"weight_base",0x1C+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"boo_portrait_base",0x1D+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"crystal_berry_base",0x1E+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"storeroom_key_base",0x20+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"toy_train_base",0x21+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"record_base",0x22+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"fryingpan_base",0x23+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"dictionary_base",0x24+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"mystery_note_base",0x25+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"cookbook_base",0x29+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"jade_raven_base",0x2A+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"seed1",0x2B+OFFSET_ITEM_REGISTRY, false)
            updateToggleItemFromByte(segment,"seed2",0x2C+OFFSET_ITEM_REGISTRY, false)
            updateToggleItemFromByte(segment,"seed3",0x2D+OFFSET_ITEM_REGISTRY, false)
            updateToggleItemFromByte(segment,"seed4",0x2E+OFFSET_ITEM_REGISTRY, false)
            updateToggleItemFromByte(segment,"calculator_base",0x30+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"bucket",0x31+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"scarf",0x32+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"red_key",0x33+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"blue_key_base",0x34+OFFSET_ITEM_REGISTRY)

            updateLetters(segment, 0x36+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"merlon_base",0x36+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"goompa_base",0x37+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"mort_t_base",0x38+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"russ_t_base",0x39+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"mayor_penguin_base",0x3A+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"merlow_base",0x3B+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"fice_t_base",0x3C+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"nomadimouse_base",0x3D+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"minh_t_base",0x3E+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"goompapa1_base",0x40+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"igor_base",0x41+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"franky_base",0x45+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"muss_t_base",0x46+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"koover1_base",0x47+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"fishmael_base",0x48+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"koover2_base",0x49+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"mr_e_base",0x4A+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"miss_t_base",0x4B+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"little_mouser_base",0x4C+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"dane_t1_base",0x4E+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"red_yoshi_base",0x4F+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"dane_t2_base",0x50+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"frost_t_base",0x51+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"goompapa2_base",0x52+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"kolorado_base",0x54+OFFSET_ITEM_REGISTRY)

            updateToggleItemFromByte(segment,"artifact_base",0x53+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"dolly_base",0x56+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"water_stone_base",0x57+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"bean",0x58+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"soil",0x59+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"water",0x5A+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"volcano_vase_base",0x5B+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"lyrics_base",0x67+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"melody_base",0x68+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"mailbag_base",0x69+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"oddkey_base",0x6B+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"star_stone",0x6C+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"warehouse_key",0x79+OFFSET_ITEM_REGISTRY)
            updateProgressiveToggleStageFromBytes(segment, "ch1_key", 0x16D+OFFSET_ITEM_REGISTRY, 4)
            updateProgressiveToggleStageFromBytes(segment, "ch2_key", 0x171+OFFSET_ITEM_REGISTRY, 4)
            updateProgressiveToggleStageFromBytes(segment, "ch3_key", 0x175+OFFSET_ITEM_REGISTRY, 3)
            updateProgressiveToggleStageFromBytes(segment, "ch8_key", 0x178+OFFSET_ITEM_REGISTRY, 5)
            --updateProgressiveToggleStageFromBytes(segment, "prison_key", 0x17D+OFFSET_ITEM_REGISTRY, 2)
            updateProgressiveToggleStageFromBytes(segment, "blue_berry", 0x180+OFFSET_ITEM_REGISTRY, 2)
            updateToggleItemFromByte(segment, "red_berry_base", 0x182+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"yellow_berry_base",0x183+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"bubble_berry_base",0x184+OFFSET_ITEM_REGISTRY)
            updateProgressiveToggleStageFromBytes(segment, "power_star", 0x1DC+OFFSET_ITEM_REGISTRY, 128)

            updateToggleItemFromByte(segment,"koopa_legends_base",0x6E+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"tape_base",0x5C+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"luigi_autograph_base",0x6F+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"wallet_base",0x70+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"crystal_ball_base",0x27+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"merluvlee_autograph_base",0x71+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"old_photo_base",0x73+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"glasses_base",0x74+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"package_base",0x76+OFFSET_ITEM_REGISTRY)
            updateToggleItemFromByte(segment,"red_jar_base",0x77+OFFSET_ITEM_REGISTRY)
        end
    end
end

function updatePartners(segment)
    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateGameStatus()
        if gameActive then
            updateToggleItemFromByte(segment, "goombario", 0x8010f2ae)
            updateToggleItemFromByte(segment, "kooper", 0x8010f2b6)
            updateToggleItemFromByte(segment, "bombette", 0x8010f2be)
            updateToggleItemFromByte(segment, "parakarry", 0x8010f2c6)
            updateToggleItemFromByte(segment, "bow", 0x8010f2ee)
            updateToggleItemFromByte(segment, "sushie", 0x8010f2de)
            updateToggleItemFromByte(segment, "watt", 0x8010f2d6)
            updateToggleItemFromByte(segment, "lakilester", 0x8010f2e6)
        end
    end
end

function updateEquipment(segment)
    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateGameStatus()
        if gameActive then
            updateProgressiveGearFromByte(segment,"boots_base",0x8010f290)
            updateProgressiveGearFromByte(segment,"hammer_base",0x8010f291)
        end
    end
end

function updateChapters(segment)
    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateGameStatus()
        if gameActive then
            updateToggleItemFromByteAndFlag(segment, "eldstar", 0x80357017, 0x02)
            updateToggleItemFromByteAndFlag(segment, "mamar", 0x80357017, 0x04)
            updateToggleItemFromByteAndFlag(segment, "skolar", 0x80357017, 0x08)
            updateToggleItemFromByteAndFlag(segment, "muskular", 0x80357017, 0x10)
            updateToggleItemFromByteAndFlag(segment, "misstar", 0x80357017, 0x20)
            updateToggleItemFromByteAndFlag(segment, "klevar", 0x80357017, 0x40)
            updateToggleItemFromByteAndFlag(segment, "kalmar", 0x80357017, 0x80)
        end
    end
end

function updateBaseGameCheckAcquisition(segment)
    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateGameStatus()
        if gameActive then
            updateToggleFromFlag(segment, "dictionary", OFFSET_BASE_GAME_FLAGS, 0x0F4)
            updateToggleFromFlag(segment, "mailbag", OFFSET_BASE_GAME_FLAGS, 0x10A)
            updateToggleFromFlag(segment, "melody", OFFSET_BASE_GAME_FLAGS, 0x126)
            updateToggleFromFlag(segment, "lyrics", OFFSET_BASE_GAME_FLAGS, 0x2F2)
            updateToggleFromFlag(segment, "artifact", OFFSET_BASE_GAME_FLAGS, 0x312)
            updateToggleFromFlag(segment, "record", OFFSET_BASE_GAME_FLAGS, 0x3D2)
            updateToggleFromFlag(segment, "volcano_vase", OFFSET_BASE_GAME_FLAGS, 0x4FB)

            updateToggleFromFlag(segment, "seed1", OFFSET_BASE_GAME_FLAGS, 0x114, false)
            updateToggleFromFlag(segment, "seed2", OFFSET_BASE_GAME_FLAGS, 0x115, false)
            updateToggleFromFlag(segment, "seed3", OFFSET_BASE_GAME_FLAGS, 0x116, false)
            updateToggleFromFlag(segment, "seed4", OFFSET_BASE_GAME_FLAGS, 0x117, false)
        end
    end
end

function updateModCheckAcquisition(segment)
    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        updateGameStatus()
        if gameActive then
            -- letter turn ins
            updateToggleFromFlag(segment, "merlon", OFFSET_MOD_FLAGS, 0x1017)
            updateToggleFromFlag(segment, "goompa", OFFSET_MOD_FLAGS, 0x1002)
            updateToggleFromFlag(segment, "mort_t", OFFSET_MOD_FLAGS, 0x1037)
            updateToggleFromFlag(segment, "russ_t", OFFSET_MOD_FLAGS, 0x1008)
            updateToggleFromFlag(segment, "mayor_penguin", OFFSET_MOD_FLAGS, 0x1092)
            updateToggleFromFlag(segment, "merlow", OFFSET_MOD_FLAGS, 0x102B)
            updateToggleFromFlag(segment, "fice_t", OFFSET_MOD_FLAGS, 0x101A)
            updateToggleFromFlag(segment, "nomadimouse", OFFSET_MOD_FLAGS, 0x1055)
            updateToggleFromFlag(segment, "minh_t", OFFSET_MOD_FLAGS, 0x1018)
            updateToggleFromFlag(segment, "goompapa1", OFFSET_MOD_FLAGS, 0x1003)
            updateToggleFromFlag(segment, "igor", OFFSET_MOD_FLAGS, 0x105A)
            updateToggleFromFlag(segment, "franky", OFFSET_MOD_FLAGS, 0x1059)
            updateToggleFromFlag(segment, "muss_t", OFFSET_MOD_FLAGS, 0x10A6)
            updateToggleFromFlag(segment, "koover1", OFFSET_MOD_FLAGS, 0x1038)
            updateToggleFromFlag(segment, "fishmael", OFFSET_MOD_FLAGS, 0x1023)
            updateToggleFromFlag(segment, "koover2", OFFSET_MOD_FLAGS, 0x1039)
            updateToggleFromFlag(segment, "mr_e", OFFSET_MOD_FLAGS, 0x1053)
            updateToggleFromFlag(segment, "miss_t", OFFSET_MOD_FLAGS, 0x1009)
            updateToggleFromFlag(segment, "little_mouser", OFFSET_MOD_FLAGS, 0x104B)
            updateToggleFromFlag(segment, "dane_t1", OFFSET_MOD_FLAGS, 0x101B)
            updateToggleFromFlag(segment, "red_yoshi", OFFSET_MOD_FLAGS, 0x107B)
            updateToggleFromFlag(segment, "dane_t2", OFFSET_MOD_FLAGS, 0x101C)
            updateToggleFromFlag(segment, "frost_t", OFFSET_MOD_FLAGS, 0x109B)
            updateToggleFromFlag(segment, "goompapa2", OFFSET_MOD_FLAGS, 0x1004)
            updateToggleFromFlag(segment, "kolorado", OFFSET_MOD_FLAGS, 0x1042)

            -- misc. item turn ins
            updateToggleFromFlag(segment, "kooper_shell", OFFSET_MOD_FLAGS, 0x1043)
            updateToggleFromFlag(segment, "dolly", OFFSET_MOD_FLAGS, 0x1001)
            updateToggleFromFlag(segment, "storeroom_key", OFFSET_MOD_FLAGS, 0x41)
            updateToggleFromFlag(segment, "calculator", OFFSET_MOD_FLAGS, 0x1016)
            updateToggleFromFlag(segment, "fryingpan", OFFSET_MOD_FLAGS, 0x1019)
            updateToggleFromFlag(segment, "crystal_berry", OFFSET_MOD_FLAGS, 0x1088)
            updateToggleFromFlag(segment, "water_stone", OFFSET_MOD_FLAGS, 0x1087)
        end
    end
end

-- Run the in-game status check more frequently (every 250ms) to catch save/quit scenarios more effectively
ScriptHost:AddMemoryWatch("Key Items", OFFSET_ITEM_REGISTRY, 0x265, updateKeyItems, 250)
ScriptHost:AddMemoryWatch("Partners", 0x8010f2ad, 0x42, updatePartners, 250)
ScriptHost:AddMemoryWatch("Equipment", 0x8010f290, 0x02, updateEquipment, 250)
ScriptHost:AddMemoryWatch("Chapters", 0x80357017, 0x01, updateChapters, 250)

-- watching smaller regions of memory to more closely represent the data being looked at
ScriptHost:AddMemoryWatch("Base Game Checks", OFFSET_BASE_GAME_FLAGS, 0xA0, updateBaseGameCheckAcquisition, 250)
ScriptHost:AddMemoryWatch("Mod Checks", OFFSET_MOD_FLAGS + 0x200, 0x21, updateModCheckAcquisition, 250)
