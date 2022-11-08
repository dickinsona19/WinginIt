extends KinematicBody2D

var maxHealth = 3
var health = 3
var dmg = 1
var dead = false
var hittingBody
var isFighting = false
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonRoundGrey.modulate.a = .5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isFighting:
		position = position.move_toward(get_parent().get_node("mainBase").position, delta*speed)
	$ProgressBar.value = (float(health)/maxHealth) *100
	
	if health ==0:
		dead = true
		
		
	if dead:
		$attackTimer.stop()
		visible = false
		$deathTimer.start()
	

func processCombat():
	$attackTimer.start()
	print("dmg")


func _on_attackTimer_timeout():
	hittingBody.health -= dmg
	print("dmg")


func _on_AgroRange_body_entered(body):
	if body.get_groups()[0] == "ally":
		isFighting = true
		hittingBody = body
		processCombat()
		print("dmg")




func _on_deathTimer_timeout():
	queue_free()
