
extends AnimationPlayer

@onready var animation_player: AnimationPlayer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#self.add_animation_library(&"aa",AnimationLibrary.new())
	print("dangq",self.get_instance_id()
)
	print(animation_player.get_instance_id()
)
	#print(self.get_animation_library(&"aa"),"aa")
	#print(self.get_animation_library_list())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
