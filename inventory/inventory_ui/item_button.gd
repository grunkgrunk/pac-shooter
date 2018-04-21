extends TextureButton

signal item_selected

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func pressed():
	print("pressed")
	emit_signal("item_selected", self)