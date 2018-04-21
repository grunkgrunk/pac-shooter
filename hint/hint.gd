extends Label
enum {idle, moving, browsing, combining}
func _on_state_change(state, items):
	match state:
		idle:
			text = "Press I to open inventory"
		browsing:
			text = "Press I to equip %s or C to combine" % items
		combining:
			text = "Press C again to combine %s with %s" % items
		