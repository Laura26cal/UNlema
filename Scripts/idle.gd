extends StateBase

var jugador: Player

func start():
	jugador = controlled_node as Player
	jugador.velocity = Vector2.ZERO
	jugador.se_mueve = false
	jugador.actualizar_animacion()

func on_physics_process(delta: float) -> void:
	var dir = Input.get_vector(
		"left",
		"right",
		"up",
		"down"
	)
	if dir != Vector2.ZERO:
		state_machine.change_to("Walk")
