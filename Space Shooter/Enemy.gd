extends Area2D

const ExplosionEffect = preload("res://ExplosionEffect.tscn")

export(int) var SPEED = 20
export(int) var ARMOR = 3

signal score_up
var rng = RandomNumberGenerator.new()
var up


func _ready():
	rng.randomize()
	up = 0.5 > rng.randf()

func _process(delta):
	if position.y <= 10 or position.y >= 170:
		up = !up
	
	position.x -= SPEED * delta
	if up:
		position.y -= SPEED * delta / 2
	else:
		position.y += SPEED * delta / 2

func _on_Enemy_body_entered(body):
	body.queue_free()
	body.create_hit_effect()
	ARMOR -= 1
	if !ARMOR:
		add_to_score()
		create_explosion()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func add_to_score():
	var main = get_tree().current_scene
	if main.is_in_group("World"):
		main.score += 10
	
func create_explosion():
	var main = get_tree().current_scene
	var explosionEffect = ExplosionEffect.instance()
	main.add_child(explosionEffect)
	explosionEffect.global_position = global_position
