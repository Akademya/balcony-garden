extends YSort

onready var camera = $Camera2D
var speed = 100
var direction = Vector2.ZERO

func move_cam(delta: float):
	camera.global_position.x += direction.x * speed * delta
	camera.global_position.y += direction.y * speed * delta

func get_input():
	direction = Vector2.ZERO
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

func _physics_process(delta: float) -> void:
	# very niceo, very clean code :)
	get_input()
	move_cam(delta)
