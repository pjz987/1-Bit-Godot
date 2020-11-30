extends StaticBody2D

var PlayerStats = ResourceLoader.PlayerStats

onready var animationPlayer = $AnimationPlayer

func _on_SaveArea_body_entered(_body):
#	PlayerStats.health = PlayerStats.max_health
	animationPlayer.play("Save")
	SaverAndLoader.save_game()
	PlayerStats.refill_stats()
