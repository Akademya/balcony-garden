extends Sprite

func _ready() -> void:
	pass


func use():
	if get_tree().get_nodes_in_group("SceneManager")[0].has_method("load_scene"):
		get_tree().get_nodes_in_group("SceneManager")[0].load_scene("balcony_scene")


func _on_Interactable_body_entered(body: Node) -> void:
	body.interactable = self
