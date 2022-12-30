extends CharacterBody2D

signal player_moving_signal
signal player_stopped_signal

signal player_entering_door_signal
signal player_entered_door_signal


@export var walkSpeed = 4
@export var jumpSpeed = 4
const TILE_SIZE = 16

@onready var animTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")
@onready var ray = $BlockingRayCast2D
@onready var ledgeRay = $LedgeRayCast2D2
@onready var doorRay = $DoorRayCast2D
var jumpingOverLedgeDown: bool = false
var jumpingOverLedgeRight: bool = false

enum PlayerStates {
	IDLE,
	TURNING,
	WALKING
}

enum FacingDirections {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

var playerState = PlayerStates.IDLE
var facingDir = FacingDirections.DOWN

var initialPosition = Vector2(0,0)
var inputDir = Vector2(0,0)
var isMoving = false
var stopInput: bool = false
var percentMovedToNextTile = 0.0

func _ready():
	$Sprite2D.visible = true
	animTree.active = true
	initialPosition = position

func _physics_process(delta):
	if playerState == PlayerStates.TURNING or stopInput:
		return
	elif isMoving == false:
		ProcessPlayerInput()
	elif inputDir != Vector2.ZERO:
		animState.travel("Walk")
		Move(delta)
	else:
		animState.travel("Idle")
		isMoving = false

func  ProcessPlayerInput():
	# figure out what direction the player wants to go
	if inputDir.y == 0:
		inputDir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if inputDir.x == 0:
		inputDir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if inputDir != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", inputDir)
		animTree.set("parameters/Walk/blend_position", inputDir)
		animTree.set("parameters/Turn/blend_position", inputDir)
		
		#check if we need turn
		if NeedToTurn():
			playerState = PlayerStates.TURNING
			animState.travel("Turn")
		else:
			initialPosition = position
			isMoving = true
	else:
		animState.travel("Idle")

func NeedToTurn():
	var newFacingDir
	
	if inputDir.x < 0:
		newFacingDir = FacingDirections.LEFT
	elif inputDir.x > 0:
		newFacingDir = FacingDirections.RIGHT
	if inputDir.y < 0:
		newFacingDir = FacingDirections.UP
	if inputDir.y > 0:
		newFacingDir = FacingDirections.DOWN
	
	if facingDir != newFacingDir:
		facingDir = newFacingDir
		return true
	facingDir = newFacingDir
	return false

func FinishedTurning():
	playerState = PlayerStates.IDLE
	
func EnteredDoor():
	emit_signal("player_entered_door_signal")

# moves the player keeping them on the grid
func Move(delta):
	#check the next tile for colition
	var desiredStep: Vector2 = inputDir * TILE_SIZE / 2
	ray.target_position = desiredStep
	ray.force_raycast_update()
	
	ledgeRay.target_position = desiredStep
	ledgeRay.force_raycast_update()
	
	doorRay.target_position = desiredStep
	doorRay.force_raycast_update()
	
	#Walking into a door
	if doorRay.is_colliding():
		if percentMovedToNextTile == 0.0:
			emit_signal("player_entering_door_signal")
		percentMovedToNextTile += walkSpeed * delta
		if percentMovedToNextTile >= 1.0:
			position = initialPosition + (TILE_SIZE * inputDir)
			percentMovedToNextTile = 0.0
			isMoving = false
			stopInput = true
			$AnimationPlayer.play("Disappear")
			$Camera2D.clear_current()
		else:
			position = initialPosition + (TILE_SIZE * inputDir * percentMovedToNextTile)
	#Jumping over ledge
	elif (ledgeRay.is_colliding() && inputDir == Vector2(0, 1)) or jumpingOverLedgeDown:
		percentMovedToNextTile += jumpSpeed * delta
		if percentMovedToNextTile >= 2.0:
			position = initialPosition + (TILE_SIZE * inputDir * 2)
			percentMovedToNextTile = 0.0
			isMoving = false
			jumpingOverLedgeDown = false
		else:
			jumpingOverLedgeDown = true
			var input = inputDir.y * TILE_SIZE * percentMovedToNextTile
			position.y = initialPosition.y + (-0.96 - 0.53 * input + 0.05 * pow(input, 2))
	#move the player if the ray cast is not moving
	elif !ray.is_colliding(): 
		if percentMovedToNextTile == 0:
			emit_signal("player_moving_signal")
		percentMovedToNextTile += walkSpeed * delta
		if percentMovedToNextTile >= 1.0:
			position = initialPosition + (TILE_SIZE * inputDir)
			emit_signal("player_stopped_signal")
			percentMovedToNextTile = 0.0
			isMoving = false
		else:
			position = initialPosition + (TILE_SIZE * inputDir * percentMovedToNextTile)
	else:
		emit_signal("player_stopped_signal")
		percentMovedToNextTile = 0.0
		isMoving = false
