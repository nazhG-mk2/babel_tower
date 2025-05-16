extends "res://scripts/enemy.gd"

@export var speed: float = 90.0
@export var enemy_type: int

func _physics_process(_delta):
	var direction = (Global.player_position_2D - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
