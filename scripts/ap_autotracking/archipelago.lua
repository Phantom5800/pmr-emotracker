AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true
-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/ap_autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/ap_autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    print("starting onClear")
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        -- print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                -- elseif v[2] == "toggle_badged" then

                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}

    print('getting slot options')
    print('contents of slot_data')
    for key,value in pairs(slot_data) do
        print(key, value)
    end


    if slot_data['include_shops'] then
        local obj = Tracker:FindObjectForCode('shopsanity_setting')
        if obj then
            obj.Active = slot_data['include_shops']
        end
    end

    if slot_data['rowf_items'] then
        local obj = Tracker:FindObjectForCode('rowf_setting')
        if obj then
            obj.Active = slot_data['rowf_items']
        end
    end

    if slot_data['merlow_items'] then
        local obj = Tracker:FindObjectForCode('merlow_setting')
        if obj then
            obj.Active = slot_data['merlow_items']
        end
    end

    if slot_data['keysanity'] then
        local obj = Tracker:FindObjectForCode('keysanity_setting')
        if obj then
            obj.Active = slot_data['keysanity']
        end
    end

    if slot_data['shuffle_hidden_panels'] then
        local obj = Tracker:FindObjectForCode('panels_setting')
        if obj then
            obj.Active = slot_data['shuffle_hidden_panels']
        end
    end

    if slot_data['overworld_coins'] then
        local obj = Tracker:FindObjectForCode('coins_setting')
        if obj then
            obj.Active = slot_data['overworld_coins']
        end
    end

    if slot_data['coin_blocks'] then
        local obj = Tracker:FindObjectForCode('coin_block_setting')
        if obj then
            obj.Active = slot_data['coin_blocks']
        end
    end

    if slot_data['foliage_coins'] then
        local obj = Tracker:FindObjectForCode('foliage_setting')
        if obj then
            obj.Active = slot_data['foliage_coins']
        end
    end

    if slot_data['letter_rewards'] then
        local obj = Tracker:FindObjectForCode('letters_setting')
        if obj then
            obj.Active = slot_data['letter_rewards']
        end
    end

    if slot_data['dojo'] then
        local obj = Tracker:FindObjectForCode('dojo_setting')
        if obj then
            obj.Active = slot_data['dojo']
        end
    end

    if slot_data['koot_favors'] then
        local obj = Tracker:FindObjectForCode('koot_setting')
        if obj then
            obj.Active = slot_data['koot_favors']
        end
    end

    if slot_data['trading_events'] then
        local obj = Tracker:FindObjectForCode('trading_setting')
        if obj then
            obj.Active = slot_data['trading_events']
        end
    end

    if slot_data['partner_upgrades'] then
        local obj = Tracker:FindObjectForCode('upgrades_setting')
        if obj then
            obj.Active = slot_data['partner_upgrades']
        end
    end

    if slot_data['coin_blocks'] then
        local obj = Tracker:FindObjectForCode('multicoin_setting')
        if obj then
            obj.Active = slot_data['coin_blocks']
        end
    end

    if slot_data['shuffle_dungeon_entrances'] then
        local obj = Tracker:FindObjectForCode('dungeon_setting')
        if obj then
            obj.Active = slot_data['shuffle_dungeon_entrances']
        end
    end

    if slot_data['partners_always_usuable'] then
        local obj = Tracker:FindObjectForCode('partners_always')
        if obj then
            obj.Active = slot_data['partners_always_usuable']
        end
    end

    if slot_data['open_prologue'] then
        local obj = Tracker:FindObjectForCode('open_prologue')
        if obj then
            obj.Active = slot_data['open_prologue']
        end
    end

    if slot_data['open_blue_house'] then
        local obj = Tracker:FindObjectForCode('open_blue_house')
        if obj then
            obj.Active = slot_data['open_blue_house']
        end
    end

    if slot_data['cook_without_frying_pan'] then
        local obj = Tracker:FindObjectForCode('open_cooking')
        if obj then
            obj.Active = slot_data['cook_without_frying_pan']
        end
    end

    if slot_data['hidden_block_mode'] then
        local obj = Tracker:FindObjectForCode('hidden_blocks_visible')
        if obj then
            obj.Active = slot_data['hidden_block_mode']
        end
    end

    if slot_data['open_mt_rugged'] then
        local obj = Tracker:FindObjectForCode('open_mt_rugged')
        if obj then
            obj.Active = slot_data['open_mt_rugged']
        end
    end

    if slot_data['open_forest'] then
        local obj = Tracker:FindObjectForCode('open_forest')
        if obj then
            obj.Active = slot_data['open_forest']
        end
    end

    if slot_data['open_toybox'] then
        local obj = Tracker:FindObjectForCode('open_toy_box')
        if obj then
            obj.Active = slot_data['open_toybox']
        end
    end

    if slot_data['open_whale'] then
        local obj = Tracker:FindObjectForCode('open_whale')
        if obj then
            obj.Active = slot_data['open_whale']
        end
    end

    if slot_data['ch7_bridge_visible'] then
        local obj = Tracker:FindObjectForCode('open_ch7_bridge')
        if obj then
            obj.Active = slot_data['ch7_bridge_visible']
        end
    end

    if slot_data['open_whale'] then
        local obj = Tracker:FindObjectForCode('open_twhale')
        if obj then
            obj.Active = slot_data['open_whale']
        end
    end

    if slot_data['magic_seeds'] then
        -- clear magical seeds before enabling the starting seeds
        for i=1,4 do
            local objName = "seed"..i
            local obj = Tracker:FindObjectForCode(objName)
            if obj then
                obj.Active = false
            end
        end

        -- enable only starting seed
        for i=1,slot_data['magic_seeds'] do
            local objName = "seed"..i
            local obj = Tracker:FindObjectForCode(objName)
            if obj then
                obj.Active = true
            end
        end
    end
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
        return
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_name]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_name))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- if a letter is recieved, increment letters
    if string.find(item_name, "Letter to") then
        local obj = Tracker:FindObjectForCode("letters")
        if obj and obj.AcquiredCount < 3 then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        end
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
	for _, w in ipairs(v) do
		print(w)
		local obj = Tracker:FindObjectForCode(w)
		if obj then
			if w:sub(1, 1) == "@" then
				obj.AvailableChestCount = obj.AvailableChestCount - 1
			elseif obj.Type == "progressive" then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onLocation: could not find object for code %s", v[1]))
		end
	end
end


-- add AP callbacks
Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    Archipelago:AddLocationHandler("location handler", onLocation)
end
