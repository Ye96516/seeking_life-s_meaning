extends Panel

@onready var h_slider: HSlider = %HSlider

func _ready() -> void:
	h_slider.value=AudioPlayer.get_volume(0)

func _on_h_slider_value_changed(value: float) -> void:
	AudioPlayer.set_volume(0,value)

func _on_back_pressed() -> void:
	self.visible=false
