extends StateBase

func enter():
	ans.play("run")

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	if not owner.dir:
		state_machine.change_state("Idle")
	if Input.is_action_just_pressed("atk"):
		state_machine.change_state("Atk")
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("Jump")
	pass

func physical_process_update(delta: float) -> void:
	move(delta)

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * owner.speed
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.speed)
