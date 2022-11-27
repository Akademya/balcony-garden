extends Label


func _process(delta):
	self.text = String(GameState.global_money)
