extends Node2D
var plane_debris: PackedScene =  preload("res://crash/plane_crash.tscn")
var spawn_area_rect = Rect2(120, 4006, 1367, -340)
var numObjectsToSpawn = 3

func _ready():
	pass

func _process(_delta):
	pass

func _on_timer_timeout():
	for i in range(numObjectsToSpawn):
		var fierball = plane_debris.instantiate()
		add_child(fierball)
		fierball.position = generateRandomPosition()
	
func generateRandomPosition():
	var x = randi() % int(spawn_area_rect.size.x) + int(spawn_area_rect.position.x)
	var y = randi() % int(spawn_area_rect.size.y) + int(spawn_area_rect.position.y)
	return Vector2(x, y)
