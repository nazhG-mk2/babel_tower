extends Node3D

# Ruta del proyectil
@export var projectile_scene: PackedScene

# Variables
var spawn_interval = 6.0 # Intervalo en segundos
var player: Node3D
var toggle = false


func _ready():
	player = get_node("/root/Node3D/Player")
	# Llama a la función de creación de proyectiles cada 6 segundos
	spawn_projectile_periodically()
	$Sprite3D.flip_h = toggle


func spawn_projectile_periodically():
	while true:
		# Instanciar y añadir el proyectil
		var projectile_instance = projectile_scene.instantiate()
		projectile_instance.position = $Spawner.position # Ajusta la posición local

		var player_position = player.global_transform.origin
		var direction = (player_position - $Spawner.global_transform.origin).normalized()

		# Ajustar la dirección del proyectil
		projectile_instance.direction = direction

		toggle = !toggle
		$Sprite3D.flip_h = toggle 
		add_child(projectile_instance)

		# Esperar el intervalo antes de crear otro proyectil
		await get_tree().create_timer(spawn_interval).timeout
