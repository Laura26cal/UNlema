
extends Node2D

@onready var dialogue_panel = $DialogueLayer/DialogueUI/DialoguePanel
@onready var name_label = $DialogueLayer/DialogueUI/DialoguePanel/MarginContainer/VBoxContainer/NameLabel
@onready var dialogue_text = $DialogueLayer/DialogueUI/DialoguePanel/MarginContainer/VBoxContainer/DialogueText
@onready var continue_label = $DialogueLayer/DialogueUI/DialoguePanel/MarginContainer/VBoxContainer/ContinueLabel

var dialogue_active := false
var dialogue_index := 0

var current_npc = null

var dialogue_lines = [
	"Bienvenido a Vertex Solutions.",
	"La empresa cuenta actualmente con una oportunidad laboral disponible.",
]


func _ready():
	dialogue_panel.hide()

	$NPC.iniciar_conversacion.connect(_on_npc_iniciar_conversacion)


func _on_npc_iniciar_conversacion(npc):

	if dialogue_active:
		return

	current_npc = npc
	dialogue_active = true
	dialogue_index = 0

	name_label.text = "REPRESENTANTE DE VERTEX"
	continue_label.text = "Presiona E para continuar"

	dialogue_panel.show()

	mostrar_dialogo()


func mostrar_dialogo():
	dialogue_text.text = dialogue_lines[dialogue_index]


func avanzar_dialogo():
	

	if dialogue_index < dialogue_lines.size():
		mostrar_dialogo()
		dialogue_index += 1
	else:
		finalizar_dialogo()


func finalizar_dialogo():
	dialogue_active = false
	dialogue_panel.hide()
	current_npc = null


func _unhandled_input(event):
	if event.is_action_pressed("interact") and dialogue_active:
		avanzar_dialogo()
