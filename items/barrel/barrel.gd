extends "../base_item.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():

	# Called every time the node is added to the scene.
	# Initialization here
	pass

func explode():
	var oa = $explode_radius.get_overlapping_areas()
	print(oa)
	for t in oa:
		print(t.name)
		if t.is_in_group("enemy") or t.is_in_group("destructable_door"):
			t.kill()
	queue_free()

func _input(event):
	explode()
