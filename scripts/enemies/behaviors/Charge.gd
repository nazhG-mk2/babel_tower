extends "res://scripts/enemies/behaviors/chase.gd"

@export var charge_distance := 100.0
@export var charge_duration := 1.0
@export var charge_curve: Curve

var charge_timer = 0.0
var charge_direction = Vector2.ZERO

var curve_length = 1.0

func _ready() -> void:
	curve_length = charge_curve.max_domain

func charge(delta):
	charge_timer += delta
	var t = charge_timer / charge_duration
	if t >= curve_length:
		state = WALKING
		return
	var speed = charge_curve.sample(t)
	velocity = charge_direction * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("obstacle"):
			self._despawn()
		elif collision.get_collider().is_in_group("enemy"):
			print(collision.get_collider()._despawn())

func _physics_process(delta):
	var to_player = Global.player_position_2D - global_position
	var distance = to_player.length()

	if state == WALKING:
		if distance < charge_distance:
			state = CHARGING
			charge_timer = 0.0
			charge_direction = to_player.normalized()
		else:
			chase_player()
	elif state == CHARGING:
		charge(delta)
