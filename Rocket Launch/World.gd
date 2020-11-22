extends Node

onready var animationPlayer: = $AnimationPlayer # inferred strict typing
#onready var animationPlayer: AnimationPlayer = $AnimationPlayer # strict typing

func _on_LaunchButton_pressed():
	animationPlayer.play("Launch")
