extends KinematicBody2D

var interactable : Node
onready var animationTree = $AnimationTree
onready var spaceSprite = $SpaceIcon
onready var animationState = animationTree.get("parameters/playback")

var speed : int = 50
var velocity : Vector2 
var direction : Vector2
var target : Vector2
var last_direction: Vector2

func find_path(mouse_pos): 
	target = mouse_pos
	direction = (mouse_pos - self.global_position).normalized()
	velocity = direction * speed

func interact():
	if interactable and interactable.has_method("use"):
		interactable.use()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		find_path(get_viewport().get_mouse_position())
	
	if Input.is_action_just_pressed("ui_accept"):
		interact()

func _physics_process(_delta: float) -> void:
	# animate
	if velocity != Vector2.ZERO:
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
