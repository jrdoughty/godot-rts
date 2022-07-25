extends Transition


func _ready():
	pass

func get_transition(unit)->String:
	if not unit.position.distance_to(unit.target_pos) > unit.target_max:	
		return "IdleState"
	return ""
