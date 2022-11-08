extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():
	var enemy = load("res://Enemies/enemySquads/Enemy1Squad.tscn")
	var instancedEnemy = enemy.instance()
	var randVar = randi()%4
	if randVar == 0:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % 100+500, $mainBase.position.y + randi() % 100 +500)
	if randVar == 1:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % 100+500, $mainBase.position.y + randi() % -100 -500)
	if randVar == 2:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % -100-500, $mainBase.position.y + randi() % -100 -500)
	if randVar == 3:
		instancedEnemy.position = Vector2($mainBase.position.x + randi() % -100-500, $mainBase.position.y + randi() % 100 +500)
	
	add_child(instancedEnemy)
