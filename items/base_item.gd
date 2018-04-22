extends Area2D

export(String) var item_name
export(String) var info
export(String) var look
export(String) var pick_up
export(String) var interact

export(String) var use_item_success
export(String) var use_item_failure


var short_name

func _ready():
	pass
	
func use(clicked_position, body):
	return false

func cant_use():
	print("You cannot use %s for this" % name)
	
#func set_item_name(x):
#	if Editor.is_editor_hint():
#		print("set name to "+x)
#		item_name = x
#
#func set_info(x):
#	if Editor.is_editor_hint():
#		info = x

