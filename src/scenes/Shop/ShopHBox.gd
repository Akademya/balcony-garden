extends HBoxContainer

var item
var sell_price
var buy_price

signal ArbitraryButton_pressed(item, type)

func _ready():
	pass

#	print(GameState.global_money)
#	for i in seeds_container.get_children():
#		var is_sell_pos: bool = false
#		var button_sell = i.get_node("ButtonSell")
#		var button_buy = i.get_node("ButtonBuy")
#		var button_sell_price = i.sell_price
#		var button_buy_price = i.buy_price
#
#		# check buy buttons <EASY AS HELL>
#		if button_buy_price > GameState.global_money:
#			button_buy.disabled = true
#
#		# check sell buttons <HARD AS HELL>
#		for j in GameState.inventory:
#			if j.id == i.item.id:
#				is_sell_pos = true
#		if is_sell_pos == true:
#			button_sell.disabled = false
#		else:
#			button_sell.disabled = true
#
#	for i in drinks_container.get_children():
#		var button_buy = i.get_node("ButtonBuy")
#		var button_buy_price = i.buy_price
#		if button_buy_price > GameState.global_money:
#			button_buy.disabled = true
func _process(delta):
	if buy_price > GameState.global_money:
		$ButtonBuy.disabled = true
	else:
		$ButtonBuy.disabled = false
	
	var is_sell_possible = false
	for i in GameState.inventory:
		if i.id == item.id:
			is_sell_possible = true
	if is_sell_possible == true:
		$ButtonSell.disabled = false
	else:
		$ButtonSell.disabled = true
	

func _on_ButtonSell_pressed():
	print(GameState.global_money)
	emit_signal("ArbitraryButton_pressed", item, "sell")
	
	# print("emitted sell")


func _on_ButtonBuy_pressed():
	print(GameState.global_money)
	emit_signal("ArbitraryButton_pressed", item, "buy")
	# print("emitted buy")
