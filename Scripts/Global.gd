extends Node

signal sospecha_cambiada(valor)
signal descubierto
signal pista_agregada(pista)
signal libreta_cambiada

const MAX_PISTAS := 5

var nombre_jugador := ""
var personaje_elegido := ""  

var puntajes := {
	"datos_mision1": 0,   
	"hoja_vida": 0,
	"entrevista": 0,
}

var pistas: Array = [] # cada pista: {"id": "", "texto": "", "valor": 0}

var sospecha: int = 0:
	set(v):
		sospecha = clampi(v, 0, 100)
		sospecha_cambiada.emit(sospecha)
		if sospecha >= 100:
			descubierto.emit()

func subir_sospecha(cantidad: int) -> void:
	var c := float(cantidad)
	if personaje_elegido == "estratega" and cantidad > 0:
		c *= 1.1
	sospecha += roundi(c)

func zona_sospecha() -> String:
	if sospecha < 40: return "verde"
	if sospecha < 70: return "amarillo"
	if sospecha < 100: return "rojo"
	return "descubierto"

# Libreta
func agregar_pista(id: String, texto: String, valor: int = 0) -> bool:
	if pistas.size() >= MAX_PISTAS:
		return false   # llena: la libreta debe pedir reemplazo
	pistas.append({"id": id, "texto": texto, "valor": valor})
	pista_agregada.emit(pistas.back())
	libreta_cambiada.emit()
	return true

func reemplazar_pista(indice: int, id: String, texto: String, valor: int = 0) -> void:
	pistas[indice] = {"id": id, "texto": texto, "valor": valor}
	libreta_cambiada.emit()

# Puntajes
func bonus_mision1() -> int:
	var total := 0
	for p in pistas:
		total += p["valor"]
	if total >= 6: return 2
	if total >= 3: return 1
	return 0

func efecto_hoja_vida() -> int:
	var p: int = puntajes["hoja_vida"]
	if p >= 4: return 1
	if p >= 2: return 0
	return -1

func cerrar_entrevista() -> void:
	var total: int = puntajes["entrevista"] + bonus_mision1() + efecto_hoja_vida()
	sospecha = 0 if total >= 7 else 20
