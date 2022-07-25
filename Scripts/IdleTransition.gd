extends Transition

func get_transition(unit)->String:
	if unit.possible_targets.size() > 0 :
		unit.attack_target = unit.closest_enemy();
		if(unit.position.distance_to(unit.attack_target.position) < unit.attack_range):
			return "AttackState"
		else:
			return "EngagingState"		
	elif unit.position.distance_to(unit.target_pos) > unit.target_max:
		return "MoveState"
	return ""
