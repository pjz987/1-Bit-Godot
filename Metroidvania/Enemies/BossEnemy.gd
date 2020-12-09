extends "res://Enemies/Enemy.gd"

var MainInstances = ResourceLoader.MainInstances
const Bullet = preload("res://Enemies/EnemyBullet.tscn")
const BossDeathEffect = preload("res://Effects/BossDeathEffect.tscn")
const BigExplosionEffect = preload("res://Effects/BigExplosionEffect.tscn")

export (int) var ACCELERATION = 70
export (float) var DECELERATION = 0.05
export (int) var DIVE_ACCELERATION = 200
export (bool) var shoot_mode = false

onready var hurtboxCollider = $Hurtbox/Collider
onready var powerUpSpawnPoint = $PowerupSpawnPoint
onready var rightWallCheck = $RightWallCheck
onready var leftWallCheck = $LeftWallCheck
onready var animationPlayer = $AnimationPlayer
onready var dive_points = get_tree().get_nodes_in_group("DivePoints")

enum {
	SHOOT,
	PRE_DIVE,
	DIVE,
	POST_DIVE,
	DIE
}

var state = PRE_DIVE
var dive_points_index = 0
var death_start = true
var death_rotation = 0
var death_fall_direction = 0

signal died

func _ready():
	if shoot_mode:
		state = SHOOT
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
		DIE:
			animationPlayer.play("Fly", -1, 0.5)
			die(delta)

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
	if abs(vector_to_point.x) <= 20 and abs(vector_to_point.y) <= 20:
		motion = lerp(motion, vector_to_point, DECELERATION)
	else:
		motion += direction * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)
	
	global_position += motion * delta
#	move_and_collide(motion, delta)
	if abs(vector_to_point.x) <= 2.5 and abs(vector_to_point.y) <=2.5:
		state = DIVE
		animationPlayer.play("Dive")
		dive_points_index += 1

func dive(delta):
	motion.y += DIVE_ACCELERATION * delta
	var collision = move_and_collide(motion * delta)
	if collision:
		motion.y = 0
		Events.emit_signal("add_screenshake", 0.5, 1)
		SoundFX.play("Explosion", rand_range(0.05, 0.15), 20)
		state = PRE_DIVE
		animationPlayer.play("Fly")

func fire_bullet():
	var bullet = Utils.instance_scene_on_main(Bullet, global_position)
	var velocity = Vector2.DOWN * 50
	velocity = velocity.rotated(deg2rad(rand_range(-30, 30)))
	bullet.velocity = velocity
	return bullet

func die(delta):
	if death_start:
		death_fall_direction = sign(rand_range(-0.5, 0.5))
		death_rotation = death_fall_direction * 2
	motion.x += ACCELERATION * delta * death_fall_direction
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	motion.y += ACCELERATION * delta / 2
	motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)
	print(motion)
	move_and_collide(motion * delta)
#	global_position += motion * delta
	rotation_degrees += death_rotation
		
	

func _on_Timer_timeout():
	match state:
		SHOOT:
			fire_bullet()
		PRE_DIVE:
			fire_bullet()
		DIVE:
			fire_bullet()

func _on_EnemyStats_enemy_died():
	hurtboxCollider.disabled = true
	motion = Vector2.ZERO
	state = DIE
	emit_signal("died")
	SaverAndLoader.custom_data.boss_defeated = true
	Utils.instance_scene_on_node(self, BossDeathEffect, powerUpSpawnPoint.global_position)
	yield(get_tree().create_timer(5), "timeout")
	Utils.instance_scene_on_main(BigExplosionEffect, powerUpSpawnPoint.global_position)
	queue_free()
