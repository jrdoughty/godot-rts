extends KinematicBody2D
class_name Unit


# Declare member variables here. Examples:
export var selected = false setget set_selected

onready var box = $box
onready var name_label = $name
onready var health_bar = $health
onready var stop_timer = $StopTimer
onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer

export var target_pos := Vector2.ZERO
export var unit_owner := 0 #team number

var last_position := Vector2.ZERO
var velocity := Vector2.ZERO
var target_max := 3
var speed := 60
var move_threshold := .5

signal was_selected
signal was_deselected

var enemy_material := load("res://Assets/enemy_unit_material.tres")
var player_material := load("res://Assets/player_unit_material.tres")
var neutral_material := load("res://Assets/neutral_unit_material.tres")
var ally_material := load("res://Assets/ally_unit_material.tres")


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
	health_bar.value = 100
	name_label.visible = false
	name_label.text = name;
	connect("was_selected", get_parent().get_parent(), "select_unit")
	connect("was_deselected", get_parent().get_parent(), "deselect_unit")
	add_to_group("units")
	target_pos = position
	if unit_owner == 0:
		material = player_material
	elif unit_owner == -1:
		material = neutral_material
	elif unit_owner == 1:
		material = enemy_material
	elif unit_owner == 2:
		material = ally_material
		

func _process(delta):
	pass

func _physics_process(delta):
	pass


func _on_Unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT  and unit_owner == 0:
				set_selected(true)
			#if event.button_index == BUTTON_RIGHT:
			#	set_selected(false)
	pass # Replace with function body.


