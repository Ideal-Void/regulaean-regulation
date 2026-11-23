extends Node2D

signal level_begin
signal level_end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_begin.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
