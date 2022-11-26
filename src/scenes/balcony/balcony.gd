extends Node2D

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]

onready var spot_0 = $Sprites/PlantPos01
onready var spot_1 = $Sprites/PlantPos02
onready var spot_2 = $Sprites/PlantPos03
onready var spot_3 = $Sprites/PlantPos04
onready var spot_4 = $Sprites/PlantPos05
onready var spot_5 = $Sprites/PlantPos06

var number: int = 0
var plants

func _ready():
	plants = scene_manager.plants[number]
	for i in range(0, plants.size()):
		var plant = plants[i]
		if plant == null:
			continue
		self["spot_" + String(i)].add_child(plant.sprite)
	pass
