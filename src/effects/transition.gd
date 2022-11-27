extends ColorRect

onready var animator = $AnimationPlayer

func _ready() -> void:
	visible = true
	animator.play("fade_out")

func fade_out():
	animator.play("fade_in")
