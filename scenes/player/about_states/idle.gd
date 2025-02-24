extends StateBase
"""这是idle脚本"""
@export var res:EntityAttributes

func enter():
	super()
	
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	##idle切换至Walk
	if owner.dir:
		state_machine.change_state("Walk")
	##idle切换至Atk
	if Input.is_action_just_pressed("atk"):
		state_machine.change_state("Atk")
	#idle切jump
	if Input.is_action_just_pressed("jump") and owner.jump_times<2:
		state_machine.change_state("Jump")
	pass

func physical_process_update(delta: float) -> void:
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	owner.velocity.x=move_toward(owner.velocity.x,0,delta)
	pass
