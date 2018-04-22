extends PopupMenu

onready var area = $Area2D

signal item_selected

var target = null
var check_interact = false

var clicked_position = Vector2()

func _input(event):
	if event.is_action_pressed("click_right") and get_node("../").state == 0:
		clicked_position = event.global_position
		rect_position = clicked_position
		popup()
		get_node("../speech").hide()

func _on_menu_index_pressed(index):
	check_interact = true
	var areas = area.get_overlapping_areas()
	
	var item = null
	for a in areas:
		if a != get_node("../interact"):
			item = a
	emit_signal("item_selected", index,clicked_position, item)