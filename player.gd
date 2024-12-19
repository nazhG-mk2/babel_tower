extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var player: Node3D
@export var attack_damage: int = 10
@export var attack_cooldown: float = 0.5
var can_attack: bool = true

func attack():
	if not can_attack:
		print('atck cd')
		return
	print('atck')
	
	can_attack = false
	$Area3D.monitoring = true       # Activa el área para detectar colisiones
	$AnimationPlayer.play("area_flash")
	
	# Desactiva el área tras un breve tiempo (sin `yield`)
	await get_tree().create_timer(0.4).timeout
	$AnimationPlayer.stop(true)
	$Area3D.monitoring = false

	# Aplica el cooldown antes de poder atacar de nuevo
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func _physics_process(delta: float) -> void:
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
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		_update_sprite_flip(input_dir.x)  # Actualiza el sprite según el movimiento horizontal
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
		
func _update_sprite_flip(direction_x: float):
	if direction_x > 0:  # Moviéndose a la derecha
		$Sprite3D.flip_h = true
		$Area3D.rotation_degrees.y = 0
	elif direction_x < 0:  # Moviéndose a la izquierda
		$Sprite3D.flip_h = false
		$Area3D.rotation_degrees.y = 180
