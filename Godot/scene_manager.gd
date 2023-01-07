extends Node2D

var nextScene:String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScreenTransition/AnimationPlayer.play("FadeToNormal")


func transitionToScreen(newScene: String):
	nextScene = newScene
	$ScreenTransition/AnimationPlayer.play("FadeToWhite")
	
func finishedFading():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(load(nextScene).instantiate())
	$ScreenTransition/AnimationPlayer.play("FadeToNormal")
