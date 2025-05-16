extends CharacterBody2D

var id: String;

func _ready():
	add_to_group("enemy")

func _despawn():
	print("Enemy kill", id)
	EnemyManager.enemies_model[id].queue_free()
	self.queue_free()
	EnemyManager.despawn_enemy(id)

func _physics_process(_delta):
	if Global.kill_monster:
		queue_free()
