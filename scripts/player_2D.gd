extends CharacterBody2D

@export var speed: float = 200.0
 
func _physics_process(delta):
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Global.player:
		Global.player.global_position = Vector3(global_position.x, Global.player.global_position.y, global_position.y)
		if input_dir.length() > 0:
			var target_angle = atan2(input_dir.x, input_dir.y)
			Global.player.rotation.y = lerp_angle(Global.player.rotation.y, target_angle, delta * 5)
	velocity = input_dir * speed
	move_and_slide()
	Global.player_position_2D = global_position
