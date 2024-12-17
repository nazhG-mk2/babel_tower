extends Node3D

# Variables
var direction = Vector3(0, 0, 1) # Dirección inicial (puedes cambiarla dinámicamente)
var speed = 4 # Velocidad del proyectil
var life_time = 6.0 # Tiempo de vida en segundos

func _ready():
	# Destruye el proyectil después del tiempo de vida
	await get_tree().create_timer(life_time).timeout
	queue_free()

func _process(delta):
	# Mueve el proyectil en la dirección indicada
	global_translate(direction * speed * delta)
