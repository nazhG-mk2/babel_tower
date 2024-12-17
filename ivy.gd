extends Node3D

# Ruta del proyectil
@export var projectile_scene: PackedScene

# Variables
var spawn_interval = 6.0 # Intervalo en segundos

func _ready():
	# Llama a la función de creación de proyectiles cada 6 segundos
	spawn_projectile_periodically()

func spawn_projectile_periodically():
	while true:
		# Instanciar y añadir el proyectil
		var projectile_instance = projectile_scene.instantiate()
		projectile_instance.position = $Spawner.position # Ajusta la posición local
		add_child(projectile_instance)

		# Esperar el intervalo antes de crear otro proyectil
		await get_tree().create_timer(spawn_interval).timeout
