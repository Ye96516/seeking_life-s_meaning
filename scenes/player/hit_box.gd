extends Area2D



func _on_body_entered(body: Node2D) -> void:
	print(body.res.attri)
	
	owner.velocity.y+=- body.res.attri["recoil_force"]
