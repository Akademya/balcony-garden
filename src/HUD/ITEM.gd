extends TextureRect

func _process(delta):
	if (GameState.item_in_hand == null):
		texture = null
	else:
		texture = GameState.item_in_hand.texture
