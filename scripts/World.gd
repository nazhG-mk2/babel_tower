extends Node3D

func _ready():
	EnemyManager.CurrentWorld = self
	EnemyManager.enemy_spawned.connect(_on_enemy_spawned)

func _on_enemy_spawned(enemy_id, enemy_type):
	var scene = Enemies.list[enemy_type].model
	var model_instance = scene.instantiate()
	model_instance.id = enemy_id
	add_child(model_instance)
	print(enemy_type)
	EnemyManager.enemies_model[enemy_id] = model_instance
