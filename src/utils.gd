extends Node

const pd_shader = preload("res://assets/shaders/plant_done.tres")

var dead_plant_texture = load("res://assets/loader/plants/dead.png")

class Plant:
	var texture
	var water_level: int = 0
	var stage: int = 0
	var type: String
	var stages: int = 0
	var gcs: int = 0
	var counter: int = 0
	var sprite: Sprite
	
	func increase_water_level():
		water_level += 10
	
	func decrease_water_leve():
		water_level -= 10
	
	func _init(type: String, sprite: Sprite = Sprite.new(), stage: int = 0, water_level: int = 0):
		self.type = type
		self.stage = stage
		self.water_level = water_level
		self.sprite = sprite
		self.texture = AssetHandler.plants[type]["src"]
		self.stages = AssetHandler.plants[type]["stages"]
		self.gcs = AssetHandler.plants[type]["gcs"]

#class DeadPlant:
#	var texture = load("res://assets/loader/plants/dead.png")
#	var type = "dead"
#	var sprite: Sprite

class ShopItem:
	var texture
	var text
	var sell_price
	var buy_price
	var id
	
	func _init(texture, text: String, sell_price: int, buy_price: int, id: String):
		self.texture = texture
		self.sell_price = sell_price
		self.buy_price = buy_price
		self.text = text
		self.id = id

class Item:
	var texture
	var id: String
	var quantity: int
	var display_name: String
	
	func _init(texture, id: String, display_name: String, quantity: int = 1):
		self.texture = texture
		self.id = id
		self.display_name = display_name
		self.quantity = quantity
