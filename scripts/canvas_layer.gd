extends CanvasLayer

@onready var health_label = $HealthLabel  # Suponiendo que tienes un Label

func _ready():
	EventBus.player_damaged.connect(update_health_display)

func update_health_display(amount):
	health_label.text = "Recibiste daño: " + str(amount)
