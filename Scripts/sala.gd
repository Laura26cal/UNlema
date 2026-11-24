extends Node2D

func _ready() -> void:
	if get_tree().has_meta("punto_entrada"):
		var nombre_punto: String = get_tree().get_meta("punto_entrada")
		get_tree().remove_meta("punto_entrada")
		var marcador = find_child(nombre_punto, true, false)
		if marcador and has_node("Player"):
			$Player.global_position = marcador.global_position
