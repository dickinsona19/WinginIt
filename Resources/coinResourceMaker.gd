extends KinematicBody2D

var health = 3
var maxHealth = 3
var mined = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = (float(health)/maxHealth)*100
	if health <=0:
		mined = true
	if mined:
		var coin = load("res://MainScene/coin.tscn")
		var instancedCoin = coin.instance()
		instancedCoin.position = position
		get_parent().add_child(instancedCoin)
		queue_free()

