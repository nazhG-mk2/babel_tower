extends Node3D

# Velocidades de rotación para cada anillo
@export var speed_external: float = 10.0
@export var speed_middle: float = 20.0
@export var speed_internal: float = 30.0

func _process(delta):
	$Ring_External.rotate_y(deg_to_rad(speed_external * delta))
	$Ring_Middle.rotate_y(deg_to_rad(speed_middle * delta))
	$Ring_Internal.rotate_y(deg_to_rad(speed_internal * delta))
