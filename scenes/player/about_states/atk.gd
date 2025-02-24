extends StateBase

@export var res:EntityAttributes

func enter():
	super()
	an.animation_finished.connect(
		func(an_name:String):
			state_machine.change_state("Idle")
	)
	an.play("atk")
	

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	if owner.can_jump:
		state_machine.change_state("Jump")
	pass

func physical_process_update(delta: float) -> void:
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	move(delta)
	pass

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * res.attri.walk_speed*delta*100
	else:
		owner.velocity.x = 0
