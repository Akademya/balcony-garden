extends YSort

onready var camera = $Camera2D
var speed = 10
var direction = Vector2.ZERO

func move_cam():
	camera.global_position.x += int(direction.x * speed)
	camera.global_position.y += int(direction.y * speed)

func get_input():
	direction = Vector2.ZERO
	
	if(Input.is_action_pressed("ui_down")):
		direction.y = 1
	if(Input.is_action_pressed("ui_up")):
		direction.y = -1
	if(Input.is_action_pressed("ui_right")):
		direction.x = 1
	if(Input.is_action_pressed("ui_left")):
		direction.x = -1


func _process(_delta: float) -> void:
	get_input()
	move_cam()
