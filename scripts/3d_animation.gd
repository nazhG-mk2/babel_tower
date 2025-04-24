extends Node3D

@onready var skeleton = $Skeleton
@onready var breast_l = skeleton.get_node("Breast_l")
@onready var breast_r = skeleton.get_node("Breast_r")

var prev_position: Vector3

@export_group("Ajustes de GiggleBone")
@export_range(0.0, 100.0, 0.1) var stiffness: float = 5.0
@export_range(0.0, 100.0, 0.1) var damping: float = 1.0

func _ready():
	prev_position = global_transform.origin
	start_floating()
	Global.player = self
	
	$Skeleton/arm_l.stiffness = stiffness
	$Skeleton/arm_l.damping = damping	
	$Skeleton/arm_r.stiffness = stiffness
	$Skeleton/arm_r.damping = damping
	
	$Skeleton/But_l.stiffness = stiffness
	$Skeleton/But_l.damping = damping	
	$Skeleton/But_r.stiffness = stiffness
	$Skeleton/But_r.damping = damping
	
	$Skeleton/Breast_l.stiffness = stiffness
	$Skeleton/Breast_l.damping = damping	
	$Skeleton/Breast_r.stiffness = stiffness
	$Skeleton/Breast_r.damping = damping

func start_floating():
	var tween2 = create_tween().set_loops()
	tween2.tween_property(self, "position:y", self.position.y - 0.1, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(self, "position:y", self.position.y + 0.1, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
