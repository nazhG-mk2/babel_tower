extends Area3D

@onready var diag = get_parent().get_node("area_diag")

func _ready() -> void:
	# Conecta la señal body_entered para detectar la entrada del jugador
	self.body_entered.connect(_on_player_enter)

func _on_player_enter(body) -> void:
	print('entrar', diag)
	if body.name == "Player":  # Verifica si el jugador entra
		diag.visible = true  # Activa el CanvasLayer para mostrar los diálogos