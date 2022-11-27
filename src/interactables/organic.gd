extends Area2D

var is_mouse_inside: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed and is_mouse_inside:
		pass

func _on_Organic_mouse_entered() -> void:
	is_mouse_inside = true


func _on_Organic_mouse_exited() -> void:
	is_mouse_inside = false
