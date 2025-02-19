extends StateBase

func enter():
	ans.animation_finished.connect(func():
		state_machine.change_state("Idle")
		)
	ans.play("atk")

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("Jump")
	pass

func physical_process_update(_delta: float) -> void:
	pass

func move(delta:float):
	if owner.dir:
		owner.velocity.x = owner.dir * owner.speed/3
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.speed)
