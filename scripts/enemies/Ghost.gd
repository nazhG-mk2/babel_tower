extends "res://scripts/enemies/Enemy.gd"

@export var spawn_distance: float = 400.0
@export var speed: float = 120.0
@export var life_time: float = 5.0
@export var max_angle_per_second: float = 1.0 # en radianes por segundo

var move_direction = Vector2.ZERO
var timer = 0.0

func _ready():
	var angle = randf() * TAU
	global_position = Global.player_position_2D + Vector2(cos(angle), sin(angle)) * spawn_distance
	move_direction = (Global.player_position_2D - global_position).normalized()

func _physics_process(delta):
	timer += delta
	if timer >= life_time:
		_despawn()
		return

	var to_player = Global.player_position_2D - global_position
	var desired_direction = to_player.normalized()
	# Limitar el ángulo de giro por frame
	var max_angle = max_angle_per_second * delta
	move_direction = move_direction.slerp(desired_direction, clamp(max_angle / move_direction.angle_to(desired_direction), 0, 1)) if move_direction.angle_to(desired_direction) > max_angle else desired_direction

	velocity = move_direction * speed
	move_and_slide()
