extends Node

onready var scene_cont = $SceneCont
onready var dbg = $DEBUG
onready var cmd = $DEBUG/CMD

const start_menu_scene = preload("res://src/scenes/start_menu.tscn")
const room_scene = preload("res://src/scenes/room.tscn")
const balcony_scene = preload("res://src/scenes/balcony/balcony.tscn")
const shop_scene = preload("res://src/scenes/Shop/Shop.tscn")
const inv_scene = preload("res://src/scenes/Inventory/InvLayer.tscn")

var current_scene = ""

# SHOULD HAVE USED A SINGLETON FOR ALL THIS :skull:

# Start Global Data (too lazy to use a globally loaded script)

var in_game: bool = false
var focused_game: bool = false
var water_level = 100
var water_rate = 90
var water_counter = 0

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
	if (scene_name != "inv_scene"):
		current_scene = scene_name

func load_balcony():
	unload_all_children()
	var b = balcony_scene.instance()
	scene_cont.add_child(b)
	in_game = true
	focused_game = true
	current_scene = "balcony_scene"

func _ready():
	randomize()
#	for i in GameState.items:
#		var iobj = GameState.items[i]
#		var itm = Utils.Item.new(
#			iobj["src"],
#			i,
#			i,
#			5
#		)
#		GameState.add_to_inv(itm)
#	load_scene("inv_layer")
	
	load_scene("start_menu_scene")
	
	# TEST
#	unload_all_children()
#	var b = balcony_scene.instance()
#	scene_cont.add_child(b)
#	in_game = true
#	focused_game = true

func increase_water_leve():
	if (water_level <= 100 - 10):
		water_level += 10

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
	if (Input.is_action_just_pressed("inv")):
		open_inv()
	
	if (Input.is_action_just_pressed("DEBUG")):
		dbg.visible = !dbg.visible

func close_inv():
	if (current_scene == "balcony_scene"):
		load_balcony()
	else:
		load_scene(current_scene)


func _on_ENTER_pressed():
	var command: String = cmd.text
	cmd.text = ""
	command = command.to_lower()
	var args = command.split(" ")
	if (command.begins_with("give")):
		var itm = Utils.Item.new(
				GameState.items[args[1]].src,
				args[1],
				args[1]
		)
			
		GameState.add_to_inv(itm)
		
func open_inv():
	if (focused_game == true):
		focused_game = !focused_game
	load_scene("inv_scene")
