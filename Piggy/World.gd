extends Node

var Apple = load("res://Apple.tscn")
var rng = RandomNumberGenerator.new()

# dimensions: x: 320, y: 180
func _ready():
	rng.randomize()
#	var apple = Apple.instance()
#	apple.position.x = rng.randi_range(5, 315)
#	apple.position.y = rng.randi_range(6, 174)
#	add_child(apple)


func _on_Timer_timeout():
	var apple = Apple.instance()
	apple.position.x = rng.randi_range(5, 315)
	apple.position.y = rng.randi_range(6, 174)
	add_child(apple)
