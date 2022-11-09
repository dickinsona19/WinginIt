extends Node2D

var isbuying = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isbuying and Input.is_action_just_pressed("cancel_buy") or Input.is_action_just_pressed("confirm_buy"):
		isbuying = false

func _on_MeleeTroopButton_button_up():
	if isbuying == false:
		isbuying = true
		var instancedMeleeTroop = load("res://Squad/MeeleTroopSquad.tscn")
		var troop = instancedMeleeTroop.instance()
		troop.position = get_global_mouse_position()
		get_parent().add_child(troop)
