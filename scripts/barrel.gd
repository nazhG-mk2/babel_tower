extends Node3D

func receive_damage(_amount: int):
	explode()

func explode():
	print("Barrel destroyed!")
	# Aquí puedes añadir una animación, efectos de partículas, etc.
	queue_free()
