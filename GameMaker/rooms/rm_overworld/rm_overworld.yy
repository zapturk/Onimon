{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rm_overworld",
  "isDnd": false,
  "volume": 1.0,
  "parentRoom": null,
  "views": [
    {"inherit":false,"visible":true,"xview":0,"yview":0,"wview":256,"hview":144,"xport":0,"yport":0,"wport":512,"hport":288,"hborder":256,"vborder":144,"hspeed":-1,"vspeed":-1,"objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":320,"hview":160,"xport":0,"yport":0,"wport":320,"hport":160,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
  ],
  "layers": [
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Grass","tilesetId":{"name":"ts_grass","path":"tilesets/ts_grass/ts_grass.yy",},"x":0,"y":0,"tiles":{"TileDataFormat":1,"SerialiseWidth":16,"SerialiseHeight":9,"TileCompressedData":[
-144,-2147483648,],},"visible":false,"depth":0,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Collision","tilesetId":{"name":"ts_collision","path":"tilesets/ts_collision/ts_collision.yy",},"x":0,"y":0,"tiles":{"TileDataFormat":1,"SerialiseWidth":16,"SerialiseHeight":9,"TileCompressedData":[
-144,0,],},"visible":false,"depth":100,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Over_Player","tilesetId":{"name":"ts_crystal","path":"tilesets/ts_crystal/ts_crystal.yy",},"x":0,"y":0,"tiles":{"TileDataFormat":1,"SerialiseWidth":16,"SerialiseHeight":9,"TileCompressedData":[
-144,-2147483648,],},"visible":true,"depth":200,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Instances","instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_1723867B_1_1_2","properties":[],"isDnd":false,"objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":false,"inheritItemSettings":false,"x":112.0,"y":80.0,},
      ],"visible":true,"depth":300,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":16,"gridY":16,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRLayer","resourceVersion":"1.0","name":"Tiles","visible":true,"depth":400,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Above_Floor","tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"x":0,"y":0,"tiles":{"TileDataFormat":1,"SerialiseWidth":16,"SerialiseHeight":9,"TileCompressedData":[
-144,0,],},"visible":true,"depth":500,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Floor","tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"x":0,"y":0,"tiles":{"TileDataFormat":1,"SerialiseWidth":16,"SerialiseHeight":9,"TileCompressedData":[
-144,0,],},"visible":true,"depth":600,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Sub_Floor","tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"x":0,"y":0,"tiles":{"TileDataFormat":1,"SerialiseWidth":16,"SerialiseHeight":9,"TileCompressedData":[
-144,0,],},"visible":true,"depth":700,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
      ],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Background","spriteId":{"name":"spr_water","path":"sprites/spr_water/spr_water.yy",},"colour":4294967295,"x":0,"y":0,"htiled":true,"vtiled":true,"hspeed":0.15,"vspeed":0.15,"stretch":false,"animationFPS":0.0,"animationSpeedType":0,"userdefinedAnimFPS":true,"visible":true,"depth":800,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritVisibility":true,"inheritSubLayers":true,"gridX":16,"gridY":16,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
  ],
  "inheritLayers": false,
  "creationCodeFile": "${project_dir}/rooms/rm_game/RoomCreationCode.gml",
  "inheritCode": false,
  "instanceCreationOrder": [
    {"name":"inst_1723867B_1_1_2","path":"rooms/rm_overworld/rm_overworld.yy",},
  ],
  "inheritCreationOrder": false,
  "sequenceId": null,
  "roomSettings": {
    "inheritRoomSettings": false,
    "Width": 256,
    "Height": 144,
    "persistent": false,
  },
  "viewSettings": {
    "inheritViewSettings": false,
    "enableViews": true,
    "clearViewBackground": true,
    "clearDisplayBuffer": true,
  },
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "parent": {
    "name": "Rooms",
    "path": "folders/Rooms.yy",
  },
}