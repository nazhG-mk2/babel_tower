extends Area3D

@export var damage: int = 10  # Daño del proyectil

func _ready():
	body_entered.connect(_on_body_entered)
	# Destruye el proyectil después del tiempo de vida
	await get_tree().create_timer(life_time).timeout
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):  # Verifica si es el jugador
		body.take_damage(damage)  # Aplica daño
		queue_free()  # Destruir el proyectil

# Variables
var direction = Vector3(0, 0, 1) # Dirección inicial (puedes cambiarla dinámicamente)
var speed = 4 # Velocidad del proyectil
var life_time = 6.0 # Tiempo de vida en segundos

func _process(delta):
	# Mueve el proyectil en la dirección indicada
	global_translate(direction * speed * delta)
