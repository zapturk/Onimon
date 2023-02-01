{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rm_room",
  "creationCodeFile": "${project_dir}/rooms/rm_game/RoomCreationCode.gml",
  "inheritCode": false,
  "inheritCreationOrder": false,
  "inheritLayers": false,
  "instanceCreationOrder": [
    {"name":"inst_1723867B_1_1","path":"rooms/rm_room/rm_room.yy",},
  ],
  "isDnd": false,
  "layers": [
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Grass","depth":0,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":9,"SerialiseWidth":16,"TileCompressedData":[
-144,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_grass","path":"tilesets/ts_grass/ts_grass.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Collision","depth":100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":9,"SerialiseWidth":16,"TileCompressedData":[
-144,0,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collision","path":"tilesets/ts_collision/ts_collision.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Over_Player","depth":200,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":9,"SerialiseWidth":16,"TileCompressedData":[
-144,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Instances","depth":300,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_1723867B_1_1","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":112.0,"y":80.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRLayer","resourceVersion":"1.0","name":"Tiles","depth":400,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Above_Floor","depth":500,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":9,"SerialiseWidth":16,"TileCompressedData":[
-144,0,],"TileDataFormat":1,},"tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Floor","depth":600,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":9,"SerialiseWidth":16,"TileCompressedData":[
-144,0,],"TileDataFormat":1,},"tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"Sub_Floor","depth":700,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":9,"SerialiseWidth":16,"TileCompressedData":[
-144,0,],"TileDataFormat":1,},"tilesetId":{"name":"ts_external","path":"tilesets/ts_external/ts_external.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
      ],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Background","animationFPS":0.0,"animationSpeedType":0,"colour":4294967295,"depth":800,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"hspeed":0.15,"htiled":true,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"spriteId":{"name":"spr_ocean","path":"sprites/spr_ocean/spr_ocean.yy",},"stretch":false,"userdefinedAnimFPS":true,"userdefinedDepth":false,"visible":true,"vspeed":0.15,"vtiled":true,"x":0,"y":0,},
  ],
  "parent": {
    "name": "Duplicate Me",
    "path": "folders/Rooms/Duplicate Me.yy",
  },
  "parentRoom": null,
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "roomSettings": {
    "Height": 144,
    "inheritRoomSettings": false,
    "persistent": false,
    "Width": 256,
  },
  "sequenceId": null,
  "views": [
    {"hborder":256,"hport":288,"hspeed":-1,"hview":144,"inherit":false,"objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"vborder":144,"visible":true,"vspeed":-1,"wport":512,"wview":256,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":160,"hspeed":-1,"hview":160,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":320,"wview":320,"xport":0,"xview":0,"yport":0,"yview":0,},
  ],
  "viewSettings": {
    "clearDisplayBuffer": true,
    "clearViewBackground": true,
    "enableViews": true,
    "inheritViewSettings": false,
  },
  "volume": 1.0,
}