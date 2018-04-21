extends PopupMenu

onready var area = $Area2D

signal item_selected

var target = null
var check_interact = false

var clicked_position = Vector2()

func _input(event):
	if event.is_action_pressed("click_right") and get_node("../").state == 0:
		clicked_position = event.position
		rect_position = clicked_position
		popup()

func _on_menu_index_pressed(index):
	check_interact = true
	var bodies = area.get_overlapping_bodies()
	bodies.append(null)
	emit_signal("item_selected", index, clicked_position, bodies[0])