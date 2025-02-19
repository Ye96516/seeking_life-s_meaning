extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var camera_2d: Camera2D = %Camera2D
@onready var camera_shake_noise:FastNoiseLite=FastNoiseLite.new()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	print(camera_shake_noise.get_noise_1d(Time.get_ticks_msec()))
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT and event.is_pressed():
			var t:Tween=get_tree().create_tween()
			t.tween_method(start_camera_shake,5.0,1.0,0.5)

#处理相机抖动的函数
func start_camera_shake(intensity:float):
	var camera_offset=camera_shake_noise.get_noise_1d(Time.get_ticks_msec())*intensity
	camera_2d.offset.x=camera_offset
	camera_2d.offset.y=camera_offset
