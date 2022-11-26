extends Node2D

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]

onready var sp_0 = $Sprites/PlantPos01/Sprite
onready var sp_1 = $Sprites/PlantPos02/Sprite
onready var sp_2 = $Sprites/PlantPos03/Sprite
onready var sp_3 = $Sprites/PlantPos04/Sprite
onready var sp_4 = $Sprites/PlantPos05/Sprite
onready var sp_5 = $Sprites/PlantPos06/Sprite

onready var water_indicator = $LocalHud/WaterIndicator

var plants

func _ready():
	plants = scene_manager.plants
	for i in range(0, plants.size()):
		var plant = plants[i]
		if plant == null:
			continue
		var sprite = self["sp_" + String(i)]
		sprite.material.shader = Utils.pd_shader
		sprite.texture = plant.texture
		sprite.hframes = plant.stages
		sprite.frame = plant.stage
		plant.sprite = sprite
	pass

func redraw():
	for i in range(0, plants.size()):
		var plant = plants[i]
		if plant == null:
			continue
		var sprite = self["sp_" + String(i)]
		sprite.material.shader = Utils.pd_shader
		sprite.texture = plant.texture
		sprite.hframes = plant.stages
		sprite.frame = plant.stage
		plant.sprite = sprite
