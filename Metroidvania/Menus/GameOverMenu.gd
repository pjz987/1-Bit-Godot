extends CenterContainer


func _on_ContinueButton_pressed():
	SoundFX.play("Click", 1, -10)
	SaverAndLoader.is_loading = true
	Music.list_stop()
	get_tree().change_scene("res://World.tscn")

func _on_QuitButton_pressed():
	SoundFX.play("Click", 1, -10)
	Music.list_stop()
	get_tree().change_scene("res://Menus/StartMenu.tscn")
