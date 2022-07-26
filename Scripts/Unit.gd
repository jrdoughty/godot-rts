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
onready var collider = $CollisionShape2D
onready var state_machine = $StateMachine
onready var vision = $Vision
onready var vision_collider = $Vision/CollisionShape2D

export var target_pos := Vector2.ZERO
var attack_target = null
export var unit_owner := 0 #team number

var last_position := Vector2.ZERO
var velocity := Vector2.ZERO
var target_max := 3
var attack_range := 16
var speed := 60
var move_threshold := 2

signal was_selected
signal was_deselected

var enemy_material := load("res://Assets/enemy_unit_material.tres")
var player_material := load("res://Assets/player_unit_material.tres")
var neutral_material := load("res://Assets/neutral_unit_material.tres")
var ally_material := load("res://Assets/ally_unit_material.tres")

var possible_targets = []
export var health = 20
export var damage = 3


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
	health_bar.value = health
	health_bar.max_value = health
	name_label.visible = false
	name_label.text = name;
	connect("was_selected", get_parent().get_parent(), "select_unit")
	connect("was_deselected", get_parent().get_parent(), "deselect_unit")
	add_to_group("units")
	target_pos = position
	if unit_owner == 0:
		material = ally_material
	elif unit_owner == -1:
		material = neutral_material
	elif unit_owner == 1:
		material = enemy_material
	elif unit_owner == 2:
		material = player_material

func move_to_target(delta, tar):
	velocity = Vector2.ZERO
	if position.distance_to(tar) > target_max:
		velocity = position.direction_to(tar) * speed
		if get_slide_count() and stop_timer.is_stopped():
			stop_timer.start()
			last_position = position
		velocity = move_and_slide(velocity)		
		

func attack_enemy(tar:Unit):
	if position.distance_to(tar.position) <= attack_range:
		anim_player.play("attack")
		tar.take_damage(damage)
	
func take_damage(amount) -> bool:
	health -= amount
	if(health > 0):
		return true
	collider.disabled = true
	vision_collider.disabled = true
	emit_signal("was_deselected", self)
	state_machine.change_state_via_name("DyingState")
	return false
		
func _process(delta):
	pass

func _physics_process(delta):
	health_bar.value = health;

func die():
	disconnect("was_selected", get_parent().get_parent(), "select_unit")
	disconnect("was_deselected", get_parent().get_parent(), "deselect_unit")
	remove_from_group("units")
	get_parent().remove_child($self)
	

func _on_Unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT  and unit_owner == 0:
				set_selected(true)
			#if event.button_index == BUTTON_RIGHT:
			#	set_selected(false)
	pass # Replace with function body.


func _on_Vision_body_entered(body):
	if body.is_in_group("units"):
		if body.unit_owner != unit_owner:
			possible_targets.append(body)


func _on_Vision_body_exited(body):
	if possible_targets.has(body):
		possible_targets.erase(body)

func closest_enemy()->Unit:
	if possible_targets == []:
		return null
	possible_targets.sort_custom(self,"_compare_distance")
	return possible_targets[0]
	
func closest_enemy_in_range()->Unit:
	if possible_targets == []:
		return null
	possible_targets.sort_custom(self,"_compare_distance")
	if(position.distance_to(possible_targets[0].position) > attack_range):
		return null
	return possible_targets[0]
		
func _compare_distance(target_a, target_b):
	if position.distance_to(target_a.position) < position.distance_to(target_b.position):
		return true
	else:
		return false


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
