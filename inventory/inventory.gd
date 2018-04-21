extends Node2D

var item_index = 0

func cycle(amount):
	item_index += amount
	var count = get_child_count()
	if item_index < 0:
		item_index = count - 1
	if item_index > count - 1:
		item_index = 0

func selected():
	var item = get_child(item_index).duplicate()
	item.position = Vector2()
	return item