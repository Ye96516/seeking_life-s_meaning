
extends Node2D

const A_LEVEL_1 = preload("res://scenes/levels/a_level_1.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tile_map_layer: TileMapLayer = $TileMapLayer


func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
