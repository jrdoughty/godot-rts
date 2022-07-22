extends Button

signal was_pressed

func _pressed():
	emit_signal("was_pressed")

func connect_me(obj, unit_name):
	connect("was_pressed", obj, "was_pressed", [self])
	name = unit_name
	$label.text = name
