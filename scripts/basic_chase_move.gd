extends Area3D

var amplitude = 1  # Amplitud del movimiento (cuánto sube y baja)
var move_speed = 3  # Velocidad constante hacia el jugador
var start_position = Vector3(0, 0, 0)
var time_passed = 0.0  # Variable para contar el tiempo
var phase_offset = 0.0  # Fase inicial aleatoria

@export var drop:PackedScene;

var player: Node3D  # Referencia al jugador

func _ready():
	body_entered.connect(_on_body_entered)
	start_position = global_transform.origin
	player = get_parent().get_parent().get_node("Player")
	phase_offset = randf() * TAU
	# Destruye el proyectil después del tiempo de vida

func _on_body_entered(body):
	if body.is_in_group("weapon"):
		var dropped_item = drop.instantiate()  # Instanciar el objeto
		dropped_item.global_transform.origin = global_transform.origin  # Posicionarlo donde murió el enemigo
		print(dropped_item)
		get_parent().add_child(dropped_item)  # Agregarlo a la escena
		queue_free()  # Destruir el proyectil
		Global.num_enemies -= 1
		
	if body.is_in_group("player"):  # Verifica si es el jugador
		body.take_damage(10)  # Aplica daño
		Global.num_enemies -= 1
		queue_free()  # Destruir el proyectil
		

func receive_damage(_amount: int):
	explode()

func explode():
	# Aquí puedes añadir una animación, efectos de partículas, etc.
	queue_free()

func _process(delta):
	var player_position = player.global_transform.origin
	var current_position = global_transform.origin
	var direction = Vector3(player_position.x, 0, player_position.z) - Vector3(current_position.x, 0, current_position.z)
	#
	if direction.length() > 0.1:  # Evita movimiento si ya está cerca
		direction = direction.normalized() * move_speed * delta
		global_transform.origin.x += direction.x
		global_transform.origin.z += direction.z
