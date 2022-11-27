extends Area2D

onready var balcony = get_parent().get_parent()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		if (balcony.is_wc_in_hand):
			return
		if (GameState.item_in_hand != null && GameState.item_in_hand.id == "organic_waste"):
			var item = GameState.item_in_hand
			if (item["quantity"] > 1):
				item["quantity"] -= 1
			else:
				GameState.remove_from_inv(item.id)
				GameState.remove_item_in_hand()
			
			var itm = Utils.Item.new(
				GameState.items["compost"].src,
				"compost",
				"Compost"
			)
			
			GameState.add_to_inv(itm)
				
	

func _on_CoArea2D_mouse_entered():
	get_node("Sprite").material.set_shader_param("is_on", true)


func _on_CoArea2D_mouse_exited():
	get_node("Sprite").material.set_shader_param("is_on", false)
