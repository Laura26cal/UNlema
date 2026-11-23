extends CanvasLayer

const ANCHO_FILA := 102
const ALTO_FILA := 48            # 3 renglones de 16 px
const TAMANO_FUENTE := 8
const ESPACIO_LINEAS := 6        # sube o baja si el texto no cae sobre las líneas
const PISTAS_PAGINA_IZQ := 3     # las demás van a la página derecha
const COLOR_TEXTO := Color("3b2a2a")

@onready var pagina_izq: VBoxContainer = $Fondo/PaginaIzq
@onready var pagina_der: VBoxContainer = $Fondo/PaginaDer

func _ready() -> void:
	visible = false
	pagina_izq.add_theme_constant_override("separation", 0)
	pagina_der.add_theme_constant_override("separation", 0)
	Global.libreta_cambiada.connect(_redibujar)
	_redibujar()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("libreta"):
		visible = not visible
		Global.libreta_abierta = visible
		get_viewport().set_input_as_handled()

func _redibujar() -> void:
	for pagina in [pagina_izq, pagina_der]:
		for hijo in pagina.get_children():
			hijo.queue_free()
	for i in Global.MAX_PISTAS:
		var l := Label.new()
		l.custom_minimum_size = Vector2(ANCHO_FILA, ALTO_FILA)
		l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		l.clip_text = true
		l.add_theme_font_size_override("font_size", TAMANO_FUENTE)
		l.add_theme_constant_override("line_spacing", ESPACIO_LINEAS)
		l.add_theme_color_override("font_color", COLOR_TEXTO)
		if i < Global.pistas.size():
			l.text = "%d. %s" % [i + 1, Global.pistas[i]["texto"]]
		else:
			l.text = "%d. (vacío)" % [i + 1]
			l.modulate.a = 0.5
		var pagina := pagina_izq if i < PISTAS_PAGINA_IZQ else pagina_der
		pagina.add_child(l)

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() and event.keycode == KEY_P:
		Global.agregar_pista("test", "Misión de la empresa", 2)
