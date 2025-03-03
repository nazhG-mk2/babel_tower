extends TextureRect

func _ready():
	EventBus.player_damaged.connect(mostrar_flash)

func mostrar_flash(_health, _max_health):
	var tween = create_tween()
	tween.tween_property(self.material, "shader_parameter/flash_amount", 0.0, 0.5)
	
func _process(delta: float) -> void:
	pass
