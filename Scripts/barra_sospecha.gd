extends CanvasLayer

@onready var barra: TextureProgressBar = $Barra

func _ready() -> void:
	barra.max_value = 100
	barra.value = Global.sospecha
	Global.sospecha_cambiada.connect(_on_sospecha_cambiada)

func _on_sospecha_cambiada(valor: int) -> void:
	barra.value = valor

# SOLO PARA PROBAR: borra esto después
func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() and event.keycode == KEY_O:
		Global.subir_sospecha(10)
