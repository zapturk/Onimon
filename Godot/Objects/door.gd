extends Area2D

@export_file var nextScenePath: String = ""
@onready var player = get_parent().get_parent().get_node("Player")

@export var spawnLocation: Vector2 = Vector2(0, 0)
@export var spawnDirection: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null:
		player = get_parent().get_node("Player")
	player.connect("player_entered_door_signal", enteredDoor)
	

func enteredDoor():
	get_node(NodePath("/root/SceneManager")).transitionToScreen(nextScenePath, spawnLocation, spawnDirection)
