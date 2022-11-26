extends Sprite

func _ready() -> void:
	pass

func use():
	print("code go brr")

func _on_Interactable_body_entered(body: Node) -> void:
	body.interactable = self
	body.spaceSprite.visible = true

func _on_Interactable_body_exited(body: Node) -> void:
	body.interactable = null
	body.spaceSprite.visible = false
