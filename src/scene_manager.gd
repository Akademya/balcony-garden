extends Node

onready var scene_cont = $SceneCont

var start_menu_scene = preload("res://src/scenes/start_menu.tscn")
var room_scene = preload("res://src/scenes/room.tscn")
var balcony_scene = preload("res://src/scenes/balcony/balcony.tscn")

# Start Global Data (too lazy to use a globally loaded script)

var in_game: bool = false
var focused_game: bool = false
var water_level = 100
var water_rate = 90
var water_counter = 0

var global_money = 0

var plants = [
	Utils.Plant.new("carrot"), 
	Utils.Plant.new("onion"), 
	Utils.Plant.new("pepper"), 
	Utils.Plant.new("potato"), 
	Utils.Plant.new("salad"), 
	Utils.Plant.new("tomat"), 
]

#var unlocked_balconies = [
#	true, false, false,
#	false, false, false
#]

# End Global Data

func unload_all_children():
	for child in scene_cont.get_children():
		child.queue_free()

func load_scene(scene_name: String):
	unload_all_children()
	var scene_instance = self[scene_name].instance()
	scene_cont.add_child(scene_instance)
	

func _ready():
	unload_all_children()
#	load_scene("start_menu_scene")
	
	# TEST
	var b = balcony_scene.instance()
	scene_cont.add_child(b)
	in_game = true
	focused_game = true


func _on_tick():
	if not in_game:
		return
	
	water_counter += 1
	if (water_counter % water_rate == 0):
		water_level -= 10
	if (water_level < 0):
		water_level = 0
	
	for plant in plants:
		if (plant != null && plant is Utils.Plant):
			if (plant.type == "dead"):
				continue
			if (water_level <= 0):
				plant.type = "dead"
				plant.texture = Utils.dead_plant_texture
				plant.stage = 0
				plant.stages = 1
				if (focused_game):
					plant.sprite.material.set_shader_param("is_on", false)
					if get_tree().get_nodes_in_group("Balcony")[0].has_method("redraw"):
						get_tree().get_nodes_in_group("Balcony")[0].redraw()
					plant.sprite.frame = plant.stage
				continue
			plant.counter += 1
			plant.stage = plant.counter / plant.gcs
			if (plant.stage > plant.stages - 1):
				plant.stage = plant.stages - 1
				if (focused_game):
					plant.sprite.material.set_shader_param("is_on", true)
			else:
				if (focused_game):
					plant.sprite.material.set_shader_param("is_on", false)
			if (focused_game):
				plant.sprite.frame = plant.stage

func _process(delta):
	if (focused_game):
		get_tree().get_nodes_in_group("Balcony")[0].water_indicator.material.set_shader_param(
			"perc", 
			lerp(
				get_tree().get_nodes_in_group("Balcony")[0].water_indicator.material.get_shader_param("perc"), 
				water_level, 1 * delta
			)
		)
