extends Node
class_name State

var unit
var inProg:= false #is a wait in progress from before
onready var transition = $Transition


func set_selected(value):
	pass
	
func enter():
	inProg = not unit.stop_timer.is_stopped()
	pass
	
func exit():
	pass

func _ready():
	unit = get_parent().get_parent()
	pass
	
func get_transition(delta)->String:
	var trans = transition.get_transition(unit)
	return trans

func _update_sprite():
	pass


func state_logic(delta):
	pass


func _on_Unit_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func StopTimer_timeout():
	pass
