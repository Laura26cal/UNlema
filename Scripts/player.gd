extends CharacterBody2D
class_name Player
@onready var spawn = get_parent().get_node("spawn")
@onready var anim = $AnimatedSprite2D

# Posición
var posicion_inicio: Vector2
var posicion_anterior: Vector2

# Movimiento
var speed := 120.0
var celda := 32
var se_mueve := false

# Dirección
var direccion_actual := Vector2.ZERO
var direccion_str := "abajo"

# Control
var bloqueado := false
var skin := "1"





func _ready():
	posicion_inicio = spawn.global_position
	
	
	
func actualizar_animacion():
	var nombre := ""
	if se_mueve:
		nombre = (
			skin
			+ "_caminar_"
			+ direccion_str
		)
	else:
		if direccion_str == "arriba":
			nombre = (
				skin
				+ "_quieto_arriba"
			)
		else:
			nombre = (
				skin
				+ "_quieto_abajo"
			)
	if anim.animation != nombre:
		anim.play(nombre)
		


func finalizar():
	se_mueve = false
	actualizar_animacion()
	
