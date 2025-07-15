LOCATION_TO_GAME_FLAGS_MAPPING = {

}

LOCATION_TO_MOD_FLAGS_MAPPING = {
    -- Goomba Village
    ["@Goomba Village/Goompa"]                  = {0x1000},
    ["@Goomba Village/Goombaria"]               = {0x1001},
    ["@Goomba Village/Goompa Letter"]           = {0x1002},
    ["@Goomba Village/Goompapa Letter 1"]       = {0x1003},
    ["@Goomba Village/Goompapa Letter 2"]       = {0x1004},
    ["@Goomba Village/Goomnut Tree"]            = {0x1005},
    ["@Goomba Village/Goombario"]               = {0x1006},

    -- Playground
    ["@Playground/Hammer Bush"] = {0x1007},

    -- Toad Town Main Gate
    ["@Main Gate/Russ T. Letter"]       = {0x1008},
    ["@Main Gate/Miss T. Letter"]       = {0x1009},
    ["@Main Gate/Trading Event Toad"]   = {0x100A},
    ["@Main Gate/Shop"]                 = {0x1010, 0x1011, 0x1012, 0x1013, 0x1014, 0x1015},

    -- Toad Town Plaza (Badge Shop)
    ["@Main Gate/Central Plaza/Rowf"]           = {0x1016},
    ["@Main Gate/Central Plaza/Merlon Letter"]  = {0x1017},
    ["@Main Gate/Central Plaza/Minh T. Letter"] = {0x1018},
    ["@Main Gate/Castle Ruins/Muss T. Letter"]  = {0x10A6},

    -- Toad Town South (Tayce T)
    ["@Main Gate/Below Plaza/Tayce T."]         = {0x1019},
    ["@Main Gate/Below Plaza/Fice T. Letter"]   = {0x101A},
    ["@Main Gate/Below Plaza/Fice T."]          = {0x10AE},

    -- Toad Town Train Station
    ["@Main Gate/Below Plaza/Dane T. Letter 1"] = {0x101B},
    ["@Main Gate/Below Plaza/Dane T. Letter 2"] = {0x101C},

    -- Toad Town Residential Area
    ["@Main Gate/Residential Area/Shop"] = {0x101D, 0x101E, 0x101F, 0x1020, 0x1021, 0x1022},

    -- Toad Town Harbor
    ["@Main Gate/Port/Fishmael Letter"]     = {0x1023},
    ["@Main Gate/Port/Trading Event Toad"]  = {0x1024},

    -- Toad Town Tunnels
    ["@Rip Cheato/Rip Cheato"]  = {0x102C, 0x102D, 0x102E, 0x102F, 0x1030, 0x1031, 0x1032, 0x1033, 0x1034, 0x1035, 0x1036},

    -- Shooting Star Summit
    ["@Main Gate/Merluvlee's House/Merlow Letter"]   = {0x102B},
    ["@Main Gate/Merluvlee's House/Merlow Rewards"]  = {0x10A8, 0x10A9, 0x10AA, 0x10AB, 0x10AC, 0x10AD},

    -- Koopa Region
    ["@West Koopa Village/Bush Right of Tree"]  = {0x1049},
    ["@West Koopa Village/Mort T. Letter"]      = {0x1037},
    ["@West Koopa Village/Koover Letter 1"]     = {0x1038},
    ["@West Koopa Village/Koover Letter 2"]     = {0x1039},
    ["@West Koopa Village/Shop"]                = {0x103A, 0x103B, 0x103C, 0x103D, 0x103E, 0x103F},
    ["@East Koopa Village/Far Left Bush"]       = {0x104A},
    ["@East Koopa Village/Far Right Bush"]      = {0x10A7},
    ["@Kolorado/Kolorado (Letter)"]             = {0x1042},
    ["@East Koopa Village/Kooper"]              = {0x1043},
    ["@Fuzzy Minigame/Minigame"]                = {0x1044},

    -- two Koot favors give two items, one is mod flag, one is game flag ... mark twice off one flag
    ["@Koopa Koot/Sleepy Sheep"] = {0x1040, 0x1040}, 
    ["@Koopa Koot/Life Shroom"]  = {0x1041, 0x1041}, 

    -- Koopa Bros Fortress
    ["@Fortress Entrance/Bomb Jail/Bombette"] = {0x1045},

    -- Mt Rugged
    ["@Train Station/Top Bush"]                 = {0x1047},
    ["@Train Station/Parakarry"]                = {0x1048},
    ["@Train Station/Whacka Screen/Whacka"]     = {0x1046},

    -- Dry Dry Desert
    ["@Dry Dry Outpost (West)/Desert (Dry Dry Ruins)/Trading Event Toad"]   = {0x1054},
    ["@Dry Dry Outpost (West)/Desert (Nomadimouse)/Letter"]                 = {0x1055},
    ["@Dry Dry Outpost (West)/Desert (Oasis)/Lemon Tree"]                   = {0x1056},
    ["@Dry Dry Outpost (West)/Desert (Oasis)/Lime Tree"]                    = {0x1057},

    -- Dry Dry Outpost
    ["@Dry Dry Outpost (West)/Little Mouser Letter"]                = {0x104B},
    ["@Dry Dry Outpost (West)/Shop Items"]                          = {0x104C, 0x104D, 0x104E, 0x104F, 0x1050, 0x1051},
    ["@Dry Dry Outpost (West)/Dry Dry Outpost (East)/Moustafa"]     = {0x1052},
    ["@Dry Dry Outpost (West)/Dry Dry Outpost (East)/Mr. E Letter"] = {0x1053},

    -- Boo's Mansion
    ["@Outside Boo's Mansion/Far Right Bush"]                                                   = {0x1058},
    ["@Outside Boo's Mansion/Boo's Mansion Foyer/Franky Letter"]                                = {0x1059},
    ["@Outside Boo's Mansion/Boo's Mansion Foyer/Fake Chest Room/Boo Shop/Igor Letter"]         = {0x105A},
    ["@Outside Boo's Mansion/Boo's Mansion Foyer/Fake Chest Room/Boo Shop/Shop Items"]          = {0x105B, 0x105C, 0x105D, 0x105E, 0x105F, 0x1060},
    ["@Outside Boo's Mansion/Boo's Mansion Foyer/Fake Chest Room/Super Boots Room/Big Chest"]   = {0x35},
    ["@Outside Boo's Mansion/Boo's Mansion Foyer/8bit Mario Room/Crates"]                       = {0x1061, 0x1062},
    ["@Outside Boo's Mansion/Boo's Mansion Foyer/Bow's Bedroom/Bow"]                            = {0x1063},

    -- Shy Guy's Toybox
    ["@Blue Station/Shy Guy Room/Shy Guy Items"]    = {0x1064, 0x1064, 0x1065, 0x1066, 0x1067, 0x1068}, -- calculator shy guy has 2 items, one is a game flag
    ["@Red Station/Lantern Ghost/Watt"]             = {0x1069},

    -- Jade Jungle
    ["@Whale/Coconut Tree"]                             = {0x106A},
    ["@Whale/Beach/Coconut Trees"]                      = {0x106B, 0x106C, 0x106D, 0x106E, 0x106F, 0x1070, 0x1070}, -- star piece in last tree is a game flag
    ["@Whale/Yoshi Village Entrance/Yoshi Chief"]       = {0x1071},
    ["@Whale/Yoshi Village Entrance/Coconut Trees"]     = {0x1072, 0x1073},
    ["@Whale/Yoshi Village Hub/Yellow Yoshi"]           = {0x107A},
    ["@Whale/Yoshi Village Hub/Red Yoshi Kid Letter"]   = {0x107B},
    ["@Whale/Yoshi Village Hub/Shop Items"]             = {0x1074, 0x1075, 0x1076, 0x1077, 0x1078, 0x1079},
    ["@Whale/Yoshi Village Hub/Coconut Tree"]           = {0x107C},
    ["@Whale/Outside Volcano/Raphael"]                  = {0x107E},
    ["@Whale/Sushie Room/Sushie Tree"]                  = {0x107D},

    -- Flower Fields
    ["@Flower Fields Hub Room/Elevator Room (left side)/Second Vine"]                                   = {0x108B},
    ["@Flower Fields Hub Room/Three Trees/Second Vine"]                                                 = {0x1086},
    ["@Flower Fields Hub Room/Three Trees/Petunia Room/Petunia"]                                        = {0x107F},
    ["@Flower Fields Hub Room/Three Trees/Petunia Room/Tree"]                                           = {0x1080, 0x1081},
    ["@Flower Fields Hub Room/Yellow Flower Room (Before Gate)/Vine by Yellow Flower"]                  = {0x1083},
    ["@Flower Fields Hub Room/Yellow Flower Room (Past Gate)/Tree"]                                     = {0x1084, 0x1085},
    ["@Flower Fields Hub Room/Yellow Flower Room (Past Gate)/Bubble Berry Tree Room/Bubble Berry Tree"] = {0x108C, 0x108D},
    ["@Flower Fields Hub Room/Yellow Flower Room (Past Gate)/Lily Room/Lily"]                           = {0x1087},
    ["@Flower Fields Hub Room/Red Flower Room/Middle Vine"]                                             = {0x108E},
    ["@Flower Fields Hub Room/Red Flower Room/Tree"]                                                    = {0x108F, 0x1090},
    ["@Flower Fields Hub Room/Red Flower Room/Posie Room/Posie"]                                        = {0x1082, 0x1082}, -- two gifts, second is a game flag normally
    ["@Flower Fields Hub Room/Blue Flower Room/Hedge Maze/Rosie Room/Rosie"]                            = {0x1088},
    ["@Flower Fields Hub Room/Bubble Plant Room/Vine Item"]                                             = {0x108A},
    ["@Flower Fields Hub Room/Bubble Plant Room/Laki Fight Room/Lakilester"]                            = {0x1089},

    -- Shiver Region
    ["@Shiver City (Middle)/Sleep at Inn"]                                                                              = {0x1093},
    ["@Shiver City (Middle)/Shop Items"]                                                                                = {0x1094, 0x1095, 0x1096, 0x1097, 0x1098, 0x1099},
    ["@Shiver City (Middle)/Shiver City (Left)/Mayor Penguin (Bucket)"]                                                 = {0x1091},
    ["@Shiver City (Middle)/Shiver City (Left)/Mayor Penguin (Letter)"]                                                 = {0x1092},
    ["@Shiver City (Middle)/Shiver Mountain Entrance/Starborne Valley/Merle"]                                           = {0x109A},
    ["@Shiver City (Middle)/Shiver Mountain Entrance/Starborne Valley/Frost T. Letter"]                                 = {0x109B},
    ["@Shiver City (Middle)/Shiver Mountain Entrance/Shiver Mountain Path/Duplighost Switch/Pebble"]                    = {0x109C},
    ["@Shiver City (Middle)/Shiver Mountain Entrance/Shiver Mountain Path/Duplighost Switch/Pedestals/Pedestal Items"]  = {0x109D, 0x109E, 0x109F},
}
