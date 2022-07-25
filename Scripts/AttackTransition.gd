extends Transition

func get_transition(unit)->String:
	if(is_instance_valid(unit.attack_target) and unit.position.distance_to(unit.attack_target.position) > unit.attack_range):
		return "EngagingState"
	elif not unit.attack_target:
		return "IdleState"
	return ""
