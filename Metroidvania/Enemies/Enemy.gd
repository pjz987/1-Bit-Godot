extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const HealthPowerup = preload("res://Player/HealthPowerup.tscn")

onready var powerupSpawnPoint = $PowerupSpawnPoint

export(int) var MAX_SPEED = 15
var motion = Vector2.ZERO

onready var stats = $EnemyStats

func _on_Hurtbox_hit(damage):
	stats.health -= damage


func _on_EnemyStats_enemy_died():
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position)
	if randf() > .9:
		Utils.instance_scene_on_main(HealthPowerup, powerupSpawnPoint.global_position)
	queue_free()
