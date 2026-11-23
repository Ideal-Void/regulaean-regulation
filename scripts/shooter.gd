extends Node2D

var marble : PackedScene = preload("res://scenes/marble.tscn")
var speedshot = false
var can_shoot = true
@onready var snd_shoot = $shoot
@onready var snd_swap = $swap
@onready var snd_reload = $reload
@onready var loaded = $marble
@onready var backup = $backup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loaded.state = "loaded"
	backup.state = "backup"

func shoot():
	if can_shoot:
		can_shoot = false
		loaded.visible = false
		var m = marble.instantiate()
		m.color = loaded.color
		m.state = "flying"
		m.set_speed(1000 if not speedshot else 1500)
		m.finished.connect(reload)
		owner.add_child(m)
		snd_shoot.play()
		m.transform = loaded.global_transform

func swap():
	var tmpcolor = loaded.color
	loaded.set_color(backup.color)
	backup.set_color(tmpcolor)
	snd_swap.play()

func reload():
	loaded.set_color(backup.color)
	backup.set_color(backup.new_color())
	loaded.visible = true
	snd_reload.play()
	can_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
