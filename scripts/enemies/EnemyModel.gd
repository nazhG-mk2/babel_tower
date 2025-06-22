extends Node3D

enum { WALKING, CHARGING }

var id: String

func _process(_delta: float) -> void:
	if EnemyManager.enemies.has(id):
		var target_pos = Global.player_position_2D
		var enemy_pos = EnemyManager.enemies[id].global_position
		global_position = Vector3(enemy_pos.x, global_position.y, enemy_pos.y)

		if EnemyManager.enemies[id].state == WALKING:
			var dir = (target_pos - Vector2(global_position.x, global_position.z)).normalized()
			var angle = atan2(-dir.y, dir.x)
			rotation.y = angle 
