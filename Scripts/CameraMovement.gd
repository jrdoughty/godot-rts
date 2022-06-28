extends Camera2D

export var speed = 20.0
export var zoom_speed = 10.0
export var pan_speed = 10.0

export var margin_x = 200.0
export var margin_y = 100.0

export var zoom_factor = 1.0
export var zoom_margin = 0.1
export var zoom_min = 0.1
export var zoom_max = 1.0
export var zooming = false

var mouse_pos = Vector2()
var zoom_pos = Vector2()

func _ready():
	pass # Replace with function body.


func _process(delta):
	#smooth movement
	var inp_x = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	var inp_y = (int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down")))
	position.x = lerp(position.x, position.x + inp_x * speed * zoom.x, speed * delta)
	position.y = lerp(position.y, position.y - inp_y * speed * zoom.y, speed * delta)

	if Input.is_key_pressed(KEY_CONTROL):
		if mouse_pos.x < margin_x:
			position.x = lerp(position.x, position.x - abs(mouse_pos.x - margin_x)/margin_x * pan_speed *zoom.x, pan_speed * delta)
		elif mouse_pos.x >  OS.window_size.x - margin_x:
			position.x = lerp(position.x, position.x + abs((OS.window_size.x - margin_x) - mouse_pos.x )/margin_x * pan_speed *zoom.x, pan_speed * delta)
		if mouse_pos.y < margin_y:
			position.y = lerp(position.y, position.y - abs(mouse_pos.y - margin_y)/margin_y * pan_speed *zoom.y, pan_speed * delta)
		elif mouse_pos.y >  OS.window_size.y - margin_y:
			position.y = lerp(position.y, position.y + abs((OS.window_size.y - margin_y) - mouse_pos.y )/margin_y * pan_speed *zoom.y, pan_speed * delta)


	zoom.x = lerp(zoom.x, zoom.x *zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y *zoom_factor, zoom_speed * delta)

	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)
	
	if not zooming:
		zoom_factor = 1.0

func _input(event):	
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_factor -= 0.05 * zoom_speed
				zoom_pos = get_global_mouse_position()
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_factor += 0.05 * zoom_speed
				zoom_pos = get_global_mouse_position()
		else:
			zooming = false
	if event is InputEventMouse:
		mouse_pos = event.position
