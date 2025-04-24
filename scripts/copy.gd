@tool
extends StaticBody2D

@onready var poly = $Polygon2D
@onready var collision = $CollisionPolygon2D

func _ready():
	if Engine.is_editor_hint():
		collision.polygon = poly.polygon
