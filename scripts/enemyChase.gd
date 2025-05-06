extends CharacterBody2D

@export var speed: float = 100.0

func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	if Global.kill_monster:
		queue_free()
	var direction = (Global.player_position_2D - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
