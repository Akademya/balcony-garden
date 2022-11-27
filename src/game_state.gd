extends Node

var global_money = 15

var inventory: Array = []

var items: Dictionary = {
	"potato_seeds": {
		"src": load("res://assets/items/potato_seeds.png")	
	},
	"carrot_seeds": {
		"src": load("res://assets/items/carrot_seeds.png")
	},
	"onion_seeds": {
		"src": load("res://assets/items/onion_seeds.png")
	},
	"pepper_seeds": {
		"src": load("res://assets/items/pepper_seeds.png")
	},
	"tomato_seeds": {
		"src": load("res://assets/items/tomat_seeds.png")
	},
	"salad_seeds": {
		"src": load("res://assets/items/salad_seeds.png")
	},

	"potato": {},
	"carrot": {},
	"onion": {},
	"pepper": {},
	"tomato": {},
	"salad": {},

	"water_bottle": {},
	"milk_bottle": {},
	"chocolate_milk": {},

	"organic_waste": {},
	"plastic_waste": {},
	"paper_waste": {},

	"compost": {}
}

func add_to_inv(item: Utils.Item):
	for i in inventory:
		if (i["id"] == item["id"]):
			i["quantity"] += item["quantity"]
			return
	inventory.append(item)
