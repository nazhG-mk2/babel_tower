extends CharacterBody2D

@export var speed: float = 200.0
@export var radius = 20
@onready var hitbox = $HitBox

func _ready() -> void:
	hitbox.shape.radius = radius

func _draw():
	draw_circle(self.position, radius, Color(1, 0, 0, .5))  # Círculo rojo en (100,100) con radio 50

func _physics_process(_delta):
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * speed
	move_and_slide()
