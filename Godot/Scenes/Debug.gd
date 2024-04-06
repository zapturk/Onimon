extends Node2D

@onready var oni: BaseOni = load("res://OniDb/Vamporm.tres").duplicate()
@onready var oni2: BaseOni = load("res://OniDb/Vamporm.tres").duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	oni.setup_local_to_scene()
	oni2.setup_local_to_scene()
	
	print("Oni 1 Level: " + str(oni.Level))
	print("Oni 1 HPIV: " + str(oni.HPIV))
	print("Oni 1 ATTIV: " + str(oni.ATTIV))
	print("Oni 1 DEFIV: " + str(oni.DEFIV))
	print("Oni 1 MATTIV: " + str(oni.MATTIV))
	print("Oni 1 MDEFIV: " + str(oni.MDEFIV))
	print("Oni 1 SPDIV: " + str(oni.SPDIV))
	
	print("")
	
	print("Oni 1 HP: " + str(oni.HPStat))
	print("Oni 1 ATT: " + str(oni.ATTStat))
	print("Oni 1 DEF: " + str(oni.DEFStat))
	print("Oni 1 MATT: " + str(oni.MATTStat))
	print("Oni 1 MDEF: " + str(oni.MDEFStat))
	print("Oni 1 SPD: " + str(oni.SPDStat))
	
	print("")
	
	print("Oni 2 Level: " + str(oni2.Level))
	print("Oni 2 HPIV: " + str(oni2.HPIV))
	print("Oni 2 ATTIV: " + str(oni2.ATTIV))
	print("Oni 2 DEFIV: " + str(oni2.DEFIV))
	print("Oni 2 MATTIV: " + str(oni2.MATTIV))
	print("Oni 2 MDEFIV: " + str(oni2.MDEFIV))
	print("Oni 2 SPDIV: " + str(oni2.SPDIV))
	
	print("")
	
	print("Oni 2 HP: " + str(oni2.HPStat))
	print("Oni 2 ATT: " + str(oni2.ATTStat))
	print("Oni 2 DEF: " + str(oni2.DEFStat))
	print("Oni 2 MATT: " + str(oni2.MATTStat))
	print("Oni 2 MDEF: " + str(oni2.MDEFStat))
	print("Oni 2 SPD: " + str(oni2.SPDStat))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
