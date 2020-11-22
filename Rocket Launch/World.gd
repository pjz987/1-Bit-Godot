extends Node

onready var animationPlayer: = $AnimationPlayer # inferred strict typing
#onready var animationPlayer: AnimationPlayer = $AnimationPlayer # strict typing

#$RocketShipLaunch.visible = false

func _on_LaunchButton_pressed():
	animationPlayer.play("Launch")
	$RocketShip.visible = false
	$RocketShipLaunch.visible = true
	
