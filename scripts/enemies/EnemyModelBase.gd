extends Node3D

enum { WALKING, CHARGING }

var id: String

func _process(_delta: float) -> void:
	if !EnemyManager.enemies.has(id):
		return
