extends Node

var current_scene = null

func restart():
	var root = get_node("/root/game/")
	root.get_child(0).queue_free()
	root.add_child(current_scene)

func _input(event):
	if event.is_action_pressed("ui_up"):
		print("restart")
		restart()
		
	
	
	
	
	
	