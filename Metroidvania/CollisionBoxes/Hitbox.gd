extends Area2D

export(int) var damage = 1

onready var collider = $Collider

func _on_Hitbox_area_entered(hurtbox):
	hurtbox.emit_signal("hit", damage)


func _on_Timer_timeout():
	queue_free()
