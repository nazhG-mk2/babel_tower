extends "res://scripts/enemies/Enemy.gd"

@export var spawn_distance: float = 400.0
@export var acceleration: float = 75.0
@export var max_speed: float = 500.0
@export var life_time: float
@export var max_angle_per_second: float = 2 # en radianes por segundo
@export var acceleration_loss_per_radian: float = 0.5 # cuanto pierde por radian girado

var move_direction = Vector2.ZERO
var timer = 0.0
var current_speed = 0.0
var current_acceleration = 0.0

func _ready():
	var angle = randf() * TAU
	global_position = Global.player_position_2D + Vector2(cos(angle), sin(angle)) * spawn_distance
	move_direction = (Global.player_position_2D - global_position).normalized()
	current_speed = 0.0
	current_acceleration = acceleration

func _physics_process(delta):
	timer += delta
	if timer >= life_time:
		_despawn()
		return

	var to_player = Global.player_position_2D - global_position
	var desired_direction = to_player.normalized()
	var max_angle = max_angle_per_second * delta
	var angle_diff = move_direction.angle_to(desired_direction)
	
	# Limitar el ángulo de giro por frame
	if abs(angle_diff) > max_angle:
		move_direction = move_direction.slerp(desired_direction, clamp(max_angle / abs(angle_diff), 0, 1))
	else:
		move_direction = desired_direction

	# Pierde aceleración al girar
	current_acceleration = max(0.0, current_acceleration - abs(angle_diff) * acceleration_loss_per_radian)
	# Recupera aceleración si no gira
	if abs(angle_diff) < 0.01:
		current_acceleration = min(acceleration, current_acceleration + acceleration * delta * 0.5)

	# Aumenta la velocidad con la aceleración actual
	current_speed = min(max_speed, current_speed + current_acceleration * delta)
	velocity = move_direction * current_speed
	move_and_slide()
