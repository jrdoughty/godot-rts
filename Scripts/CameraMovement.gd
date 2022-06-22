extends Camera2D

export var speed = 10.0


func _ready():
	pass # Replace with function body.


func _process(delta):
	#smooth movement
	var inp_x = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	var inp_y = (int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down")))
	position.x += (inp_x * speed)
	position.y -= (inp_y * speed)
