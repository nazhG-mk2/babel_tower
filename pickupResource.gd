extends StaticBody3D

@export var acceleration_curve: Curve  # Curva para controlar la aceleración
var init_pos
var t = 0.0  # Controla el avance en la curva
var distance = 0.0  # Distancia inicial al jugador

func _ready() -> void:
	init_pos = global_position  # Guardar la posición inicial
	set_process(false)

func _process(delta):
	t = clamp(t + delta, 0.0, 1.0)  # Avanzar en el tiempo de animación
	
	# Obtener interpolación desde la curva
	var factor = acceleration_curve.sample(t)  # Controla la aceleración
	var new_pos = init_pos.lerp(Global.player_position, factor)  # Movimiento según la curva
	
	self.get_parent().global_position = new_pos

	# Eliminar si está lo suficientemente cerca
	if global_position.distance_to(Global.player_position) < 0.5:
		Global.exp += 2
		EventBus.exp_earned.emit()
		self.get_parent().queue_free()

func pickup():
	distance = init_pos.distance_to(Global.player_position)  # Calcular la distancia inicial
	set_deferred("collision_layer", 0)  # Desactivar colisiones
	set_process(true)  # Activar el movimiento
	t = 0.0  # Reiniciar la animación
