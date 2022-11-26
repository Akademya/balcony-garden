extends Control

onready var shop_item_scene = preload("res://src/scenes/Shop/ShopHBox.tscn")


var shop_items: Dictionary = {
	"seeds": [
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/potato_seeds.png"),
			"Potato Seeds",
			5,
			10,
			"potato_seeds"
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/carrot_seeds.png"),
			"Carrot Seeds",
			5,
			10,
			"carrot_seeds"
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/onion_seeds.png"),
			"Onion Seeds",
			5,
			10,
			"onion_seeds"
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/pepper_seeds.png"),
			"Pepper Seeds",
			5,
			10,
			"pepper_seeds"
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/salad_seeds.png"),
			"Salad Seeds",
			5,
			10,
			"salad_seeds"
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/tomat_seeds.png"),
			"Tomato seeds",
			5,
			10,
			"tomat_seeds"
		)
	],
	"drinks": [
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/water_bottle.png"),
			"Water Bottle",
			0,
			10,
			"water_bottle"
		)
	]
}

func _ready():
	for i in shop_items.seeds:
		var hboxcontainer: Node = shop_item_scene.instance();
		$MarginContainer/TabContainer/Seeds/ScrollContainer/VBoxContainer.add_child(hboxcontainer)
		hboxcontainer.get_node("ItemIcon").texture = i.texture
		hboxcontainer.get_node("ItemName").text = i.text
		hboxcontainer.get_node("ButtonSell").text = "Sell $" + String(i.sell_price) 
		hboxcontainer.get_node("ButtonBuy").text = "Buy $" + String(i.buy_price)
	
	for i in shop_items.drinks:
		var hboxcontainer: Node = shop_item_scene.instance();
		$MarginContainer/TabContainer/Drinks/ScrollContainer/VBoxContainer.add_child(hboxcontainer)
		hboxcontainer.get_node("ItemIcon").texture = i.texture
		hboxcontainer.get_node("ItemName").text = i.text
		hboxcontainer.get_node("ButtonSell").text = "Sell $" + String(i.sell_price) 
		hboxcontainer.get_node("ButtonBuy").text = "Buy $" + String(i.buy_price)
		hboxcontainer.get_node("ButtonSell").visible = false
