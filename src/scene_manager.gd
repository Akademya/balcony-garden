extends Node

onready var scene_cont = $SceneCont

var start_menu_scene = preload("res://src/scenes/start_menu.tscn")
var room_scene = preload("res://src/scenes/room.tscn")
var balcony_scene = preload("res://src/scenes/balcony/balcony.tscn")

# Start Global Data (too lazy to use a globally loaded script)

var in_game: bool = false

var plants = [
	[
		Utils.Plant.new("carrot"), 
		Utils.Plant.new("onion"), 
		Utils.Plant.new("pepper"), 
		Utils.Plant.new("potato"), 
		Utils.Plant.new("salad"), 
		Utils.Plant.new("tomat"), 
	],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null]
]

var unloacked_balconies = [
	true, false, false,
	false, false, false
]

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
	b.number = 0
	scene_cont.add_child(b)
	in_game = true


func _on_tick():
	if not in_game:
		return
	for plant_set in plants:
		for plant in plant_set:
			if (plant != null && plant is Utils.Plant):
				plant.counter += 1
				plant.stage = plant.counter / plant.gcs
				if (plant.stage > plant.stages - 1):
					plant.stage = plant.stages - 1
					plant.sprite.material.set_shader_param("is_on", true)
				else:
					plant.sprite.material.set_shader_param("is_on", false)
				plant.sprite.frame = plant.stage
