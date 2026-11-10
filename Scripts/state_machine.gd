class_name StateMachine extends Node

@onready var controlled_node = self.owner
@export var default_state:StateBase
var current_state = null

func _ready():
	call_deferred("_state_default_start")

func _state_default_start() -> void:
	current_state = default_state
	_state_start()

func _state_start() -> void:
	if current_state == null:
		push_error("StateMachine: current_state es NULL")
		return
	(current_state as StateBase).controlled_node = controlled_node
	(current_state as StateBase).state_machine = self
	(current_state as StateBase).start()

func change_to(new_state:String) -> void:
	if current_state and current_state.name == new_state:return
	if current_state and current_state.has_method("end"): current_state.end()
	current_state = get_node(new_state)
	_state_start()
	
	

func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)
	
	
func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)
	
	
func _input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)
		
		

func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)
		
		
func _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)
		
		
	
