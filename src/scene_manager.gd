extends Node

var start_menu_scene = preload("res://src/scenes/start_menu.tscn")
var room_scene = preload("res://src/scenes/room.tscn")

func unload_all_children():
	for child in get_children():
		child.queue_free()

func load_scene(scene_name: String):
	unload_all_children()
	var scene_instance = self[scene_name].instance()
	add_child(scene_instance)
	

func _ready():
	unload_all_children()
	load_scene("start_menu_scene")
