extends HBoxContainer

var item
var sell_price
var buy_price

signal ArbitraryButton_pressed(item, type)

func _ready():
	pass

func _process(delta):
	pass

func _on_ButtonSell_pressed():
	emit_signal("ArbitraryButton_pressed", item, "sell")
	# print("emitted sell")


func _on_ButtonBuy_pressed():
	emit_signal("ArbitraryButton_pressed", item, "buy")
	# print("emitted buy")
