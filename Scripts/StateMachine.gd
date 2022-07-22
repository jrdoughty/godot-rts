extends Node
class_name StateMachine

onready var state
var prev_state = null
var states = []

onready var parent = get_parent()

func _ready():
	for s in get_children():
		if s is State:
			add_state(s)
	
	state = states[0]
	
func _physics_process(delta):
#	if state != null:
#		_state_logic(delta)
#		var transition = _get_transition(delta)
#		if transition != null:
#			set_state(transition)
	if state != null:
		state.state_logic(delta)
	pass
	

func _get_transition(delta):
	pass
	
func set_state(new_state):
	prev_state = state
	state = new_state
	if prev_state != null:
		_exit_state(prev_state)
	if new_state != null:
		_enter_state(new_state)
	pass

func _exit_state(prev):
	prev.exit()
	pass
	
func _enter_state(new_state):
	new_state.enter()
	pass
	
func add_state(state):
	states.append(state)	
func remove_state(state):
	states.remove(state)
	pass	


func _on_StopTimer_timeout():
	state.StopTimer_timeout()
