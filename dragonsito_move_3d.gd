extends RigidBody3D

var amplitude = 1  # Amplitud del movimiento (cuánto sube y baja)
var speed = 0.8  # Velocidad de subida y bajada (más bajo = más lento)
var move_speed = 0.1  # Velocidad constante hacia el jugador
var start_position = Vector3(0, 0, 0)
var time_passed = 0.0  # Variable para contar el tiempo
var phase_offset = 0.0  # Fase inicial aleatoria

var player: Node3D  # Referencia al jugador

func _ready():
	start_position = global_transform.origin
	player = get_parent().get_node("Player")
	phase_offset = randf() * TAU

func _process(delta):
	# Movimiento en Y
	time_passed += delta
	var y_offset = amplitude * sin(speed * time_passed + phase_offset)
	global_transform.origin.y = start_position.y + y_offset
	# Movimiento hacia el jugador en X y Z
	var player_position = player.global_transform.origin
	var current_position = global_transform.origin
	var direction = Vector3(player_position.x, 0, player_position.z) - Vector3(current_position.x, 0, current_position.z)
	#
	if direction.length() > 0.1:  # Evita movimiento si ya está cerca
		direction = direction.normalized() * move_speed * delta
		global_transform.origin.x += direction.x
		global_transform.origin.z += direction.z
