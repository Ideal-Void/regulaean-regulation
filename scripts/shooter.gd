extends Node2D

var marble : PackedScene = preload("res://scenes/marble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot():
	var m = marble.instantiate()
	owner.add_child(m)
	m.transform = owner.global_transform

func swap():
	print("Swap")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("player_shoot"):
		shoot()
	if Input.is_action_just_pressed("player_swap"):
		swap()
