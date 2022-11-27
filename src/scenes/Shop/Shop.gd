extends Control

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]
onready var seeds_container = $MarginContainer/TabContainer/Seeds/ScrollContainer/VBoxContainer
onready var drinks_container = $MarginContainer/TabContainer/Drinks/ScrollContainer/VBoxContainer
onready var shop_item_scene = preload("res://src/scenes/Shop/ShopHBox.tscn")
onready var inventory_scene = get_node("res://src/scenes/Inventory/InvLayer.tscn")
# onready var inv_itemcont = inventory_scene.get_child(7)



# create dictionary containing info ab every item shop item
# - asset
# - name
# - sell
# - buy
# - id
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
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/chocolate_milk.png"),
			"Chocolate Milk",
			0,
			10,
			"chocolate_milk"
		),
		Utils.ShopItem.new(
			load("res://assets/shop/shop_item_icons/milk_bottle.png"),
			"Milk Bottle",
			0,
			10,
			"milk_bottle"
		)
	]
}

func _ready():
	# instance shop item scenes in the shop ui for every item in shop_items
	for i in shop_items.seeds:
		var hboxcontainer: Node = shop_item_scene.instance();
		$MarginContainer/TabContainer/Seeds/ScrollContainer/VBoxContainer.add_child(hboxcontainer)
		hboxcontainer.get_node("ItemIcon").texture = i.texture
		hboxcontainer.get_node("ItemName").text = i.text
		hboxcontainer.get_node("ButtonSell").text = "Sell $" + String(i.sell_price) 
		hboxcontainer.get_node("ButtonBuy").text = "Buy $" + String(i.buy_price)
		hboxcontainer.item = i
		hboxcontainer.sell_price = i.sell_price
		hboxcontainer.buy_price = i.buy_price
		hboxcontainer.connect("ArbitraryButton_pressed", self, "_on_ArbitraryButton_pressed")
	
	for i in shop_items.drinks:
		var hboxcontainer: Node = shop_item_scene.instance();
		$MarginContainer/TabContainer/Drinks/ScrollContainer/VBoxContainer.add_child(hboxcontainer)
		hboxcontainer.get_node("ItemIcon").texture = i.texture
		hboxcontainer.get_node("ItemName").text = i.text
		hboxcontainer.get_node("ButtonSell").text = "Sell $" + String(i.sell_price) 
		hboxcontainer.get_node("ButtonBuy").text = "Buy $" + String(i.buy_price)
		hboxcontainer.get_node("ButtonSell").visible = false
		hboxcontainer.item = i
		hboxcontainer.buy_price = i.buy_price
		hboxcontainer.connect("ArbitraryButton_pressed", self, "_on_ArbitraryButton_pressed")
	check_buttons()

func check_buttons():
	print(GameState.global_money)
	for i in seeds_container.get_children():
		var button_sell = i.get_node("ButtonSell")
		var button_buy = i.get_node("ButtonBuy")
		var button_sell_price = i.sell_price
		var button_buy_price = i.buy_price
		print(button_buy_price)
		if button_buy_price > GameState.global_money:
			print(i.item.id)
			button_buy.disabled = true
	
	for i in drinks_container.get_children():
		var button_buy = i.get_node("ButtonBuy")
		var button_buy_price = i.buy_price
		if button_buy_price > GameState.global_money:
			button_buy.disabled = true
	
func _on_ArbitraryButton_pressed(item, type):
	if (type == "buy"):
		if (GameState.global_money >= item.buy_price):
			GameState.global_money -= item.buy_price
			GameState.add_to_inv(Utils.Item.new(item.texture, item.id, item.text))
			check_buttons()

	if (type == "sell"):
		for i in GameState.inventory:
			if i.id == item.id:
				GameState.global_money += item.sell_price
				GameState.remove_from_inv(i)
				check_buttons()

func _process(delta):
	#check_buttons()
	pass

func _on_BackButton_pressed() -> void:
	if get_tree().get_nodes_in_group("SceneManager")[0].has_method("load_scene"):
		get_tree().get_nodes_in_group("SceneManager")[0].load_scene("room_scene")
