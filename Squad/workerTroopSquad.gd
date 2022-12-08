extends KinematicBody2D


var isBuying
var cost = 1
var health =5
var maxHealth = 5
var dead = false
var isSelected =false
var mouseInside = false
var isMoving = false
var movePostion
var speed = 300
var hittingNode

# Called when the node enters the scene tree for the first time.
func _ready():
	isBuying = true
	$ButtonRoundGrey.modulate.a = .5
	$ButtonRoundGrey2.modulate.a = .5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overLappingBodies = $Range.get_overlapping_bodies()
	processTarget(overLappingBodies)
	if isBuying == false:
		if health <= 0:
			dead = true
		processState(delta)
		
	$ProgressBar.value = (float(health)/maxHealth)*100
	if isBuying == true:
		position = get_global_mouse_position()
		if Input.is_action_just_pressed("confirm_buy"):
			processBuy()
		if Input.is_action_just_pressed("cancel_buy"):
			queue_free()
	

func processBuy():
	isBuying = false
	get_parent().coins -= cost

func processState(delta):
	if isBuying == false:
		if mouseInside and Input.is_action_just_pressed("confirm_buy"):
			isSelected = true
		if isSelected and Input.is_action_just_pressed("confirm_buy") and not mouseInside:
			isSelected = false
	
	if isSelected:
		$ButtonRoundGrey2.visible = true
	if not isSelected:
		$ButtonRoundGrey2.visible = false
	
	isMovingFunction(delta)


func _on_workerTroopSquad_mouse_entered():
	mouseInside = true


func _on_workerTroopSquad_mouse_exited():
	mouseInside = false


func isMovingFunction(delta):
	if isMoving:
		position = position.move_toward(movePostion, delta*speed)
	if Input.is_action_just_pressed("cancel_buy") and isSelected:
		isMoving = true
		movePostion = get_global_mouse_position()
		

func processMining():
	if hittingNode != null and isBuying == false:
		hittingNode.health -=1
		if hittingNode.mined== true:
			hittingNode = null
			$mineTimer.stop()


func _on_Range_body_entered(body):
	if body.get_groups()[0] == "coinResource" and hittingNode == null and isBuying == false:
		hittingNode = body
		$mineTimer.start()


func _on_mineTimer_timeout():
	processMining()

func processTarget(overLappingBodies):
	for i in overLappingBodies:
		if i.is_in_group("coinResource") and hittingNode == null and isBuying == false:
			hittingNode= i
			$mineTimer.start()
