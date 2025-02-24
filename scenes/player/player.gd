extends CharacterBody2D

@onready var camera_2d: Camera2D = %Camera2D
@onready var camera_shake_noise:FastNoiseLite=FastNoiseLite.new()
@onready var handle_flip: Node2D = %HandleFlip
@onready var state_machine: StateMachine = $StateMachine


@export var res:EntityAttributes

var dir:float
var normal_dir:float
var jump_times:int=0
var is_slide:bool
var can_jump:bool

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	dir= Input.get_axis("move_left", "move_right")
	if dir !=0:
		normal_dir=dir
	handle_flip_x()



		
	move_and_slide()
	
	if is_on_floor():
		jump_times=0

		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT and event.is_pressed():
			#var t:Tween=get_tree().create_tween()
			#t.tween_method(start_camera_shake,5.0,1.0,0.5)
			pass
			
#处理相机抖动的函数
func start_camera_shake(intensity:float):
	var camera_offset=camera_shake_noise.get_noise_1d(Time.get_ticks_msec())*intensity
	camera_2d.offset.x=camera_offset
	camera_2d.offset.y=camera_offset

func move():
	if dir:
		velocity.x = dir* res.attri.walk_speed
	else:
		velocity.x = 0

func handle_flip_x():
	if is_equal_approx(dir,-1.0):
		handle_flip.scale.x=-abs(handle_flip.scale.x)
	elif is_equal_approx(dir,1.0):
		handle_flip.scale.x=abs(handle_flip.scale.x)
