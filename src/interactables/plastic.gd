extends Area2D

var is_mouse_inside: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed and is_mouse_inside:
		if (GameState.item_in_hand != null && GameState.item_in_hand.id == "plastic_waste"):
			var item = GameState.item_in_hand
			if (item["quantity"] > 1):
				item["quantity"] -= 1
			else:
				GameState.remove_from_inv(item.id)
				GameState.remove_item_in_hand()
			
			GameState.global_money += 10

func _on_Plastic_mouse_entered() -> void:
	is_mouse_inside = true


func _on_Plastic_mouse_exited() -> void:
	is_mouse_inside = false
