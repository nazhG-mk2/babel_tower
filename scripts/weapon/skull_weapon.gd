extends Node3D

@export var speed: float = 4.0  # Velocidad de rotación en radianes por segundo
@onready var rotator = $Rotator

func _process(delta):
	rotator.rotate_y(speed * delta)
