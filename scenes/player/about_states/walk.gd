extends StateBase
"""这是walk状态"""
@export var res:EntityAttributes

@onready var right_cast: RayCast2D = %RightCast
@onready var left_cast: RayCast2D = %LeftCast


func enter():
	super()
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	#walk切idle
	if not owner.dir:
		state_machine.change_state("Idle")
	#walk切atk
	if Input.is_action_just_pressed("atk"):
		state_machine.change_state("Atk")
	#walk切jump
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	#walk切slide
	if not owner.is_on_floor() :
		if left_cast.is_colliding() and is_equal_approx(owner.dir,-1.0):
			var collider:=left_cast.get_collider()
			state_machine.change_state("LeftWallClimb")
		if right_cast.is_colliding() and is_equal_approx(owner.dir,1.0):
			var collider:=right_cast.get_collider()
			state_machine.change_state("RightWallClimb")
	pass

func physical_process_update(delta: float) -> void:
	if not owner.is_on_floor():
		owner.velocity.y += owner.get_gravity().y * delta
	move(delta)

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * res.attri.walk_speed*delta*100
	else:
		owner.velocity.x = 0
