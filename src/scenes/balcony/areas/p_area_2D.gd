extends Area2D

onready var balcony = get_parent().get_parent()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		if (balcony.has_method("plant_bed_pressed")):
			balcony.plant_bed_pressed()


func _on_PArea2D_mouse_entered():
	get_node("Sprite").material.set_shader_param("is_on", true)


func _on_PArea2D_mouse_exited():
	get_node("Sprite").material.set_shader_param("is_on", false)
