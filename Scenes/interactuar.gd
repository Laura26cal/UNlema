extends StateBase

func start():
	controlled_node.velocity = Vector2.ZERO

func on_physics_process(delta):
	controlled_node.velocity = Vector2.ZERO
