extends CanvasLayer

@onready var lista: VBoxContainer = $Fondo/Lista

func _ready() -> void:
	visible = false
	Global.libreta_cambiada.connect(_redibujar)
	_redibujar()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("libreta"):
		visible = not visible
		print("libreta visible: ", visible)
		get_viewport().set_input_as_handled()


func _redibujar() -> void:
	for hijo in lista.get_children():
		hijo.queue_free()
	for i in Global.MAX_PISTAS:
		var l := Label.new()
		if i < Global.pistas.size():
			l.text = "%d. %s" % [i + 1, Global.pistas[i]["texto"]]
		else:
			l.text = "%d. (vacío)" % [i + 1]
		lista.add_child(l)

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() and event.keycode == KEY_P:
		Global.agregar_pista("test", "Misión de la empresa", 2)
