extends Area3D

@export var enemy_scene: PackedScene = preload("res://scenes/enemies/Minion_01.tscn")
@export var spawn_interval: float = 2.0  # Tiempo entre spawns

func _ready():
	$SpawnTimer.start(spawn_interval)  # Asegúrate de que tengas un Timer en el nodo

func _on_SpawnTimer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.global_transform.origin = get_random_spawn_position()
	get_parent().add_child(enemy)

func get_random_spawn_position() -> Vector3:
	var shape = $CollisionShape3D.shape
	if shape is BoxShape3D:  # Si el colisionador es un cubo
		var extents = shape.size * 0.5
		var random_x = randf_range(-extents.x, extents.x)
		var random_z = randf_range(-extents.z, extents.z)
		return global_transform.origin + Vector3(random_x, 0, random_z)
	return global_transform.origin


func _on_spawn_timer_timeout() -> void:
	pass # Replace with function body.
