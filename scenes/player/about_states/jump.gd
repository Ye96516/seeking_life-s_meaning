extends StateBase

@export var res:EntityAttributes
var is_second_frame:bool=false

@onready var right_cast: RayCast2D = %RightCast
@onready var left_cast: RayCast2D = %LeftCast
var is_wall_jump:bool

func enter():
	super()
	is_second_frame=false
	#print("打印上一状态名称",state_machine.last_state.name)
	match state_machine.last_state.name:
		"LeftWallClimb":
			#print("自LeftSlide而来")
			is_wall_jump=true
			owner.velocity=Vector2(-owner.res.attri.jump_speed*15,owner.res.attri.jump_speed)
		"RightWallClimb":
			#print("自RightSlide而来")
			is_wall_jump=true
			owner.velocity=Vector2(owner.res.attri.jump_speed*15,owner.res.attri.jump_speed)
		_:
			#print("非爬墙")
			#owner.velocity=Vector2(owner.res.attri.jump_speed,owner.res.attri.jump_speed)
			owner.velocity.y=owner.res.attri.jump_speed
	owner.jump_times+=1

	#print(owner.jump_times)

func exit() -> void:
	is_second_frame=false
	is_wall_jump=false
	#owner.velocity.y=owner.res.attri.jump_speed/7
	pass

func process_update(_delta: float) -> void:
	#jump切jump
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	#jump切slide
	if not owner.is_on_floor() and is_second_frame :
		if left_cast.is_colliding() and is_equal_approx(owner.dir,-1.0):
			#var collider:=left_cast.get_collider()
			state_machine.change_state("LeftWallClimb")
		if right_cast.is_colliding() and is_equal_approx(owner.dir,1.0):
			#var collider:=right_cast.get_collider()
			state_machine.change_state("RightWallClimb")
	is_second_frame=true
	#jump切atk
	if Input.is_action_just_pressed("atk"):
		state_machine.change_state("Atk")
	pass

func physical_process_update(delta: float) -> void:
	#jump切idle
	if owner.is_on_floor():
		state_machine.change_state("Idle")

	
	#处理长短跳
	if Input.is_action_just_released("jump") and not is_wall_jump:
		if owner.velocity.y<owner.res.attri.jump_speed/2:
			owner.velocity.y=owner.res.attri.jump_speed/2
	move(delta)
	pass

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * res.attri.walk_speed*delta*100
	else:
		owner.velocity.x =0
	if not owner.is_on_floor():
		owner.velocity.y += owner.get_gravity().y * delta
