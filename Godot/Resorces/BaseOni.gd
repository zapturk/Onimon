class_name BaseOni
extends Resource

@export var Name: String
@export var BackSprite: Texture2D
@export var FrontSprite: Texture2D

# Base Stats
@export var Level: int = 1
@export var HPBase: int
@export var ATTBase: int
@export var DEFBase: int
@export var MATTBase: int
@export var MDEFBase: int
@export var SPDBase: int

# Indivual stats
var HPIV: int = 0
var ATTIV: int = 0
var DEFIV: int = 0
var MATTIV: int = 0
var MDEFIV: int = 0
var SPDIV: int = 0

# true stats
var HPStat: int = 0
var ATTStat: int = 0
var DEFStat: int = 0
var MATTStat: int = 0
var MDEFStat: int = 0
var SPDStat: int = 0


func _setup_local_to_scene():
	# set the IV
	HPIV = randi_range(0, 31)
	ATTIV = randi_range(0, 31)
	DEFIV = randi_range(0, 31)
	MATTIV = randi_range(0, 31)
	MDEFIV = randi_range(0, 31)
	SPDIV = randi_range(0, 31)
	
	RecalStats()
	
func RecalStats():
	HPStat = ((((2 * HPBase) + HPIV) * Level) / 100) + Level + 10
	ATTStat = StatCal(ATTBase, ATTIV)
	DEFStat = StatCal(DEFBase, DEFIV)
	MATTStat = StatCal(MATTBase, MATTIV)
	MDEFStat = StatCal(MDEFBase, MDEFIV)
	SPDStat = StatCal(SPDBase, SPDIV)

func StatCal(base, iv):
	return ((((2 * base) + iv) * Level) / 100) + 5

