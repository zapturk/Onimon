extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var playerNode = get_node("../../Player")
const grassOverlayTexter = preload("res://Assets/Objects/GrassStepOn.png")
var grassOverlay: TextureRect = null

var playerInside: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	playerNode.connect("player_moving_signal", playerExitingGrass)
	playerNode.connect("player_stopped_signal", playerInGrass)

func playerExitingGrass():
	playerInside = false
	if is_instance_valid(grassOverlay):
		grassOverlay.queue_free()
	
func playerInGrass():
	if playerInside == true:
		grassOverlay = TextureRect.new()
		grassOverlay.texture = grassOverlayTexter
		grassOverlay.position = position
		grassOverlay.z_index = playerNode.z_index + 1
		get_tree().current_scene.add_child(grassOverlay)

func _on_area_2d_body_entered(body):
	playerInside = true
	animPlayer.play("Stepped")
