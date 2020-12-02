extends Node

func instance_scene_on_main(scene, position, parent=null):
	var main = get_tree().current_scene
	var instance = scene.instance()
	main.add_child(instance)
	instance.global_position = position
	if parent:
		return [instance, parent]
	return instance
