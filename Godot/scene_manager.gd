extends Node2D

var nextScene = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func transitionToScreen(newScene: String):
	nextScene = newScene
	$ScreenTransition/AnimationPlayer.play("FadeToWhite")
	
func finishedFading():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(load(nextScene).instance())
	$ScreenTransition/AnimationPlayer.play("FadeToNormal")
