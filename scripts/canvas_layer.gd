extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var exp_bar = $ExpBar

func _ready():
	EventBus.player_damaged.connect(update_health_display)
	EventBus.exp_earned.connect(update_exp_display)

func update_health_display(health, max_health):
	health_bar.value = (health * 100) / max_health
	
func update_exp_display():
	exp_bar.value = (Global.exp * 100) / 100
