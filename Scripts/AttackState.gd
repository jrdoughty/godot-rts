extends State


func enter():
	inProg = not unit.stop_timer.is_stopped()
	if not inProg and is_instance_valid(unit.attack_target) and not unit.attack_target == null:
		unit.stop_timer.start()
		unit.attack_enemy(unit.attack_target)
	

func _update_sprite():
	if unit.velocity.x != 0 and is_instance_valid(unit.attack_target) and not unit.attack_target == null:
		unit.sprite.flip_h = unit.position.x > unit.attack_target.position.x
func state_logic(delta):
	_update_sprite()
func exit():
	unit.stop_timer.stop()
func StopTimer_timeout():
	if inProg == false and is_instance_valid(unit.attack_target) and not unit.attack_target == null:
		if(unit.position.distance_to(unit.attack_target.position) <= unit.attack_range):
			unit.attack_enemy(unit.attack_target)
	unit.stop_timer.start()
	inProg = false

