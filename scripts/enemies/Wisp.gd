extends "res://scripts/enemies/Enemy.gd"

@export var target_distance: float = 300.0
@export var speed: float = 120.0

var direction

@export var life_time: float = 5.0

var timer = 0.0
var target_point 

func _ready():
	# Calcula un punto a target_distance del jugador en una dirección aleatoria
	var angle = randf() * TAU
	target_point = Global.player_position_2D + Vector2(cos(angle), sin(angle)) * target_distance
	direction = (target_point - global_position).normalized()

func _physics_process(delta):
	timer += delta
	if timer >= life_time:
		_despawn()
		return

	velocity = direction * speed
	move_and_slide()
