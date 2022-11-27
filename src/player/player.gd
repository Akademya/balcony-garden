extends KinematicBody2D

onready var scene_manager = get_tree().get_nodes_in_group("SceneManager")[0]

var interactable : Node
onready var animationTree = $AnimationTree
onready var spaceSprite = $SpaceIcon
onready var animationState = animationTree.get("parameters/playback")

var speed : int = 50
var velocity : Vector2 
var direction : Vector2
var target : Vector2
var last_direction: Vector2

func _ready() -> void:
	self.global_position = GameState.player_position

func find_path(mouse_pos): 
	target = mouse_pos
	direction = (mouse_pos - self.global_position).normalized()
	velocity = direction * speed

func interact():
	if interactable and interactable.has_method("use"):
		if GameState.toggle_SFX:
			scene_manager.get_node("AudioStreamPlayerConfirm").play()
		interactable.use()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if event.position.distance_to(self.global_position) < 10: 
			print("UgaBuga")
		else:
			find_path(get_viewport().get_mouse_position())
	
	if Input.is_action_just_pressed("ui_accept"):
		interact()

func _physics_process(_delta: float) -> void:
	# save player pos
	GameState.player_position = self.global_position
	
	# animate
	if velocity != Vector2.ZERO:
		if GameState.toggle_SFX:
			scene_manager.get_node("AudioStreamPlayerWalk").play()
		animationTree.set("parameters/idle/blend_position", velocity)
		animationTree.set("parameters/run/blend_position", velocity)
		animationState.travel("run")
	else: 
		animationState.travel("idle")
	
	# move to click pos
	if self.global_position.distance_to(target) > 1:
		velocity = move_and_slide(velocity)
	else:
		velocity = Vector2.ZERO
