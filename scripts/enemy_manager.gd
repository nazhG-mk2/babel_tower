extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval := 2.0
@export var spawn_distance := 200.0

var timer := 0.0

func _process(delta):
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
	var result = space.intersect_point(query)
	return result.is_empty()

func spawn_enemies():
	var attempts := 0
	while attempts < 10:
		var angle = randf_range(0, TAU)
		var offset = Vector2(cos(angle), sin(angle)) * spawn_distance
		var spawn_pos = Global.player_position_2D + offset
		if is_position_free(spawn_pos):
			var enemy = enemy_scene.instantiate()
			enemy.global_position = spawn_pos
			add_child(enemy)
			attempts += 1
