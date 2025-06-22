extends CharacterBody2D

# STATES - What is the enemy doing ?
enum { WALKING, FLAYING, CHARGING }

# Unique identifier - used on EnemyManager
var id: String;
# Current State
var state = WALKING
# Enemy type ID should be set in the inherited scene
@export var enemy_type: int

func _despawn():
	# Delete Shape in the 2D physics world
	self.queue_free()
	# Delete referencia from the manager
	EnemyManager.despawn_enemy(id)

func _physics_process(_delta):
	if Global.pause_spawn:
		queue_free()
