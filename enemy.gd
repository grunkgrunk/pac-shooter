extends KinematicBody2D

var player = null
onready var vision = $vision
onready var nav = $Navigation2D
var health = 3
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if player != null:
		var diff = (player.position - position).normalized()
		move_and_collide(diff * 20 * delta)

func _on_vision_body_entered(body):
	if body.name == "player":
		player = body
		

func _on_vision_body_exited(body):
	if body.name == player:
		player = null
