extends Node

onready var animationPlayer: = $AnimationPlayer # inferred strict typing
#onready var animationPlayer: AnimationPlayer = $AnimationPlayer # strict typing

func _ready():
	animationPlayer.play("Launch")
