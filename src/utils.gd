extends Node

const pd_shader = preload("res://assets/shaders/plant_done.tres")

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
	
	func _init(type: String, stage: int = 0, water_level: int = 0):
		self.type = type
		self.stage = stage
		self.water_level = water_level
		self.texture = AssetHandler.plants[type]["src"]
		self.stages = AssetHandler.plants[type]["stages"]
		self.gcs = AssetHandler.plants[type]["gcs"]

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
