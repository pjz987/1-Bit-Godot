extends Node

func instance_scene_on_main(scene, position):
	var main = get_tree().current_scene
	var instance = scene.instance()
	main.add_child(instance)
	instance.global_position = position
	return instance

func instance_scene_on_node(node, scene, position):
	var instance = scene.instance()
	node.add_child(instance)
	instance.global_position = position
	return instance
