extends Node2D

@export var spawn_interval := 2.0
@export var spawn_distance := 400.0

var timer := 0.0

func _process(delta):
	if Global.pause_spawn:
		return
	timer += delta
	if timer >= spawn_interval:
		timer = 0.0
		spawn_enemies()

func is_position_free(pos: Vector2) -> bool:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.exclude = [$Area2D]
	var result = space.intersect_point(query)
	return result.is_empty()

func spawn_enemies():
	var attempts := 0
	while attempts < 1:
		var angle = randf_range(0, TAU)
		var offset = Vector2(cos(angle), sin(angle)) * spawn_distance
		var spawn_pos = Vector2(600, 600) + offset
		if is_position_free(spawn_pos) and Enemies.list.size() > 0:
			var scene = Enemies.list[5].hitbox
			#var scene = enemy_scenes[randi() % enemy_scenes.size()]
			var enemy = scene.instantiate()
			var id = EnemyManager.spawn_enemy(enemy)
			enemy.id = id
			enemy.global_position = spawn_pos
			add_child(enemy)
		attempts += 1
