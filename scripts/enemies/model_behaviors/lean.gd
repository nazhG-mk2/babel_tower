extends Node3D

enum { WALKING, CHARGING }

var id: String
var target: Vector2

func _process(_delta: float) -> void:
	if EnemyManager.enemies.has(id):
		if !target:
			target = EnemyManager.enemies[id].target_point
			print(target.x, target.y)
			var look_target = Vector3(-target.x, global_position.y, target.y)
			look_at(look_target, Vector3.UP)
		var enemy_pos = EnemyManager.enemies[id].global_position
		global_position = Vector3(enemy_pos.x, global_position.y, enemy_pos.y)
		
		var armature = $Armature
		var look_target = Vector3(enemy_pos.x, armature.global_position.y, enemy_pos.y)
		armature.look_at(look_target, Vector3.UP)
