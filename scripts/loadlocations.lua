Tracker:AddLocations("locations/GoombaRegion.json")
Tracker:AddLocations("locations/ToadTown.json")
Tracker:AddLocations("locations/ToadTownTunnels.json")
Tracker:AddLocations("locations/PleasantPath.json")
Tracker:AddLocations("locations/KoopaBrosFortress.json")
Tracker:AddLocations("locations/MtRugged.json")
Tracker:AddLocations("locations/DryDryDesert.json")
Tracker:AddLocations("locations/DryDryRuins.json")
Tracker:AddLocations("locations/ForeverForest.json")
Tracker:AddLocations("locations/BoosMansion.json")
Tracker:AddLocations("locations/GustyGulch.json")
Tracker:AddLocations("locations/TubbasCastle.json")
Tracker:AddLocations("locations/ShyGuysToyBox.json")
Tracker:AddLocations("locations/LavalavaIsland.json")
Tracker:AddLocations("locations/MtLavalava.json")
Tracker:AddLocations("locations/FlowerFields.json")
Tracker:AddLocations("locations/ShiverRegion.json")
Tracker:AddLocations("locations/CrystalPalace.json")

-- World Map uses ref locations, only available in PopTracker
if PopVersion then
  Tracker:AddLocations("locations/WorldMap.json")
end
