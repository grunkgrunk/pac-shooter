extends "res://items/base_item.gd"

onready var timer = $timer
onready var speech = $speech

var player = null
var last_time = -1

var is_alive = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _process(delta):
	var current_time = round(timer.time_left)
	if last_time != current_time:
		last_time = current_time
		speech.say(str(current_time),0)

func _on_timer_timeout():
	speech.say("Boom")
	player.kill()


func _on_range_body_entered(body):
	if body.name == "player" and player == null:
		player = body
		# start timer
		speech.say("Hey, I will kill you in 10 secs")
		timer.start()
