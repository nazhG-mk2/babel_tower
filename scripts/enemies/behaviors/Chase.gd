extends "res://scripts/enemies/Enemy.gd"

@export var speed: float = 90.0

func chase_player():
	var direction = (Global.player_position_2D - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
