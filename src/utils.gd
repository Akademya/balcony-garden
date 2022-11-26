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
		self.sprite = Sprite.new()
		sprite.material = ShaderMaterial.new()
		sprite.material.shader = pd_shader
		
		self.sprite.texture = texture
		self.sprite.hframes = self.stages
		self.sprite.frame = stage
