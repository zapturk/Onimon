extends Node2D

var nextScene:String = ""
var playerLocation: Vector2 = Vector2(0, 0)
var playerDirection: Vector2 = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScreenTransition/AnimationPlayer.play("FadeToNormal")


func transitionToScreen(newScene: String, spawnLocation: Vector2, spawnDirection: Vector2):
	nextScene = newScene
	playerLocation = spawnLocation
	playerDirection = spawnDirection
	$ScreenTransition/AnimationPlayer.play("FadeToWhite")
	
func finishedFading():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(load(nextScene).instantiate())
	
	var player = $CurrentScene.get_children().back().get_node("Player")
	player.setSpawn(playerLocation, playerDirection)
	
	$ScreenTransition/AnimationPlayer.play("FadeToNormal")
