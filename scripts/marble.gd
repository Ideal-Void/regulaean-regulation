extends Area2D
class_name Marble

@onready var sprite: Sprite2D = $sprite
@export var color : String = "unset"
@export var state : String = "unset"
const colors : Array = ["red", "green", "blue", "cyan", "magenta", "yellow", "white", "black"]
const states : Array = ["loaded", "backup", "flying", "rolling"]
var max_colors = 3 + Game.difficulty_modifier
var speed: int
var chain_index = -1
signal finished
signal entering_chain

func new_color():
	return colors[randi_range(0,max_colors)]

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_entered(body: Area2D) -> void:
	if body is Marble:
		if body.state == "rolling" and state == "flying":
			print("Hit!")
			entering_chain.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	finished.emit()
