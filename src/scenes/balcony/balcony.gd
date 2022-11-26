extends Node2D

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]

onready var sp_0 = $Sprites/PlantPos01/Sprite
onready var sp_1 = $Sprites/PlantPos02/Sprite
onready var sp_2 = $Sprites/PlantPos03/Sprite
onready var sp_3 = $Sprites/PlantPos04/Sprite
onready var sp_4 = $Sprites/PlantPos05/Sprite
onready var sp_5 = $Sprites/PlantPos06/Sprite

onready var water_indicator = $LocalHud/WaterIndicator
onready var wc_indicator = $LocalHud/WCIndicator
onready var cursor_follower = $CursorFollower

var plants
var is_wc_in_hand := false
var water_in_can := 0

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

func toggle_water_can(sprite: Sprite):
	if (!is_wc_in_hand):
		sprite.modulate.a = .3
		cursor_follower.visible = true
	else:
		sprite.modulate.a = 1
		cursor_follower.visible = false
	is_wc_in_hand = !is_wc_in_hand
	pass

func barrel_pressed():
	if (is_wc_in_hand):
		if (water_in_can < 3):
			water_in_can += 1

func plant_bed_pressed():
	if (is_wc_in_hand):
		if (water_in_can > 0):
			water_in_can -= 1
			if scene_manager.has_method("increase_water_leve"):
				scene_manager.increase_water_leve()
		return

func _process(delta):
	cursor_follower.position = get_viewport().get_mouse_position()
	wc_indicator.material.set_shader_param(
			"perc", 
			lerp(
				wc_indicator.material.get_shader_param("perc"), 
				water_in_can * 25, 5 * delta
			)
	)
