extends CanvasLayer

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]
onready var item_cont = $Panel/MarginContainer/VBoxContainer/ScrollContainer/ItemCont
#onready var font = load("res://assets/font/monocraft.tres")

func _ready():
	render()
	pass

func render():
	for child in item_cont.get_children():
		child.queue_free()
	for item in GameState.inventory:
		var btn = Button.new()
		btn.size_flags_horizontal = 3
		
		btn.clip_text = true
		btn.text = item["display_name"] + " | " + String(item["quantity"])
		btn.icon = item["texture"]
		btn.connect("pressed", self, "_inv_item_pressed", [item])
		item_cont.add_child(btn)

func _on_BackBTN_pressed():
	if scene_manager.has_method("close_inv"):
		scene_manager.close_inv()

func _inv_item_pressed(item):
	GameState.item_in_hand = item
	if scene_manager.has_method("close_inv"):
		scene_manager.close_inv()
