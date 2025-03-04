extends Node3D

@onready var left_wing = $Left
@onready var right_wing = $Right
@onready var tween_left = create_tween().set_loops()
@onready var tween_right = create_tween().set_loops()

var base_speed = 0.5  # Velocidad base de la animación
var move_speed = 0.0  # Velocidad del personaje

func _ready():
	animar_alas()

func animar_alas():
	var anim_speed = base_speed - (move_speed * 0.03)
	anim_speed = max(0.1, anim_speed)  # Evita que sea demasiado rápido

	tween_left.tween_property(left_wing, "rotation_degrees", Vector3(0, 0, -50), anim_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_left.tween_property(left_wing, "rotation_degrees", Vector3(0, 0, 0), anim_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween_right.tween_property(right_wing, "rotation_degrees", Vector3(0, 0, 50), anim_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_right.tween_property(right_wing, "rotation_degrees", Vector3(0, 0, 0), anim_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _process(delta):
	pass  # Aquí podrías actualizar move_speed dinámicamente
