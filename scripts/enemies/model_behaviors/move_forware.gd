extends "res://scripts/enemies/EnemyModelBase.gd"

@export var descend_speed: float = 1.0
@export var max_height: float = 20.0
@export var min_height: float = 1.0
@export var max_distance: float = 1000.0 # distancia máxima para altura máxima

var initial_pos_set := false
var initial_distance := 0.0

func _process(_delta: float) -> void:
	super(_delta)
	var enemy = EnemyManager.enemies[id]
	var prev_pos = Vector2(global_position.x, global_position.z)
	var curr_pos = enemy.global_position
	global_position = Vector3(curr_pos.x, global_position.y, curr_pos.y)

	# Guardar la distancia inicial al jugador solo una vez
	if not initial_pos_set:
		var player_pos = Global.player_position_2D
		initial_distance = (curr_pos - player_pos).length()
		# Interpolar altura según distancia inicial
		var t = clamp(initial_distance / max_distance, 0, 1)
		global_position.y = lerp(min_height, max_height, t)
		initial_pos_set = true

	var velocity = curr_pos - prev_pos
	if velocity.length() > 0.01:
		var angle = atan2(-velocity.y, velocity.x)
		rotation.y = angle

	# Descender con el tiempo
	global_position.y = max(0, global_position.y - descend_speed * _delta)
