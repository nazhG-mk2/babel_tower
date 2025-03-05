extends Node3D

@onready var skeleton = $Skeleton
@onready var breast_l = skeleton.get_node("Breast_l")
@onready var breast_r = skeleton.get_node("Breast_r")

var prev_position: Vector3

func _ready():
	print("hola")
	prev_position = global_transform.origin
	start_floating()

func _physics_process(delta):
	pass
	#var velocity = (global_transform.origin - prev_position) / delta
	#prev_position = global_transform.origin
	#
	## Simular rebote de los pechos basado en la velocidad
	#var jiggle_intensity = velocity.length() * 0.001
	#
	#breast_l.position.y += jiggle_intensity
	#breast_r.position.y += jiggle_intensity
	#
	## Suavizar el movimiento para evitar cambios bruscos
	#breast_l.position.y = lerp(breast_l.position.y, 0.0, 0.0)
	#breast_r.position.y = lerp(breast_r.position.y, 0.0, 0.0)

func start_floating():
	var tween2 = create_tween().set_loops()
	tween2.tween_property(self, "position:y", self.position.y - 0.1, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(self, "position:y", self.position.y + 0.1, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
