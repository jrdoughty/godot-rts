extends KinematicBody2D


# Declare member variables here. Examples:
export var selected = false setget set_selected
onready var box = $box
onready var name_label = $name
onready var health_bar = $health

signal was_selected
signal was_deselected

func set_selected(value):
	if selected != value:
		selected = value
		box.visible = value
		health_bar.visible = value
		name_label.visible = value
		if selected:
			emit_signal("was_selected", self)
		else:
			emit_signal("was_deselected", self)

func _ready():
	box.visible = false
	health_bar.visible = false
	name_label.visible = false
	name_label.text = name;
	connect("was_selected", get_parent(), "select_unit")
	connect("was_deselected", get_parent(), "deselect_unit")
	pass # Replace with function body.


func _process(delta):
	pass


func _on_Unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				set_selected(true)
			if event.button_index == BUTTON_RIGHT:
				set_selected(false)
	pass # Replace with function body.
