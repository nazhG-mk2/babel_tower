extends Node

signal enemy_spawned(enemy_id, enemy_type)
signal enemy_despawned(enemy_id)

var CurrentWorld: Node3D

var enemies = {}
var enemies_model = {}

var enemy_counter := 0
var enemy_current_id := 0

func generate_enemy_id() -> String:
	enemy_current_id += 1
	return "enemy_%d" % enemy_current_id

func spawn_enemy(node2d: Node2D):
	var id = generate_enemy_id()
	enemies[id] = node2d
	enemy_counter += 1
	print(node2d.enemy_type)
	emit_signal("enemy_spawned", id, node2d.enemy_type)
	return id

func despawn_enemy(id: String):
	enemy_counter -= 1
	if enemies.has(id):
		emit_signal("enemy_despawned", id)
		enemies.erase(id)
		enemies_model.erase(id)
