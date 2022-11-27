extends TextureButton

func _on_back_btn_mouse_entered():
	material.set_shader_param("is_on", true)


func _on_back_btn_mouse_exited():
	material.set_shader_param("is_on", false)
