extends State



func enter():
	inProg = not unit.stop_timer.is_stopped()
	unit.anim_player.play("idle")
	
func state_logic(delta):
	pass

