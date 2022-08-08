extends Transition


func _ready():
	pass

func get_transition(unit:Unit)->String:
	if unit.aggressive and unit.closest_enemy_in_range():
		unit.attack_target = unit.closest_enemy_in_range()
		return "AttackState"
	elif unit.aggressive and unit.possible_targets.size() > 0:
		unit.attack_target = unit.possible_targets[0]
		return "EngagingState"
	elif not unit.position.distance_to(unit.target_pos) > unit.target_max:	
		return "IdleState"
	return ""
