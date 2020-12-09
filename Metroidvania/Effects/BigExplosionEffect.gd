extends "res://Effects/ExplosionEffect.gd"

func _ready():
	sprite.flip_h = randf() < 0.5
	sprite.flip_v = randf() < 0.5
	SoundFX.play("Explosion", rand_range(0.2, 0.3), 20)
	Events.emit_signal("add_screenshake", 0.35, 1.5)
