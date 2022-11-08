extends KinematicBody2D

var isBought = false
var mouseInside = false
var isMoving:= false
var speed = 100
var selected = false
var movePostion

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isBought:
		if mouseInside and Input.is_action_just_pressed("confirm_buy"):
			selected = true
		if not mouseInside and Input.is_action_just_pressed("confirm_buy"):
			selected = false
	else:
		position = get_global_mouse_position()
		modulate.a = 0.5
		if Input.is_action_just_pressed("confirm_buy"):
			isBought = true
			modulate.a = 1
		if Input.is_action_just_pressed("cancel_buy"):
			queue_free()
	isMovingFunction(delta)


func _on_MeeleTroopSquad_mouse_entered():
	mouseInside = true


func _on_MeeleTroopSquad_mouse_exited():
	mouseInside = false


func isMovingFunction(delta):
	if isMoving:
		position = position.move_toward(movePostion, delta*speed)
	if Input.is_action_just_pressed("cancel_buy") and selected:
		isMoving = true
		movePostion = get_global_mouse_position()
