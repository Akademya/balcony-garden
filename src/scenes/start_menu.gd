extends Control

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]

onready var btn_start = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerStart/ButtonStart
onready var lbl_start = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerStart/Arrow
onready var pad_start = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerStart/Padding

onready var btn_exit = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerExit/ButtonExit
onready var lbl_exit = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerExit/Arrow
onready var pad_exit = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerExit/Padding

onready var btn_options = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerOptions/ButtonOptions
onready var lbl_options = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerOptions/Arrow
onready var pad_options = $CanvasLayer/VBoxContainerMainMenu/HBoxContainerOptions/Padding

onready var btn_back = $CanvasLayer/ButtonBack

onready var btn_toggle_music = $CanvasLayer/VBoxContainerOptionsMenu/HBoxContainerToggleMusic/CheckBoxMusic
onready var btn_toggle_SFX = $CanvasLayer/VBoxContainerOptionsMenu/HBoxContainerToggleSFX/CheckBoxSFX

onready var select_l = scene_manager.get_node("AudioStreamPlayerSelect").stream.get_length()
onready var confirm_l = scene_manager.get_node("AudioStreamPlayerConfirm").stream.get_length()

onready var SceneTree = get_tree()

func _ready():
	btn_start.connect("pressed", self, "_on_ButtonStart_pressed")
	btn_exit.connect("pressed", self, "_on_ButtonExit_pressed")
	btn_options.connect("pressed", self, "_on_ButtonOptions_pressed")
	btn_back.connect("pressed", self, "_on_ButtonBack_pressed")
	
	btn_start.connect("mouse_entered", self, "_on_ButtonStart_mouse_entered")
	btn_exit.connect("mouse_entered", self, "_on_ButtonExit_mouse_entered")
	btn_options.connect("mouse_entered", self, "_on_ButtonOptions_mouse_entered")
	btn_back.connect("mouse_entered", self, "_on_ButtonBack_mouse_entered")
	
	btn_start.connect("mouse_exited", self, "_on_ButtonStart_mouse_exited")
	btn_exit.connect("mouse_exited", self, "_on_ButtonExit_mouse_exited")
	btn_options.connect("mouse_exited", self, "_on_ButtonOptions_mouse_exited")
	
	btn_toggle_music.connect("toggled", self, "_on_ToggleMusicButton_toggle")
	btn_toggle_SFX.connect("toggled", self, "_on_ToggleSFXButton_toggle")

func _on_ButtonStart_pressed():
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerConfirm").play()
	$Timer.wait_time = confirm_l - 0.3
	$Timer.connect("timeout", self, "_on_Timer_timeoutStart")
	$Timer.start()

func _on_ButtonExit_pressed():
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerConfirm").play()
	$Timer.wait_time = confirm_l - 0.3
	$Timer.connect("timeout", self, "_on_Timer_timeoutExit")
	$Timer.start()

func _on_ButtonOptions_pressed():
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerConfirm").play()
	$Timer.wait_time = confirm_l - 0.3
	$Timer.connect("timeout", self, "_on_Timer_timeoutOptions")
	$Timer.start()

func _on_ButtonBack_pressed():
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerConfirm").play()
	$Timer.wait_time = confirm_l - 0.3
	$Timer.connect("timeout", self, "_on_Timer_timeoutBack")
	$Timer.start()

func _on_Timer_timeoutBack():
	$Timer.disconnect("timeout", self, "_on_Timer_timeoutBack")
	$CanvasLayer/Title.visible = true
	$CanvasLayer/VBoxContainerMainMenu.visible = true
	$CanvasLayer/VBoxContainerOptionsMenu.visible = false
	$CanvasLayer/TitleOptions.visible = false
	$CanvasLayer/ButtonBack.visible = false

func _on_Timer_timeoutStart():
	print("yes")
	if get_tree().get_nodes_in_group("SceneManager")[0].has_method("load_scene"):
		get_tree().get_nodes_in_group("SceneManager")[0].load_scene("room_scene")

func _on_Timer_timeoutExit():
	get_tree().quit()

func _on_Timer_timeoutOptions():
	$Timer.disconnect("timeout", self, "_on_Timer_timeoutOptions")
	
	lbl_start.visible = false
	pad_start.visible = true
	lbl_exit.visible = false
	pad_exit.visible = true
	lbl_options.visible = false
	pad_options.visible = true
	
	$CanvasLayer/Title.visible = false
	$CanvasLayer/VBoxContainerMainMenu.visible = false
	$CanvasLayer/VBoxContainerOptionsMenu.visible = true
	$CanvasLayer/TitleOptions.visible = true
	$CanvasLayer/ButtonBack.visible = true

func _on_ButtonStart_mouse_entered():
	lbl_start.visible = true
	pad_start.visible = false
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerSelect").play()

func _on_ButtonExit_mouse_entered():
	lbl_exit.visible = true
	pad_exit.visible = false
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerSelect").play()

func _on_ButtonOptions_mouse_entered():
	lbl_options.visible = true
	pad_options.visible = false
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerSelect").play()

func _on_ButtonBack_mouse_entered():
	if GameState.toggle_SFX:
		scene_manager.get_node("AudioStreamPlayerSelect").play()

func _on_ButtonStart_mouse_exited():
	lbl_start.visible = false
	pad_start.visible = true

func _on_ButtonExit_mouse_exited():
	lbl_exit.visible = false
	pad_exit.visible = true

func _on_ButtonOptions_mouse_exited():
	lbl_options.visible = false
	pad_options.visible = true

func _on_ToggleMusicButton_toggle(button_state):
	GameState.toggle_music = button_state
	var bgmusic = get_tree().get_nodes_in_group("SceneManager")[0].get_node("AudioStreamPlayerBGMusic")
	bgmusic.playing = GameState.toggle_music

func _on_ToggleSFXButton_toggle(button_state):
	GameState.toggle_SFX = button_state

