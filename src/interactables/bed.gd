extends Sprite

func _ready() -> void:
	pass

func use():
	var transition = get_parent().get_node("CanvasLayer/Transition")
	transition.fade_out()
	
	if get_tree().get_nodes_in_group("SceneManager")[0].has_method("load_scene"):
		get_tree().get_nodes_in_group("SceneManager")[0].load_scene("room_scene")

func _on_Interactable_body_entered(body: Node) -> void:
	body.interactable = self
	body.spaceSprite.visible = true

func _on_Interactable_body_exited(body: Node) -> void:
	body.interactable = null
	body.spaceSprite.visible = false
