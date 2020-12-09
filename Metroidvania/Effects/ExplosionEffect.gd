extends Node2D

onready var sprite = $Sprite

func _ready():
	sprite.flip_h = randf() < 0.5
	sprite.flip_v = randf() < 0.5
	SoundFX.play("Explosion", rand_range(0.6, 1))
