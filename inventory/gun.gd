extends "./item.gd"

var from = null 
var to = null

onready var timer = $Timer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timeout")

func _draw():
	if from != null and to != null:
		print("draw")
		draw_line(Vector2(0,0), to - global_position, Color(255, 0, 0), 1)
		
func use(clicked_position, body):
	timer.start()
	from = global_position
	to = clicked_position
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(global_position, clicked_position, [get_node("../.."),get_node("../../menu/Area2D")])
	update()


func _on_timeout():
	from = null
	update()
