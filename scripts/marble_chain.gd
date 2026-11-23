extends Node

@export var speed = 200
@export var spacing = 64
@onready var marble : PackedScene = preload("res://scenes/marble.tscn")
@onready var chain : Array[PathFollow2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(randi_range(10,30)):
		var newmarb := PathFollow2D.new()
		var minimarb := marble.instantiate()
		newmarb.loop = false
		minimarb.state = "rolling"
		newmarb.add_child(minimarb)
		add_child(newmarb)
		chain.append(newmarb)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if chain.is_empty():
		return
	chain[0].progress += speed * delta
	_sync_chain()

func _sync_chain() -> void:
	var lead_progress := chain[0].progress
	for marb in range(1, chain.size()):
		chain[marb].progress = lead_progress - spacing * marb
