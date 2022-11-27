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
	$Timer.connect("timeout", self, "_on_TimerWater_timeout" )
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
			self["sp_" + String(i)].texture = null
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
				$Timer.wait_time = 1.20
				$Timer.start()
				scene_manager.get_node("AudioStreamPlayerWatering").seek(1.30)
				scene_manager.get_node("AudioStreamPlayerWatering").play()
				
				scene_manager.increase_water_leve()
		return
	else:
		if (GameState.item_in_hand != null):
			if (FLA.plantable.has(GameState.item_in_hand.id)):
				for i in range(0, plants.size()):
					var plant = plants[i]
					
					if plant == null:
						var item = GameState.item_in_hand
						print(item)
						
						plants[i] = Utils.Plant.new(item["id"].replace("_seeds", ""), self["sp_" + String(i)])
						
						if (item["quantity"] > 1):
							item["quantity"] -= 1
						else:
							GameState.remove_from_inv(item["id"])
							GameState.remove_item_in_hand()
						
						var itm = Utils.Item.new(
							GameState.items["paper_waste"].src,
							"paper_waste",
							"Paper Waste"
						)
#
						GameState.add_to_inv(itm)
						return
			else:
				for i in range(0, plants.size()):
					var plant = plants[i]
					
					if (plant != null):
						print(plant.type, " ", plant.stage, " ", plant.stages)
						if (plant.stage == plant.stages - 1 && plant.type != "dead"):
							var itm = Utils.Item.new(
								GameState.items[plant.type].src,
								plant.type,
								plant.type.to_upper()
							)
							
							var rnd = randi() % 2 + 1
							
							var sitm = Utils.Item.new(
								GameState.items[plant.type + "_seeds"].src,
								plant.type + "_seeds",
								plant.type.to_upper() + " Seeds",
								rnd
							)
							
							GameState.add_to_inv(itm)
							GameState.add_to_inv(sitm)
							plants[i] = null
							pass
						elif (plant.type == "dead"):
							plants[i] = null
							
							var itm = Utils.Item.new(
								GameState.items["organic_waste"].src,
								"organic_waste",
								"Organic Waste"
							)
							
							GameState.add_to_inv(itm)
		else:
			for i in range(0, plants.size()):
					var plant = plants[i]
					
					if (plant != null):
						if (plant.stage == plant.stages - 1 && plant.type != "dead"):
							var itm = Utils.Item.new(
								GameState.items[plant.type].src,
								plant.type,
								plant.type.to_upper()
							)
							
							var rnd = randi() % 2 + 1
							
							var sitm = Utils.Item.new(
								GameState.items[plant.type + "_seeds"].src,
								plant.type + "_seeds",
								plant.type.to_upper() + " Seeds",
								rnd
							)
							
							GameState.add_to_inv(itm)
							GameState.add_to_inv(sitm)
							plants[i] = null
							pass
						elif (plant.type == "dead"):
							plants[i] = null
							
							var itm = Utils.Item.new(
								GameState.items["organic_waste"].src,
								"organic_waste",
								"Organic Waste"
							)
							
							GameState.add_to_inv(itm)

func _on_TimerWater_timeout():
	print("done timer")
	scene_manager.get_node("AudioStreamPlayerWatering").stop()

func _process(delta):
	redraw()
	cursor_follower.position = get_viewport().get_mouse_position()
	wc_indicator.material.set_shader_param(
			"perc", 
			lerp(
				wc_indicator.material.get_shader_param("perc"), 
				water_in_can * 25, 5 * delta
			)
	)


func _on_back_btn_pressed():
	scene_manager.focused_game = false
	scene_manager.load_scene("room_scene")
