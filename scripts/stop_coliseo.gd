extends Area2D

func _ready():
	body_exited.connect(_on_body_exited)
	body_entered.connect(_on_body_entered)

func _on_body_exited(body):
	if body.name == "Player":
		Global.pause_spawn = true

func _on_body_entered(body):
	if body.name == "Player":
		Global.pause_spawn = false
