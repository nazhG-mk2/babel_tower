extends Node3D

var models = [
	preload("res://scenes/enemies/01_Imp_model.tscn"),
	preload("res://scenes/enemies/02_Fat_Bat_model.tscn")
]

func _ready():
	EnemyManager.CurrentWorld = self
	EnemyManager.enemy_spawned.connect(_on_enemy_spawned)

func _on_enemy_spawned(enemy_id, enemy_type):
	print("Spawned enemy:", enemy_id, enemy_type)
	var scene = models[enemy_type]
	var model_instance = scene.instantiate()
	model_instance.id = enemy_id
	add_child(model_instance)
	EnemyManager.enemies_model[enemy_id] = model_instance
