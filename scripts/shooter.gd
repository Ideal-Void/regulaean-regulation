extends Node2D

var marble : PackedScene = preload("res://scenes/marble.tscn")
var speedshot = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot():
	var m = marble.instantiate()
	m.set_speed(750 if not speedshot else 1500)
	owner.add_child(m)
	m.transform = owner.global_transform
	m.position = owner.global_position

func swap():
	print("Swap")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.controller_active:
		# Get vector from right joystick
		Game.direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	else:
		# Get vector from the center point to the mouse
		Game.direction = get_global_mouse_position() - global_position
	# Calculate angle and apply rotation to the object around the center
	global_rotation = Game.direction.angle()
	if Input.is_action_just_pressed("player_shoot"):
		shoot()
	if Input.is_action_just_pressed("player_swap"):
		swap()
