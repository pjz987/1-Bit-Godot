extends Node2D

var ExplostionEffect = preload("res://Effects/ExplosionEffect.tscn")
var EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

func instance_effect():
	var rand_x = rand_range(-12, 12)
	var rand_y = rand_range(-12, 12)
	Utils.instance_scene_on_main(ExplostionEffect, global_position + Vector2(rand_x, rand_y))
	yield(get_tree().create_timer(0.5), "timeout")
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position + Vector2(rand_x, rand_y))
