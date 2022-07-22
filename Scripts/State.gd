extends Node
class_name State


var unit

func set_selected(value):
	pass
func enter():
	pass
func exit():
	pass

func _ready():
	unit = get_parent().get_parent()
	pass
		

func _update_sprite():
	if unit.velocity.x != 0:
		unit.sprite.flip_h = unit.velocity.x < 0
	if unit.velocity != Vector2.ZERO and unit.anim_player.current_animation != "walk": 
		unit.anim_player.play("walk")
	elif unit.velocity.abs().x + unit.velocity.abs().y == 1 and unit.anim_player.current_animation == "walk":
		unit.anim_player.play("idle")
	pass


func state_logic(delta):
	unit.velocity = Vector2.ZERO
	if unit.position.distance_to(unit.target_pos) > unit.target_max:
		unit.velocity = unit.position.direction_to(unit.target_pos) * unit.speed
		if unit.get_slide_count() and unit.stop_timer.is_stopped():
			unit.stop_timer.start()
			unit.last_position = unit.position
		unit.velocity = unit.move_and_slide(unit.velocity)
		_update_sprite()
	pass


func _on_Unit_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func StopTimer_timeout():
	if unit.get_slide_count():
		var last = unit.last_position.distance_to(unit.target_pos)
		var curpos = unit.position
		var current = unit.position.distance_to(unit.target_pos)
		if last < current + unit.move_threshold:
			unit.target_pos = unit.position
			if unit.anim_player.current_animation == "walk":
				unit.anim_player.play("idle")
	pass
