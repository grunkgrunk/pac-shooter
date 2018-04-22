extends "../base_item.gd"

var from = null 
var to = null

onready var timer = $timer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timeout")

func use(clicked_position, target):
	print(clicked_position)
	if target.is_in_group("enemy"):
		target.get_node("../").kill()
		return true
	elif target.is_in_group("barrel"):
		target.explode()
		return true
#func _draw():
#	if from != null and to != null:
#		draw_line(Vector2(0,0), to, Color(255, 0, 0), 1)
#
#func use(clicked_position, body):
#	timer.start()
#	from = global_position
#	to = (clicked_position - from).normalized() * 20000
#	var space_state = get_world_2d().direct_space_state
#	# use global coordinates, not local to node
#	var result = space_state.intersect_ray(global_position, to, [get_node("../.."),get_node("../../menu/Area2D")])
#	print(result)
#	if result != null:
#		to = result["position"] - global_position
#		if result["collider"].is_in_group("Enemy"):
#			result["collider"].queue_free()
#
#	update()
#	return true
#
#func _on_timeout():
#	from = null
#	update()
