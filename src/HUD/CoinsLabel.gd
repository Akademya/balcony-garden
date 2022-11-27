extends Label

func _process(delta):
	text = String(GameState.global_money)
