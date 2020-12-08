extends Powerup

func _ready():
	pass

func _pickup():
	._pickup()
	PlayerStats.health += 1
	queue_free()
