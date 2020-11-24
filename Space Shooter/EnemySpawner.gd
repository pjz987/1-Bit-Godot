extends Node2D

const Enemy = preload("res://Enemy.tscn")

onready var spawnPoints = $SpawnPoints
onready var timer = $Timer

func get_spawn_position():
#	return spawnPoints.get_children().shuffle()[0].global_position # my one-liner !broken
	var points = spawnPoints.get_children() # Ben's more readable version
	points.shuffle()
	return points[0].global_position

func spawn_enemy():
	var spawn_position = get_spawn_position()
	var enemy = Enemy.instance()
	var main = get_tree().current_scene
	main.add_child(enemy)
	enemy.global_position = spawn_position


func _on_Timer_timeout():
	spawn_enemy()
	timer.wait_time *= 0.95
