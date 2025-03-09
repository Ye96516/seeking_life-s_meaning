extends StateBase

@export var res:EntityAttributes

func enter():
	super()
	an.animation_finished.connect(
		func(an_name:String):
			state_machine.change_state("Idle")
	)
	if is_equal_approx(owner.up_down_dir,-1):
		an.play("down_atk")
	elif is_equal_approx(owner.up_down_dir,1):
		an.play("up_atk")
	else:
		an.play("atk")
	

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	pass

func physical_process_update(delta: float) -> void:
	if not owner.is_on_floor():
		owner.velocity.y += owner.get_gravity().y * delta
	move(delta)
	pass

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * res.attri.walk_speed*delta*100
	else:
		owner.velocity.x = 0
