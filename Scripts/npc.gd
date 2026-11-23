
extends Area2D

@onready var interaction_prompt: Label = $InteractionPrompt

var jugador_cerca: Player = null


func _ready():
	interaction_prompt.text = "[E]"
	interaction_prompt.hide()

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body is Player:
		jugador_cerca = body
		interaction_prompt.show()


func _on_body_exited(body):
	if body == jugador_cerca:
		jugador_cerca = null
		interaction_prompt.hide()
