extends StateBase

@export var res:EntityAttributes
var is_second_frame:bool=false
var is_left:bool

@onready var right_cast: RayCast2D = %RightCast
@onready var left_cast: RayCast2D = %LeftCast

func enter():
	super()
	if state_machine.last_state.name=="Slide":
		if is_left:
			owner.velocity=owner.res.attri.jump_speed+Vector2(owner.res.attri.jump_speed,0)
		else:
			owner.velocity=owner.res.attri.jump_speed+Vector2(-owner.res.attri.jump_speed,0)
	else:
		owner.velocity.y=owner.res.attri.jump_speed
		owner.jump_times+=1
		print(owner.jump_times)

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	#jump切slide
	if not owner.is_on_floor():
		if left_cast.is_colliding():
			var collider:=left_cast.get_collider()
			state_machine.change_state("Slide")
		if right_cast.is_colliding():
			var collider:=right_cast.get_collider()
			state_machine.change_state("Slide")
	pass

func physical_process_update(delta: float) -> void:
	#jump切idle
	if is_second_frame:
		if owner.is_on_floor():
			state_machine.change_state("Idle")
	is_second_frame=true
	
	#处理长短跳
	if Input.is_action_just_released("jump"):
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
		owner.velocity += owner.get_gravity() * delta


func _on_slide_to_jump(left: bool) -> void:
	is_left=left
	pass # Replace with function body.
