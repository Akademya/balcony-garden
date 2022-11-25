extends Control

onready var btn_start = $CanvasLayer/VBoxContainer/HBoxContainerStart/ButtonStart
onready var lbl_start = $CanvasLayer/VBoxContainer/HBoxContainerStart/Label
onready var pad_start = $CanvasLayer/VBoxContainer/HBoxContainerStart/Padding
onready var btn_exit = $CanvasLayer/VBoxContainer/HBoxContainerExit/ButtonExit
onready var lbl_exit = $CanvasLayer/VBoxContainer/HBoxContainerExit/Label
onready var pad_exit = $CanvasLayer/VBoxContainer/HBoxContainerExit/Padding

onready var SceneTree = get_tree()

func _ready():
	btn_start.connect("pressed", self, "on_ButtonStart_pressed")
	btn_exit.connect("pressed", self, "on_ButtonExit_pressed")
	
	btn_start.connect("mouse_entered", self, "on_ButtonStart_mouse_entered")
	btn_exit.connect("mouse_entered", self, "on_ButtonExit_mouse_entered")
	
	btn_start.connect("mouse_exited", self, "on_ButtonStart_mouse_exited")
	btn_exit.connect("mouse_exited", self, "on_ButtonExit_mouse_exited")

func on_ButtonStart_pressed():
	SceneTree.change_scene("res://src/scenes/PlaceholderScene.tscn")

func on_ButtonExit_pressed():
	get_tree().quit()

func on_ButtonStart_mouse_entered():
	lbl_start.visible = true
	pad_start.visible = false

func on_ButtonExit_mouse_entered():
	lbl_exit.visible = true
	pad_exit.visible = false

func on_ButtonStart_mouse_exited():
	lbl_start.visible = false
	pad_start.visible = true

func on_ButtonExit_mouse_exited():
	lbl_exit.visible = false
	pad_exit.visible = true
