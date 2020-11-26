extends Node2D

var velocity = Vector2.ZERO

func _process(delta):
	position += velocity * delta
	


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
