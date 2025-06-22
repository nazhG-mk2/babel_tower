extends "res://scripts/enemies/EnemyModelBase.gd"

@export var descend_speed: float = 1.0

func _process(_delta: float) -> void:
	super(_delta)
	var enemy = EnemyManager.enemies[id]
	var prev_pos = Vector2(global_position.x, global_position.z)
	var curr_pos = enemy.global_position
	global_position = Vector3(curr_pos.x, global_position.y, curr_pos.y)

	var velocity = curr_pos - prev_pos
	if velocity.length() > 0.01:
		var angle = atan2(-velocity.y, velocity.x)
		rotation.y = angle

	# Descender con el tiempo
	global_position.y = max(0, global_position.y - descend_speed * _delta)
