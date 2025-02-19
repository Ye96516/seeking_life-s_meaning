extends StateBase

func enter():
	ans.play("idle")
	owner.velocity.y-=500

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	if owner.dir:
		state_machine.change_state("Run")
	if owner.is_on_floor():
		state_machine.change_state("Idle")
	pass

func physical_process_update(delta: float) -> void:
	move(delta)
	pass

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * owner.speed/3
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.speed)
