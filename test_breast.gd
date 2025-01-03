extends Node2D

@onready var jbr = $Target/JBR
@onready var jbl = $Target/JBL

var jbr_initial_pos = Vector2.ZERO
var jbl_initial_pos = Vector2.ZERO

func _ready():
	# Guarda la posición inicial
	jbr_initial_pos = jbr.position
	jbl_initial_pos = jbl.position
	
func adjust_nodes(v: int):
	
	if v > 0: # subiendo
		jbr.position = jbr_initial_pos + Vector2(0, 60)  # Ajusta según sea necesario
		jbl.position = jbl_initial_pos + Vector2(0, 60)
	elif v > 0: # bajando
		jbr.position = jbr_initial_pos - Vector2(0, 50)
		jbl.position = jbl_initial_pos - Vector2(0, 50)
	else:
		jbr.position = jbr_initial_pos
		jbl.position = jbl_initial_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
