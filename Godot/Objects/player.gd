extends CharacterBody2D

@export var walkSpeed = 4
const TILE_SIZE = 16

var initialPostion = Vector2(0,0)
var inputDir = Vector2(0,0)
var isMoving = false
var percentMovedToNextTile = 0.0

func _ready():
	initialPostion = position

func _physics_process(delta):
	if isMoving == false:
		processPlayerInput()
	elif inputDir != Vector2.ZERO:
		move(delta)
	else:
		isMoving = false

func  processPlayerInput():
	# figure out what direction the player wants to go
	if inputDir.y == 0:
		inputDir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if inputDir.x == 0:
		inputDir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if inputDir != Vector2.ZERO:
		initialPostion = position
		isMoving = true

# moves the player keeping them on the grid
func move(delta):
	percentMovedToNextTile += walkSpeed * delta
	if percentMovedToNextTile >= 1.0:
		position = initialPostion + (TILE_SIZE * inputDir)
		percentMovedToNextTile = 0.0
		isMoving = false
	else:
		position = initialPostion + (TILE_SIZE * inputDir * percentMovedToNextTile)
