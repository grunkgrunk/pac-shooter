extends Node

var item_index = 0

func cycle(amount):
#	item_index += amount
	var count = get_child_count()
	item_index = max(min(count-1, item_index+amount), 0)
	var item = get_child(item_index).duplicate()
	item.position = Vector2()
	return item
	