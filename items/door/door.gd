extends "../base_item.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(bool) var is_open = false
export(PackedScene) var to_room
export(String) var spawn_path

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func interacted():
	if is_open:

		var root = get_node("../..")
		var current_room = get_node("../") 
		
		var player = current_room.get_node("player").duplicate()
		
		root.remove_child(current_room)
		current_room.call_deferred("free")
		
		var room = to_room.instance()
		root.add_child(room)
		
		room.add_child(player)
		player.position = room.get_node(spawn_path).position
		player.get_node("speech/engine").reset()
		player.get_node("speech").hide()
		player.get_node("menu").hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
