extends "res://Enemies/Enemy.gd"

var MainInstances = ResourceLoader.MainInstances
const Bullet = preload("res://Enemies/EnemyBullet.tscn")

export (int) var ACCELERATION = 70
export (float) var DECELERATION = 0.05
export (int) var DIVE_ACCELERATION = 200

onready var rightWallCheck = $RightWallCheck
onready var leftWallCheck = $LeftWallCheck
onready var dive_points = get_tree().get_nodes_in_group("DivePoints")

enum {
	SHOOT,
	PRE_DIVE,
	DIVE,
	POST_DIVE
}

var state = PRE_DIVE
var dive_points_index = 0

signal died

func _ready():
	if SaverAndLoader.custom_data.boss_defeated:
		queue_free()

func _process(delta):
	match state:
		SHOOT:
			chase_player(delta)
		DIVE:
			dive(delta)
		PRE_DIVE:
			pre_dive(delta)

func chase_player(delta):
	var player = MainInstances.Player
	if player != null:
		var direction_to_move = sign(player.global_position.x - global_position.x)
		motion.x += ACCELERATION * delta * direction_to_move
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		global_position.x += motion.x * delta
		rotation_degrees = lerp(rotation_degrees, (motion.x / MAX_SPEED) * 10, 0.3)
		
		if (rightWallCheck.is_colliding() and motion.x > 0) or (leftWallCheck.is_colliding() and motion.x):
			motion.x *= -0.5

func pre_dive(delta):
	var dive_point = dive_points[dive_points_index]
	var vector_to_point = dive_point.global_position - global_position
	var direction = vector_to_point.normalized()
	print('vector_to_point: ', vector_to_point)
	print('direction: ', direction)
	if abs(vector_to_point.x) <= 20 and abs(vector_to_point.y) <= 20:
		motion = lerp(motion, vector_to_point, DECELERATION)
	else:
		motion += direction * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)
	
	global_position += motion * delta
	if abs(vector_to_point.x) <= 2.5 and abs(vector_to_point.y) <=2.5:
		state = DIVE
		dive_points_index += 1

func dive(delta):
	print('motion.x', motion.x, 'motion.y', motion.y)
	motion.y += DIVE_ACCELERATION * delta
	var collision = move_and_collide(motion * delta)
	if collision:
		state = PRE_DIVE

func fire_bullet() -> void:
	var bullet = Utils.instance_scene_on_main(Bullet, global_position)
	var velocity = Vector2.DOWN * 50
	velocity = velocity.rotated(deg2rad(rand_range(-30, 30)))
	bullet.velocity = velocity

func _on_Timer_timeout():
	match state:
		SHOOT:
			fire_bullet()

func _on_EnemyStats_enemy_died():
	emit_signal("died")
	SaverAndLoader.custom_data.boss_defeated = true
	._on_EnemyStats_enemy_died()
