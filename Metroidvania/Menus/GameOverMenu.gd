extends CenterContainer


func _on_ContinueButton_pressed():
	SoundFX.play("Clilck", 1, -10)
	SaverAndLoader.is_loading = true
	Music.list_stop()
	SaverAndLoader.load_game()


func _on_QuitButton_pressed():
	get_tree().change_scene("res://Menus/StartMenu.tscn")
