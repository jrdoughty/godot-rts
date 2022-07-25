extends Transition

func get_transition(unit)->String:
	if is_instance_valid(unit.attack_target) and not unit.attack_target == null:
		if not unit.position.distance_to(unit.attack_target.position) > unit.attack_range:
			return "AttackState"
	else:
		return "IdleState"
	return ""
