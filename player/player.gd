extends KinematicBody2D

enum ACTION {look, interact, use_item, move, pick_up}
enum STATE {idle, moving, browsing, combining}

var state = idle

export(PackedScene) var inventory_scene
onready var inventory = inventory_scene.instance()
onready var target_position = position

var equipped = null
var combine_item = []

func _ready():
	$menu.connect("item_selected", self, "_on_menu_item_selected")
	equip_item(inventory.selected())

func equip_item(item):
	if $equipped.get_child(0):
		$equipped.get_child(0).queue_free()
	$equipped.add_child(item)
	equipped = item
	
func _process(delta):
	var dist = position.distance_to(target_position)
	if dist > 5:
		var dir = (target_position - position).normalized()
		move_and_collide(dir * 200 * delta)
		$cross/sprite.show()
	elif state == STATE.moving:
		position = target_position
		state = STATE.idle
	
	var item_name = equipped.name
	match state:
		STATE.idle:
			$Label.text = "Press I to open inventory"
		STATE.browsing:
			$Label.text = "Press I to equip %s or C to combine" % item_name
		STATE.combining:
			$Label.text = "Press C again to combine %s with %s" % [item_name, combine_item]
		

func _on_menu_item_selected(index, clicked_position, area):
	# emit signals and do things based on those
	match index:
		ACTION.look:
			print("looking")
		ACTION.interact:
			if area == null:
				print("cant interact")
				return
		ACTION.use_item:
			equipped.use(clicked_position, area)
		ACTION.move:
			state = STATE.moving
			target_position = clicked_position
			$cross/sprite.global_position = target_position
			$cross/sprite.show()
			
		ACTION.pick_up:
			if area == null:
				return
			if not area.is_in_group("item"):
				return
				
			if equipped != null:
				if equipped.name.is_subsequence_of(area.name):
					return
			
			if not area.get_overlapping_bodies().has(self):
				return
			
			var item = area.duplicate()
			inventory.add_child(item)
			area.queue_free()
				
func _input(event):
	match state:
		idle:
			if event.is_action_pressed("inventory"):
				state = browsing
				combine_item = null
		browsing:
			if event.is_action_pressed("inventory") and combine_item == null:
				state = idle
				equip_item(inventory.selected())
			elif event.is_action_pressed("ui_left"):
				# should show this with an animation
				inventory.cycle(-1)
				equip_item(inventory.selected())
			if event.is_action_pressed("ui_right"):
				inventory.cycle(1)
				equip_item(inventory.selected())
			elif event.is_action_pressed("combine"):
				if combine_item == null:
					state = browsing
					combine_item = inventory.selected()
				else:
					var items = [equipped.name, combine_item.name]
					if items.has("gun") and items.has("magazine"):
						print("you have reloaded the gun!")
					else:
						print("what are you trying to achieve?")
					state = idle

		
			
	if event.is_action_pressed("inventory"):
		if state == browsing:
			state = idle
		else:
			state = browsing
	if state == browsing:
		if event.is_action_pressed("ui_left"):
			inventory.cycle(-1)
		if event.is_action_pressed("ui_right"):
			inventory.cycle(1)
	
		if event.is_action_pressed("combine"):
			combine_item = $equipped.get_child(0)
			state = combining
	
	if state == combining:
		if event.is_action_pressed("ui_left"):
			equip_item(inventory.cycle(-1))
		if event.is_action_pressed("ui_right"):
			equip_item(inventory.cycle(1))
		
		if event.is_action_pressed("combine"):
			var items = [equipped.name, combine_item.name]
			
			if items.has("gun") and items.has("magazine"):
				print("you have reloaded the gun!")
			else:
				print("what are you trying to achieve?")
			
			
			
		
