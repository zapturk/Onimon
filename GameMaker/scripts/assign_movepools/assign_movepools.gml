function assign_movepools(){

//Assign monsters movepools based on the created moves in the init script.
//Highly recommend split screening this script with your init script when building movepools manually (for those that don't wish to use the visual editor)
//Example: https://discord.com/channels/1012975690561368075/1051305642775810058/1069752399822065695


BUILD_MONSTER_MOVEPOOL(m.STARTER_1,	moves.LIGHT_1, 1, moves.FIRE_1, 5, moves.LIGHT_6, 9);
BUILD_MONSTER_MOVEPOOL(m.STARTER_4,	moves.LIGHT_1, 1, moves.GRASS_1, 5, moves.LIGHT_6, 9);
BUILD_MONSTER_MOVEPOOL(m.STARTER_7,	moves.LIGHT_1, 1, moves.WATER_1, 5, moves.LIGHT_6, 9);

BUILD_MONSTER_MOVEPOOL(m.MONSTER_10,	moves.LIGHT_1, 1, moves.GRASS_1, 6, moves.LIGHT_6, 9);
BUILD_MONSTER_MOVEPOOL(m.MONSTER_17,	moves.LIGHT_5, 1, moves.LIGHT_6, 4, moves.FLYING_1, 9);
BUILD_MONSTER_MOVEPOOL(m.MONSTER_13,	moves.LIGHT_5, 1, moves.LIGHT_6, 4, moves.FAIRY_1, 8);
BUILD_MONSTER_MOVEPOOL(m.MONSTER_19,	moves.LIGHT_8, 1, moves.DARK_1, 5, moves.LIGHT_3, 8);

}