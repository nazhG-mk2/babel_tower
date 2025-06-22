extends Node

signal enemy_spawned(enemy_id, enemy_type)

var CurrentWorld: Node3D

var enemies = {}
var enemies_model = {}
var data = {}

var enemy_counter := 0
var enemy_current_id := 0

func generate_enemy_id() -> String:
	enemy_current_id += 1
	return "enemy_%d" % enemy_current_id

func spawn_enemy(node2d: Node2D):
	var id = generate_enemy_id()
	enemies[id] = node2d
	enemy_counter += 1
	emit_signal("enemy_spawned", id, node2d.enemy_type)
	return id

func despawn_enemy(id: String):
	enemy_counter -= 1
	if enemies.has(id):
		# Delete Model in 3D world
		EnemyManager.enemies_model[id].queue_free()
		enemies.erase(id)
		enemies_model.erase(id)
	if data.has(id):
		data.erase(id)
