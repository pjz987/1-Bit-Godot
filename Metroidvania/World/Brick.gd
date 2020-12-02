extends StaticBody2D

onready var hitbox = $Hitbox

func activate_hitbox():
	call_deferred("activate_hitbox_deferred")

func activate_hitbox_deferred():
	hitbox.collider.disabled = false
