extends Node3D

var id: String

@export var rotation_speed = 1

func _process(delta: float) -> void:
	if EnemyManager.enemies.has(id):
		var target_pos = Global.player_position_2D
		var enemy_pos = EnemyManager.enemies[id].global_position
		var direction = (Vector2(target_pos) - Vector2(enemy_pos)).normalized()
		
		global_position.x = enemy_pos.x
		global_position.z = enemy_pos.y

		# Calcular eje de rotación perpendicular al movimiento (como rueda)
		var movement_dir = Vector3(direction.x, 0, direction.y)
		var rotation_axis = movement_dir.cross(Vector3.DOWN).normalized()

		# Rotar como rueda
		var rotation_amount = delta * rotation_speed
		$Fat.rotate(rotation_axis, rotation_amount)
