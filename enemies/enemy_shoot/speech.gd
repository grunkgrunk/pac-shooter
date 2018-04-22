extends Control

onready var tie = $engine

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	hide()

func say(sent, time=0.01):
	if sent == null:
		hide()
		return
	show()
	tie.reset()
	tie.buff_text(sent, time)
	tie.set_state(tie.STATE_OUTPUT)
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
