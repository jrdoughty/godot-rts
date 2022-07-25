extends Node2D

onready var button = preload("res://Scenes/UnitButton.tscn")

var selected_units = []

var buttons = []
var units = []

func _ready():
	var tree = get_tree()
	units = tree.get_nodes_in_group("units")
	pass

func select_unit(unit):
	if is_instance_valid(unit) and not selected_units.has(unit):
		selected_units.append(unit)
	print("selected %s" % unit.name)
	create_buttons()
	
func deselect_unit(unit):
	if is_instance_valid(unit):
		if selected_units.has(unit) or not is_instance_valid(unit):
			selected_units.erase(unit)
		print("deselected %s" % unit.name)
	create_buttons()
	
func create_buttons():
	delete_buttons()
	for unit in selected_units:
		if is_instance_valid(unit) and not buttons.has(unit.name):
			var but = button.instance()
			but.connect_me(self, unit.name)
			but.rect_position = Vector2(buttons.size() * 60 +32,540)
			$"UI/Base".add_child(but)
			buttons.append(but.name)

func delete_buttons():
	for button in buttons:
			if $"UI/Base".has_node(button):
				var b = $"UI/Base".get_node(button)
				b.queue_free()
				$"UI/Base".remove_child(b)
	buttons.clear()
func was_pressed(obj):
	for unit in selected_units:
		if is_instance_valid(unit) and unit.name == obj.name:
			unit.set_selected(false)
func right_clicked(obj):
	for unit in selected_units:
		if is_instance_valid(unit):
			unit.target_pos = obj.mouse_pos
	
func area_selected(obj):
	var start = obj.startv
	var end = obj.endv
	var area = [Vector2(min(start.x, end.x),min(start.y, end.y)),
	Vector2(max(start.x, end.x),max(start.y, end.y))]
	var ut = get_units_in_area(area)
	if not Input.is_key_pressed(KEY_SHIFT):
		deselect_all()
	for u in ut:
		u.set_selected(true)
		
func get_units_in_area(area):
	var u = []
	for unit in units:
		if is_instance_valid(unit) and unit.position.x > area[0].x and unit.position.y > area[0].y and unit.position.x < area[1].x and unit.position.y < area[1].y  and unit.unit_owner == 0:
			u.append(unit)			
	return u
func deselect_all():
	while selected_units.size() > 0:
		selected_units[0].set_selected(false)
