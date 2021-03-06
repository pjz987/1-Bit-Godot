extends ColorRect

var paused = false setget set_paused

func set_paused(value):
	paused = value
	get_tree().paused = paused
	visible = paused
	if paused:
		SoundFX.play("Pause")
	else:
		SoundFX.play("Unpause")

func _process(_delta):
	var player_is_alive = get_tree().get_nodes_in_group("Player").size() > 0
	if Input.is_action_just_pressed("pause") and player_is_alive:
		self.paused = !paused

func _on_ResumeButton_pressed():
	SoundFX.play("Click", 1, -10)
	self.paused = false

func _on_QuitButton_pressed():
	get_tree().quit()
