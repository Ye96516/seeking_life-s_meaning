extends StateBase
"""这是LeftSlide状态"""
@onready var left_cast: RayCast2D = %LeftCast

@export var res:EntityAttributes

var frames:int=0

func enter():
	super()
	frames=0
	owner.jump_times=0
	owner.is_slide=true

func exit() -> void:
	frames=0
	owner.is_slide=false

func process_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	if owner.is_on_floor():
		state_machine.change_state("Idle")

func physical_process_update(delta: float) -> void:
	frames+=1
	if frames==3:
		owner.velocity.y=0
		
	if not left_cast.is_colliding():
	
		state_machine.change_state("Idle")
	move(delta)

func move(delta:float):
	if not owner.is_on_floor():
		owner.velocity.y += owner.get_gravity().y/2 * delta
