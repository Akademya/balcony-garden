extends HBoxContainer

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]

var item
var sell_price
var buy_price

signal ArbitraryButton_pressed(item, type)

func _ready():
	get_node("ButtonSell").connect("mouse_entered", self, "_on_ButtonSell_mouse_entered")
	get_node("ButtonBuy").connect("mouse_entered", self, "_on_ButtonBuy_mouse_entered")
	get_node("ButtonSell").connect("pressed", self, "_on_ButtonSell_press")
	get_node("ButtonBuy").connect("pressed", self, "_on_ButtonBuy_press")

func _process(delta):
	if buy_price > GameState.global_money:
		$ButtonBuy.disabled = true
	else:
		$ButtonBuy.disabled = false
	
	var is_sell_possible = false
	for i in GameState.inventory:
		if i.id == item.id:
			is_sell_possible = true
	if is_sell_possible == true:
		$ButtonSell.disabled = false
	else:
		$ButtonSell.disabled = true

func _on_ButtonSell_mouse_entered():
	if GameState.toggle_SFX && $ButtonSell.disabled == false:
		scene_manager.get_node("AudioStreamPlayerSelect").play()

func _on_ButtonBuy_mouse_entered():
	if GameState.toggle_SFX && $ButtonBuy.disabled == false:
		scene_manager.get_node("AudioStreamPlayerSelect").play()

func _on_ButtonSell_pressed():
	if GameState.toggle_SFX && $ButtonSell.disabled == false:
		scene_manager.get_node("AudioStreamPlayerConfirm").play()
	print(GameState.global_money)
	emit_signal("ArbitraryButton_pressed", item, "sell")

func _on_ButtonBuy_pressed():
	if GameState.toggle_SFX && $ButtonBuy.disabled == false:
		scene_manager.get_node("AudioStreamPlayerConfirm").play()
	print(GameState.global_money)
	emit_signal("ArbitraryButton_pressed", item, "buy")
	# print("emitted buy")
