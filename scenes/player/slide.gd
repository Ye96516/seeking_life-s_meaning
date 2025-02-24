extends StateBase

@onready var right_cast: RayCast2D = %RightCast
@onready var left_cast: RayCast2D = %LeftCast

@export var res:EntityAttributes

var is_left:bool

signal to_jump(left:bool)

func enter():
	super()
	owner.is_slide=true
	pass

func exit() -> void:
	owner.is_slide=false
	is_left=false
	pass

func process_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	if owner.is_on_floor():
		state_machine.change_state("Idle")
	pass

func physical_process_update(delta: float) -> void:
	if not right_cast.is_colliding() && not is_left:
		state_machine.change_state("Idle")
	if not left_cast.is_colliding() and is_left:
		state_machine.change_state("Idle")
	move(delta)
	pass

func move(delta:float):
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity()/2 * delta
	pass
