extends CanvasLayer

onready var item_cont = $Panel/MarginContainer/VBoxContainer/ScrollContainer/ItemCont

func _ready():
	for item in GameState.inventory:
		var btn = Button.new()
		btn.text = item["display_name"] + " - " + String(item["quantity"]).pad_zeros(2)
		btn.icon = item["texture"]
	pass
