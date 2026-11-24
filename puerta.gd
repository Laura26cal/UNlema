extends Area2D

@export_file("*.tscn") var escena_destino: String
@export var punto_entrada_destino: String = ""

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		if escena_destino != "":
			get_tree().set_meta("punto_entrada", punto_entrada_destino)
			get_tree().change_scene_to_file(escena_destino)
