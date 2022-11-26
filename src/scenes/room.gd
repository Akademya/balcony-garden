extends YSort

onready var camera = $Camera2D
var speed = 100
var direction = Vector2.ZERO

func move_cam(_delta: float):
	camera.global_position.x += int(direction.x * speed * _delta)
	camera.global_position.y += int(direction.y * speed * _delta)

func get_input():
	direction = Vector2.ZERO
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

func _process(_delta: float) -> void:
	# very niceo, very clean code :)
	get_input()
	move_cam(_delta)
