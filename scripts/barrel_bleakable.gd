extends Area3D

@export var bronken_model:PackedScene;

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("weapon"):
		var broken_inst:Node3D = bronken_model.instantiate();
		self.get_parent().get_parent().add_child(broken_inst)
		broken_inst.transform = self.get_parent().transform
		self.get_parent().queue_free()  # Destruir el proyectil
