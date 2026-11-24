extends Node

var speed = Game.difficulty_modifier * 20 + 200
var spacing = 64
var slowdown_threshold : float = Game.difficulty_modifier + 4.0
var speedup = 0.0
@onready var marble : PackedScene = preload("res://scenes/marble.tscn")
@onready var chain : Array[PathFollow2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.level_end.connect(_on_level_end)
	for i in range(randi_range(Game.difficulty_modifier*10+20,Game.difficulty_modifier*10+30)):
		var newmarb := PathFollow2D.new()
		var minimarb := marble.instantiate()
		newmarb.loop = false
		minimarb.state = "rolling"
		minimarb.chain_index = i
		newmarb.add_child(minimarb)
		add_child(newmarb)
		chain.append(newmarb)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if chain.is_empty():
		return
	if chain[0].progress_ratio == 1.0 and not Game.loss:
		Game.level_end.emit("loss")
	if Game.loss:
		speedup += 0.01
		chain[0].progress += (speed * delta) * (slowdown_threshold * speedup)
		_sync_chain()
		if chain[0].progress_ratio == 1.0:
			chain.pop_front().queue_free()
	else:
		var ratio_from_end: float = 1.0 - chain[0].progress_ratio
		if chain[0].progress_ratio > (slowdown_threshold - 1.0) / slowdown_threshold:
			chain[0].progress += (speed * delta) * (ratio_from_end * slowdown_threshold) + 0.1
		else:
			chain[0].progress += (speed * delta)
		_sync_chain()

func _sync_chain() -> void:
	var lead_progress := chain[0].progress
	for marb in range(1, chain.size()):
		chain[marb].progress = lead_progress - spacing * marb

func _on_level_end(type : String):
	if type == "loss":
		Game.loss = true
