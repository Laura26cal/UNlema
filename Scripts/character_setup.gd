extends Control

# Información de los personajes
const CHARACTERS = {
	"creative": {
		"name": "El creativo",
		"image": "res://Assets/Characters/Creative.jpg"
	},
	
	"strategist": {
		"name": "El estratega",
		"image": "res://icon.svg"
	}
}

# Referencia a los nodos
@onready var character_name: Label = $CenterContainer/VBoxContainer/CharacterName

@onready var character_preview: TextureRect = $CenterContainer/VBoxContainer/CharacterPreview

@onready var name_input = $CenterContainer/VBoxContainer/NameInput

# Called when the node enters the scene tree for the first time.
func _ready():
	update_character_info()


func update_character_info():
	var character = CHARACTERS.get(Global.personaje_elegido, {})
	
	if character.is_empty():
		push_error("No se encontró información del personaje seleccionado.")
		return
	
	character_name.text = character["name"]
	
	character_preview.texture = load(character["image"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_continue_button_pressed():
	var entered_name = name_input.text.strip_edges()

	if entered_name.is_empty():
		print("Por favor, escribe tu nombre.")
		return

	Global.nombre_jugador = entered_name
	print("Nombre del jugador: ", Global.nombre_jugador)
	get_tree().change_scene_to_file("res://Scenes/intro_screen.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/character_select.tscn")
