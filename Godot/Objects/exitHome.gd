extends Area2D

@export_file var nextScenePath: String = ""
@onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("player_entered_door_signal", enteredDoor)
	

func enteredDoor():
	get_node(NodePath("/root/SceneManager")).transitionToScreen(nextScenePath)
