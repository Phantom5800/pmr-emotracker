# Changelog

## 1.0.0
Initial Release.

## 1.0.4
* Reformat map tracker layouts.

## 1.0.5
* Logic Fix: Bucket and Scarf were not accounted for in Shiver Mountain access.

## 1.0.6
* Logic Fix: Enforce having cake marked for Shy Guy's Toybox Pink Station.

## 1.0.7
* Logic Fix: Toad Town Harbor multicoin block requires boots.

## 1.0.8
* Logic Fix: Miss T. and Russ T. letters incorrectly marked.
* Logic Fix: East Koopa Village item should not be accessible without being able to complete Fuzzy Minigame.
* Logic Fix: Goomba Region brick block puzzle requires a way to hit blocks above Mario.

## 1.0.9
* Change the icon for "Open Chapter 7" to a Bumpty.
* Logic Fix: Can't pull vine in deep jungle without boots.

## 1.0.10
* Logic Fix: Account for Chapter 7 bridge visible for hitting blocks from above.

# 1.0.11
* Logic Fix: Mt. Rugged was accidentally never accessible.

# 1.1.0
* Autotracking support for key items through the Bizhawk connector.
    * This does not track consumables that are on the tracker.

# 1.1.1
* Fix Frying Pan not being checked off by autotracker.
* Fix an out of range issue related to power stars in autotracking.

# 1.2.0
* Poptracker specific layouts.

# 1.2.1
* AP autotracking files for poptracker.

# 1.2.3
* Add vertical layout to Emotracker display.
* Move randomizer settings into gear menu.

# 1.2.4
* Quick hotfix for scrolling vertical layout item section.

# 1.2.5
* Coin bushes in Jade Jungle first room previously had swapped logic.

# 1.2.6
* Missing coin tree in Jade Jungle

# 1.2.8
* Add some new combination items that could be used by overrides for even more compact trackers.
* Add Star Beam item to tracker.

# 1.2.10
* Minor fix for full broadcast view after adding star beam.
* Fix typo in new item names.

# 1.2.11
* Fix weird scaling / cropping issues that impacted lower resolution displays.

# 1.2.12
* Fix Crystal King fight logic not requiring Palace Key.

# 1.2.13
* Fix AP item and location IDs after Star Beam update.

# 1.2.14
* Minor logic scripting fixes for Crystal Palace access.

# 1.2.15
* Minor logic fix for Toy Box Red Station access (missed case in 1.2.14).

# 1.2.16
* Fixed another minor logic error in Red Station access.

# 1.2.17
* Shrink the default item sizes to better accomodate low resolution displays.
* Hide checks from the map if areas are marked as not needed for Limit Chapter Logic.
* Poptracker: Add a world map for all checks on one single screen.

# 1.2.18
* AP location ID updates.
* Add S3 Blitz Preset.

# 1.2.20
* Ch8 added as Dungeon Shuffle locations.
* Ch8 difficulty added.
* Eldstar required for Koopa Koot favor 12.
* Hammer required to clear Fuzzies before Radio Toad events.

# 1.3.0
* Update item id mapping for AP poptracker.
* Add Star Beam as an item that can be autotracked through the Lua connector.
* Autotracking Yoshi kids through Lua connector.
* Forever Forest correctly marked out of logic through sewers access.
* Autotracking Storeroom Key usage fixed for Lua connector.
* Fix Mt Rugged access logic.
* Autotracking for turning in Koot items with Lua connector.
* Fixed two locations in Jade Jungle and Toad Town Tunnels not automatically marking with AP.
* Koopa Koot locations will show vanilla coin / star piece rewards in the map tracker.
* Auto tracking map locations via Lua connector.
