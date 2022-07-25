extends State



func enter():
	unit.anim_player.play("death")
	unit.stop_timer.stop()
	unit.stop_timer.start()
	
func StopTimer_timeout():
	unit.remove_from_group("units")
	for c in unit.get_children():
		c.queue_free()
	unit.queue_free()
