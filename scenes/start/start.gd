extends Control

func _ready() -> void:
	$Setting/Setting.visible=false

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test/test.tscn")

func _on_setting_pressed() -> void:
	$Setting/Setting.visible=true

func _on_exit_pressed() -> void:
	get_tree().quit()
