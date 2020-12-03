extends "res://CollisionBoxes/Hitbox.gd"

func _on_Timer_timeout():
	queue_free()
