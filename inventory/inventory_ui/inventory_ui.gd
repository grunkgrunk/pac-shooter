extends Control

export(PackedScene) var items_scene
onready var display_items = items_scene.instance()

func _ready():
	get_node("popup").popup()
	
	var items = get_node("popup/hsplit/items")

	for item in display_items.get_children():
		#var button = TextureButton.new()
#		button.connect("item_selected", self, "_on_item_selected")
		items.add_item(item.item_name, item.get_node("sprite").texture)
		
		# items_grid.add_child(button)

func _on_button_pressed():
	get_node("popup").hide()

func _on_item_selected(item):
	print(item)
