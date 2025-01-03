extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6
@export var player: Node3D
@export var attack_damage: int = 10
@export var attack_cooldown: float = 0.5
var can_attack: bool = true

@onready var succubus = $Viewport/Succubus  # Cambia la ruta según tu jerarquía

# TODO: nos linear dash velocity
var dash_speed = 4.0
var dash_duration = 0.2
var is_dashing = false
var dash_time_left = 0

func _ready():
	# Conecta la señal cuando un cuerpo entra en el área
	$Area3D.body_entered.connect(_on_body_entered)

func attack():
	if not can_attack:
		print("Attack on cooldown")
		return
	
	print("Attack initiated")
	can_attack = false
	$Area3D.monitoring = true  # Activa el área para detectar colisiones
	$AnimationPlayer.play("area_flash")
	
	# Desactiva el área después de un breve tiempo
	await get_tree().create_timer(0.4).timeout
	$AnimationPlayer.stop(true)
	$Area3D.monitoring = false
	
	# Aplica el cooldown antes de poder atacar de nuevo
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	
func _on_body_entered(body):
	print("dentro del rango de ataque: ", body.name)
	if $Area3D.monitoring and body.has_method("receive_damage"):
		body.receive_damage(attack_damage)
		print("Inflicted", attack_damage, "damage to", body)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("dash") and not is_dashing:
		start_dash()
	
	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			stop_dash()

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed := SPEED
	if is_dashing:
		speed += dash_speed
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		_update_sprite_flip(input_dir.x)  # Actualiza el sprite según el movimiento horizontal
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func start_dash():
	is_dashing = true
	dash_time_left = dash_duration

func stop_dash():
	is_dashing = false

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		attack()
	succubus.adjust_nodes(velocity.y)
		
func _update_sprite_flip(direction_x: float):
	if direction_x > 0:  # Moviéndose a la derecha
		$Sprite3D.flip_h = true
		$Area3D.rotation_degrees.y = 0
	elif direction_x < 0:  # Moviéndose a la izquierda
		$Sprite3D.flip_h = false
		$Area3D.rotation_degrees.y = 180
