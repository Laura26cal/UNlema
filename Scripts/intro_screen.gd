extends Control


@onready var terminal_panel = $MarginContainer/HBoxContainer/TerminalPanel
@onready var welcome_label = $MarginContainer/HBoxContainer/CenterPanel/WelcomeLabel

# Control del efecto de escritura
var typing_tween: Tween
var is_typing: bool = false

# Control de la narración
var dialogue_started: bool = false
var current_page: int = 0

# Párrafos de la misión
var dialogue_pages: Array[String] = [
	"Bienvenido, Agente {nombre}. Su nueva misión consiste en infiltrarse en Vertex Solutions.",

	"Fundada hace menos de un año, Vertex Solutions prometía revolucionar la sociedad mediante el uso de inteligencia artificial. Sin embargo, hace tres semanas protagonizó una grave filtración: los datos personales de todos sus usuarios quedaron expuestos al público.",

	"Su objetivo es descubrir cómo ocurrió la filtración y determinar si algún miembro de la empresa vendió deliberadamente la información.",

	"Para completar la primera fase de su infiltración, deberá superar tres pruebas: revisión de hoja de vida, entrevista de selección y evaluación de acoplamiento."
]


func _ready():
	# Mostrar el nombre del agente
	welcome_label.text = "AGENTE: " + Global.nombre_jugador.to_upper()

	terminal_panel.bbcode_enabled = true

	# Secuencia inicial de conexión
	terminal_panel.text = """

[color=#65FF65]> INITIALIZING SECURE CONNECTION...[/color]
[color=#65FF65]> VERIFYING USER CREDENTIALS... [OK][/color]
[color=#65FF65]> ESTABLISHING ENCRYPTED CHANNEL... [OK][/color]
[color=#65FF65]> LOADING CLASSIFIED DATABASE...[/color]
[color=#65FF65]> ACCESS GRANTED.[/color]

[color=#65FF65]SYSTEM READY.[/color]
"""

	terminal_panel.visible_characters = 0

	# Esperar antes de comenzar la animación
	await get_tree().create_timer(0.5).timeout

	# Animar la secuencia inicial
	is_typing = true
	typing_tween = create_tween()

	typing_tween.tween_property(
		terminal_panel,
		"visible_characters",
		terminal_panel.get_total_character_count(),
		6.0
	)
	
	await typing_tween.finished
	is_typing = false

	# Esperar a que el jugador decida continuar
	terminal_panel.text += "\n\n[color=#65FF65]> PRESS SPACE TO CONTINUE...[/color]"
	terminal_panel.visible_characters = -1

	await get_tree().create_timer(0.3).timeout
	
	await _wait_for_space()

	# Iniciar la narración
	dialogue_started = true
	_show_dialogue_page()


# Mostrar el párrafo correspondiente
func _show_dialogue_page():

	if current_page >= dialogue_pages.size():
		_finish_dialogue()
		return

	var page_text = dialogue_pages[current_page]

	# Sustituir el nombre del agente
	page_text = page_text.replace("{nombre}", Global.nombre_jugador)

	terminal_panel.text = "[color=#65FF65]> " + page_text + "[/color]"

	terminal_panel.visible_characters = 0

	# Calcular duración según la cantidad de caracteres
	var character_count = terminal_panel.get_total_character_count()
	var typing_duration = maxf(1.0, character_count * 0.025)

	# Crear animación
	is_typing = true
	typing_tween = create_tween()

	typing_tween.tween_property(
		terminal_panel,
		"visible_characters",
		character_count,
		typing_duration
	)

	typing_tween.finished.connect(_on_typing_finished)


# Se ejecuta cuando termina de escribirse un párrafo
func _on_typing_finished():
	is_typing = false


# Controlar el avance mediante el teclado
func _unhandled_input(event):

	if not dialogue_started:
		return

	if event is InputEventKey and event.is_action_pressed("ui_accept") and not event.is_echo():

		# Si el texto sigue escribiéndose, mostrarlo completo
		if is_typing:
			typing_tween.kill()
			terminal_panel.visible_characters = -1
			is_typing = false

		# Si ya terminó, avanzar al siguiente párrafo
		else:
			current_page += 1
			_show_dialogue_page()


# Finalizar la narración
func _finish_dialogue():

	dialogue_started = false

	terminal_panel.text = """

[color=#65FF65]> MISSION BRIEFING COMPLETE.[/color]

[color=#65FF65]> AWAITING AGENT INSTRUCTIONS...[/color]
"""
	terminal_panel.visible_characters = -1

	print("Introducción finalizada.")

func _wait_for_space():
	while true:
		await get_tree().process_frame

		if Input.is_action_just_pressed("ui_accept"):
			break
