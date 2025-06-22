extends Node

var player_position: Vector3 = Vector3.ZERO
var player_position_2D: Vector2 = Vector2.ZERO

var player = null
var model = null
var num_enemies = 0

var pause_spawn = true

var pause = false

var exp: float = 0
var health: float = 100

enum States {
	WALKING,
	FLAYING,
	CHANGING,
}
