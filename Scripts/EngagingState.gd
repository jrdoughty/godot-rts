extends State


func _update_sprite():
	if unit.velocity.x != 0:
		unit.sprite.flip_h = unit.velocity.x < 0
	if unit.velocity != Vector2.ZERO and unit.anim_player.current_animation != "walk": 
		unit.anim_player.play("walk")
	elif unit.velocity.abs().x + unit.velocity.abs().y == 1 and unit.anim_player.current_animation == "walk":
		unit.anim_player.play("idle")

func state_logic(delta):
	
	if is_instance_valid(unit.attack_target) and not unit.attack_target == null:
		if unit.position.distance_to(unit.attack_target.position) > unit.attack_range:
			unit.move_to_target(delta, unit.attack_target.position)
			_update_sprite()
		else:
			get_parent().change_state_via_name("AttackState")
	else:
		get_parent().change_state_via_name("IdleState")
func get_transition(delta):
	if is_instance_valid(unit.attack_target) and not unit.attack_target == null:
		if not unit.position.distance_to(unit.attack_target.position) > unit.attack_range:
			get_parent().change_state_via_name("AttackState")
	else:
		get_parent().change_state_via_name("IdleState")

func StopTimer_timeout():
	if unit.get_slide_count():
		var last = unit.last_position.distance_to(unit.target_pos)
		var curpos = unit.position
		var current = unit.position.distance_to(unit.target_pos)
		if last < current + unit.move_threshold:
			unit.target_pos = unit.position
			if unit.anim_player.current_animation == "walk":
				unit.anim_player.play("idle")
			get_parent().change_state_via_name("IdleState")
			unit.target_pos = unit.position
