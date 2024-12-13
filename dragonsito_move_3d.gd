extends RigidBody3D

var amplitude = 1  # Amplitud del movimiento (cuánto sube y baja)
var speed = 0.8  # Velocidad de subida y bajada (más bajo = más lento)
var start_position = Vector3(0, 0, 0)
var time_passed = 0.0  # Variable para contar el tiempo

var player: Node3D  # Referencia al jugador

func _ready():
	start_position = global_transform.origin
	player = get_node("/root/Player")

func _process(delta):
	# Contamos el tiempo transcurrido
	time_passed += delta  # 'delta' es el tiempo desde el último frame
	
	# Movimiento suave con un incremento basado en el tiempo
	var y_offset = amplitude * sin(speed * time_passed)
	
	# Actualizamos la posición en Y
	global_transform.origin.y = start_position.y + y_offset
