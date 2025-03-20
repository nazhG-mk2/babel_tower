extends Node3D

func receive_damage(_amount: int):
	explode()

func explode():
	# Aquí puedes añadir una animación, efectos de partículas, etc.
	queue_free()
