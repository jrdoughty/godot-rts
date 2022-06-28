extends Node2D


var selected_units = []

func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)
	print("selected %s" % unit.name)
	
func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)
	print("deselected %s" % unit.name)
	
