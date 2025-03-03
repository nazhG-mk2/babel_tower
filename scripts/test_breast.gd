extends Node2D

@onready var jbr = $Target/JBR
@onready var jbl = $Target/JBL

var jbr_initial_pos = Vector2.ZERO
var jbl_initial_pos = Vector2.ZERO

func _ready():
	# Guarda la posición inicial
	jbr_initial_pos = jbr.position
	jbl_initial_pos = jbl.position
	EventBus.player_damaged.connect(mostrar_flash)

func adjust_nodes(vx, vy):
	var maxMoveY = 40
	if vy > 0: # subiendo
		jbr.position = jbr_initial_pos + Vector2(0, -maxMoveY);  # Ajusta según sea necesario
		jbl.position = jbl_initial_pos + Vector2(0, -maxMoveY);
	elif vy < 0: # bajando
		jbr.position = jbr_initial_pos - Vector2(0, maxMoveY);
		jbl.position = jbl_initial_pos - Vector2(0, maxMoveY);
	else:
		jbr.position = jbr_initial_pos
		jbl.position = jbl_initial_pos
		
	var maxMoveX = 25
	if vx > 0: # ziquierda
		jbr.position = jbr_initial_pos + Vector2(-maxMoveX, 0);  # Ajusta según sea necesario
		jbl.position = jbl_initial_pos + Vector2(-maxMoveX, 0);
	elif vx < 0: # derecha
		jbr.position = jbr_initial_pos - Vector2(maxMoveX, 0);
		jbl.position = jbl_initial_pos - Vector2(maxMoveX, 0);
	else:
		jbr.position = jbr_initial_pos
		jbl.position = jbl_initial_pos

@onready var sprite_material = $Sprite.material
@onready var Breast_material = $Breast.material
@onready var Left_wing_material = $Wings/Left.material
@onready var Right_wing_material = $Wings/Right.material
@onready var blood_particles = $GPUParticles2D

func mostrar_flash(_health, _max_health):
	sprite_material.set_shader_parameter("flash_amount", 1.0)
	Breast_material.set_shader_parameter("flash_amount", 1.0)
	Left_wing_material.set_shader_parameter("flash_amount", 1.0)
	Right_wing_material.set_shader_parameter("flash_amount", 1.0)
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(Breast_material, "shader_parameter/flash_amount", 0.0, 0.5)
	tween.tween_property(sprite_material, "shader_parameter/flash_amount", 0.0, 0.5)
	tween.tween_property(Left_wing_material, "shader_parameter/flash_amount", 0.0, 0.5)
	tween.tween_property(Right_wing_material, "shader_parameter/flash_amount", 0.0, 0.5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
