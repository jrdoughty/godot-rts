extends Transition

func get_transition(unit:Unit)->String:
	if unit.possible_targets.size() > 0 :
		unit.attack_target = unit.closest_enemy();
		if unit.closest_enemy_in_range() != null:
			unit.attack_target = unit.closest_enemy_in_range()
			return "AttackState"
		else:
			unit.attack_target = unit.possible_targets[0]#its sorted from the closest Enemy in range
			return "EngagingState"		
	elif unit.position.distance_to(unit.target_pos) > unit.target_max:
		return "MoveState"
	return ""
