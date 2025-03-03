extends CanvasLayer

@onready var health_bar = $HealthBar

func _ready():
	EventBus.player_damaged.connect(update_health_display)

func update_health_display(health, max_health):
	health_bar.value = (health * 100) / max_health
