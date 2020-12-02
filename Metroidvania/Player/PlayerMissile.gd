extends "res://Player/Projectile.gd"

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const BrickHitbox = preload("res://CollisionBoxes/BrickHitbox.tscn")

const BRICK_LAYER_BIT = 4

func _ready():
	SoundFX.play("Explosion")

func _on_Hitbox_body_entered(body):
	if body.get_collision_layer_bit(BRICK_LAYER_BIT):
		body.activate_hitbox()
		body.queue_free()
#		body.call_deferred('queue_free')
		Utils.instance_scene_on_main(EnemyDeathEffect, body.global_position + Vector2(8, 8))
		Utils.instance_scene_on_main(BrickHitbox, body.global_position + Vector2(8, 8))
	._on_Hitbox_body_entered(body)

func trigger_activate_hitbox(body):
	body.activate_hitbox()
