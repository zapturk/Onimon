extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var playerNode = get_node("../../../Player")
@onready var topGrass = $TopGrass
var playerInside: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode.connect("player_moving_signal", playerExitingGrass)
	playerNode.connect("player_stopped_signal", playerInGrass)
	topGrass.visible = false

func playerExitingGrass():
	playerInside = false
	topGrass.visible = false
	
func playerInGrass():
	if playerInside == true:
		topGrass.visible = true
		if randi_range(1, 10) == 1:
			#get_tree().change_scene_to_file("res://Scenes/battle.tscn")
			pass

func _on_area_2d_body_entered(body):
	playerInside = true
	animPlayer.play("Stepped")
