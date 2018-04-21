extends KinematicBody2D

enum {look, interact, use_item, move}
enum {idle, moving, browsing}

var state = idle

export(PackedScene) var inventory_scene
onready var inventory = inventory_scene.instance()

onready var target_position = position


func _ready():
	$menu.connect("item_selected", self, "_on_menu_item_selected")
	equip_item(inventory.cycle(0))

func equip_item(item):
	if $equipped.get_child(0):
		$equipped.get_child(0).queue_free()
	$equipped.add_child(item)
	
	

func _process(delta):
	var dist = position.distance_to(target_position)
	if dist > 1:
		var dir = (target_position - position).normalized()
		move_and_collide(dir * 200 * delta)
	elif state == moving:
		state = idle
		

func _on_menu_item_selected(index, clicked_position, body):
	match index:
		look:
			print("looking")
		interact:
			if body == null:
				print("cant interact")
				return
		use_item:
			$equipped.get_child(0).use(clicked_position, body)
		move:
			state = moving
			target_position = clicked_position
			
func _input(event):
	if event.is_action_pressed("inventory"):
		if (state == browsing):
			state = idle
		else:
			state = browsing
	if state == browsing:
		if event.is_action_pressed("ui_left"):
			equip_item(inventory.cycle(-1))
		if event.is_action_pressed("ui_right"):
			equip_item(inventory.cycle(1))
			
		
