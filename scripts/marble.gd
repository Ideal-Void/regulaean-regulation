extends Area2D

@onready var sprite: Sprite2D = $sprite
@export var color : String = "unset"
@export var state : String = "unset"
const colors : Array = ["red", "green", "blue", "cyan", "magenta", "yellow", "white"]
const states : Array = ["loaded", "backup", "flying", "rolling"]
var difficultymodifier = 0
var max = 3 + difficultymodifier
var speed: int
signal finished

func new_color():
	return colors[randi_range(0,max)]

func set_color(col):
	color = col
	sprite.texture = load("res://assets/sprites/marble_" + col + ".png")

func set_speed(shotspeed: int):
	speed = shotspeed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if color == "unset":
		color = new_color()
	set_color(color)

func _physics_process(delta):
	if state == "flying":
		position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	finished.emit()
