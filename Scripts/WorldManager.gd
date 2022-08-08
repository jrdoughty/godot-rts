extends Node2D

onready var button = preload("res://Scenes/UnitButton.tscn")

var selected_units = []

var buttons = []
var units = []

var enums:Enumerations

func _ready():
	var tree = get_tree()
	units = tree.get_nodes_in_group("units")
	enums = get_node("/root/Enums")

func select_unit(unit):
	if is_instance_valid(unit) and not selected_units.has(unit):
		selected_units.append(unit)
	create_buttons()

func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)
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
	for btn in buttons:
			if $"UI/Base".has_node(btn):
				var b = $"UI/Base".get_node(btn)
				b.queue_free()
				$"UI/Base".remove_child(b)
	buttons.clear()

func was_pressed(obj):
	for unit in selected_units:
		if is_instance_valid(unit) and unit.name == obj.name:
			unit.set_selected(false)

func right_clicked(obj):
	for unit in selected_units:
		if enums.command_mod == enums.CommandsMods.NONE:
			unit.move_cmd(obj.mouse_pos_global, false)
		elif enums.command_mod == enums.CommandsMods.ATTACK_MOVE:
			unit.move_cmd(obj.mouse_pos_global, true)
		clear_commands()
func clear_commands():
	enums.command_mod = enums.CommandsMods.NONE
	#enums.command = enums.Commands.NONE
func attack_pressed(obj):
	enums.command_mod = enums.CommandsMods.ATTACK_MOVE
func stop_pressed(obj):
	#enums.command = enums.Commands.HOLD#stop will come later
	for unit in selected_units:
		unit.stop_cmd()
func hold_pressed(obj):
	#enums.command = enums.Commands.HOLD
	for unit in selected_units:
		unit.stop_cmd()

func area_selected(obj):
	var start = obj.start
	var end = obj.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
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
