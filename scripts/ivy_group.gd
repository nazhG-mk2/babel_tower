extends Node3D

# Variables
@export var shoot_direction: Vector3 = Vector3(1, 0, 0)  # Dirección común para todos los proyectiles
@onready var projectiles = [$ivy_1, $ivy_2, $ivy_3]  # Referencias a los proyectiles

func _ready():
	# Asigna la misma dirección a todos los proyectiles
	for ivy in projectiles:
		ivy.direction = shoot_direction.normalized()  # Asegura que la dirección esté normalizada para un movimiento consistente

func set_direction(new_direction: Vector3):
	# Permite cambiar la dirección de disparo en tiempo real
	shoot_direction = new_direction
	_ready()  # Vuelve a asignar la dirección a los proyectiles
