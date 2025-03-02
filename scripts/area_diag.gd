extends Area3D

@onready var diag = get_parent().get_node("boss_diag")

func _ready() -> void:
	# Conecta la señal body_entered para detectar la entrada del jugador
	self.body_entered.connect(_on_player_enter)

func _on_player_enter(body) -> void:
	print('entrar ', body.name)
	if body.name == "Player":  # Verifica si el jugador entra
		print('mostrando dialogo', diag.visible)
		diag.visible = true  # Activa el CanvasLayer para mostrar los diálogos


func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		print("Hide dialog")
		diag.visible = false
