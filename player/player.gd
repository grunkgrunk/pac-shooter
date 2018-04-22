extends KinematicBody2D

enum ACTION {look, interact, use_item, move, pick_up}
enum STATE {idle, moving, browsing, combining}



var state = idle
#onready var items = items_scene.instance()


onready var inventory = preload("res://inventory/inventory.tscn").instance()

onready var all_items = preload("res://items/items.tscn").instance()

onready var target_position = position
onready var speech = $speech


var equipped = null
var combine_item = null

func _ready():
	speech.hide()
	$menu.connect("item_selected", self, "_on_menu_item_selected")
	equip_item(inventory.selected())

func equip_item(item):
	if $equipped.get_child(0):
		$equipped.get_child(0).queue_free()
	$equipped.add_child(item)
	equipped = item
	
	
func equip_hand(hand, item):
	if hand.get_child(0):
		hand.get_child(0).queue_free()
	hand.add_child(item)

func _process(delta):
	var dist = position.distance_to(target_position)
	if dist > 5:
		var dir = (target_position - position).normalized()
		var collision = move_and_collide(dir * 200 * delta)
		
		if collision != null:
			target_position = position
		
		$cross/sprite.show()
	elif state == STATE.moving:
		position = target_position
		state = STATE.idle
		$cross/sprite.hide()
		
		

func _on_menu_item_selected(index, clicked_position, area):
	# emit signals and do things based on those
	
	speech.show()
	match index:
		ACTION.look:
			if(area != null):
				if area.look != null:
					speech.say(area.look)
				else:
					speech.say("Wow. That is truly a " + area.item_name)
			else:
				speech.say("There is nothing of interest there..")
			
		ACTION.interact:
			# fix this
			if(area != null):
				if area.interact != null:
					speech.say(area.interact)
				else:
					speech.say("I interacted with " + area.item_name + " but nothing happened.")
			else:
				speech.say("There is nothing of interest there..")
			
		ACTION.use_item:
			var success = equipped.use(clicked_position, area)
			if success:
				speech.say(equipped.use_item_success)
				return
			
			if area != null:
				if equipped.use_item_failure != null:
					speech.say(equipped.use_item_failure % area.item_name)
				else:
					speech.say("Damn I wish I could use %s on %s" % [equipped.item_name, area.item_name]) 
			else:
				speech.say("I cannot use %s like that" % equipped.item_name) 
			#speech.say(equipped.use_item)
			
		ACTION.move:
			speech.hide()
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
			
			if not area.get_overlapping_areas().has($interact):
				return
			
			var item = area.duplicate()
			inventory.add_child(item)
			speech.say(item.pick_up)
			area.queue_free()
				
func _input(event):
#	for a in ["inventory", "ui_left", "ui_right", "combine"]:
#		if event.is_action_pressed(a) and state != idle:
#			
		
	match state:
		idle:
			if event.is_action_pressed("inventory"):
				state = browsing
				combine_item = null
				speech.combine_or_select([equipped, combine_item])
		browsing:
			if event.is_action_pressed("inventory") and combine_item == null:
				state = idle
				equip_item(inventory.selected())
				speech.equip(equipped.item_name)
			elif event.is_action_pressed("ui_left"):
				# should show this with an animation
				inventory.cycle(-1)
				equip_item(inventory.selected())
				
				
				speech.combine_or_select([equipped, combine_item])
				
			if event.is_action_pressed("ui_right"):
				inventory.cycle(1)
				equip_item(inventory.selected())
				speech.combine_or_select([equipped, combine_item])
				
			elif event.is_action_pressed("combine"):
				if combine_item == null:
					state = browsing
					combine_item = inventory.selected()
					speech.combine_or_select([equipped, combine_item])
				else:
					var items = [equipped.short_name, combine_item.short_name]
					if items.has("empty_gun") and items.has("magazine"):
						inventory.get_node(equipped.name).free()
						inventory.get_node(combine_item.name).free()
						equipped.free()
						combine_item.free()
						var item = all_items.get_node("gun").duplicate()
						inventory.add_child(item)
						inventory.item_index = inventory.get_child_count() - 1
						equip_item(inventory.selected())
						speech.reload()
						
					else:
						speech.say("Combining %s and %s is very creaitve, but not helpful!" %[equipped.item_name,combine_item.item_name])
					state = idle
	
