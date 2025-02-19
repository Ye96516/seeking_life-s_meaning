extends Node2D

var s:SLSystem=SLSystem.new()
var PLAYER_RES = preload("res://scripts/res/player_res.tres")
var  BUFF_RES = preload("res://scripts/res/buff_res.tres")

func _ready() -> void:
	Global.buff(PLAYER_RES,BUFF_RES,["name","atk"])
	pass


func _process(delta: float) -> void:
	pass
