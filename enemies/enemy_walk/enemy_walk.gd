extends KinematicBody2D

var player = null
onready var vision = $vision
onready var nav = $Navigation2D
var health = 3


var is_alive = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	if is_alive:
		if player != null:
			var diff = (player.position - position).normalized()
			move_and_collide(diff * 40 * delta)
		

func _on_vision_body_entered(body):
	if body.name == "player":
		player = body
		

func _on_vision_body_exited(body):
	if body.name == "player":
		player = null

func kill():
	$Anim_sprite.frame = 1
	is_alive = false
	$body.queue_free()
