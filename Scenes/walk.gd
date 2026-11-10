extends StateBase

func start():
	controlled_node.velocity = Vector2.ZERO
	controlled_node.se_mueve = false
	controlled_node.actualizar_animacion()

func on_physics_process(delta):
	var dir = Input.get_vector(
		"left",
		"right",
		"up",
		"down"
	)

	if dir == Vector2.ZERO:
		controlled_node.se_mueve = false
		state_machine.change_to("Idle")
		return

	controlled_node.se_mueve = true
	controlled_node.velocity = dir * controlled_node.speed
	controlled_node.move_and_slide()

	if abs(dir.x) > abs(dir.y):
		controlled_node.direccion_str = (
			"der" if dir.x > 0 else "izq"
		)
	else:
		controlled_node.direccion_str = (
			"abajo" if dir.y > 0 else "arriba"
		)

	controlled_node.actualizar_animacion()
