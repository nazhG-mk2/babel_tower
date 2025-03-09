extends CharacterBody3D

@export var damage: int = 10
@onready var sprite_a = $Close
@onready var sprite_b = $Open
var tween: Tween

func _ready():
	add_to_group("weapon")
	tween = get_tree().create_tween().set_loops()
	
	tween.tween_callback(_toggle_visibility).set_delay(.3)  # Llama cada 1s

func _toggle_visibility():
	sprite_a.visible = !sprite_a.visible
	sprite_b.visible = !sprite_b.visible

func _on_body_entered(body):
	print("Hola")
	#if body.is_in_group("enemies"):
	body.take_damage(damage)
