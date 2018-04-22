extends Control

onready var tie = $engine

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	tie.set_color(Color(1,1,1))
	#combine_item("fish", "fishing rod")
	print("hello")

func _process(delta):
	pass

func combine_or_select(items):
	show()
	var item_names = []
	for i in items:
		if i != null:
			item_names.append(i.item_name)
	
	tie.reset()
	if item_names.size() == 1:
		tie.buff_text("Press 'I' to equip %s or 'C' to combine" % item_names, 0.01)
	else:
		tie.buff_text("Press 'C' again to combine '%s' and '%s'" % item_names, 0.01)
	tie.set_state(tie.STATE_OUTPUT)
		

func equip(item):
	show()
	tie.reset()
	tie.buff_text("I now have %s equipped!" % item, 0.01)
	tie.set_state(tie.STATE_OUTPUT)
	
	
func reload():
	show()
	tie.reset()
	tie.buff_text("I have now reloaded the gun!", 0.02)
	tie.set_state(tie.STATE_OUTPUT)
	
func say(sent):
	if sent == null:
		hide()
		return
	show()
	tie.reset()
	tie.buff_text(sent, 0.01)
	tie.set_state(tie.STATE_OUTPUT)
	
	