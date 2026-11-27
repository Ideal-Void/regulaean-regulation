extends Node2D

var controller_active : bool = false
var loss = false
var win = false
var STICK_DEADZONE : float = 0.2
var direction : Vector2
var difficulty_modifier : int = 0
signal level_begin
signal level_end
signal marble_entering_chain

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event: InputEvent) -> void:
	# Detect controller activation
	if (event is InputEventJoypadButton and event.pressed) or (event is InputEventJoypadMotion and abs(event.axis_value) > STICK_DEADZONE):
		controller_active = true
	elif (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed):
		controller_active = false

	# Block keyboard input while controller is active
	if controller_active and event is InputEventKey:
		get_viewport().set_input_as_handled()
