extends Sprite

func _ready() -> void:
	pass


func use():
	print("zzZ")


func _on_Interactable_body_entered(body: Node) -> void:
	body.interactable = self
