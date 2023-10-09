extends Node2D
var plane_debris: PackedScene =  preload("res://crash/plane_crash.tscn")
var spawn_area_rect = Rect2(120, 4006, 1367, -340)
var numObjectsToSpawn = 4
var rotation_speed : int = 5

func _ready():
	pass

func _process(delta):
	
	$Area2D/Sprite2D2.rotation += rotation_speed * delta
	
	if Globals.health == 0 or $Area2D.position.y + 30 < $SkydivePlayer.position.y:
		get_tree().change_scene_to_file("res://trans/startMenu.tscn")
		
	
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
		
	
func _on_timer_timeout():
	for i in range(numObjectsToSpawn):
		var fierball = plane_debris.instantiate()
		add_child(fierball)
		fierball.position = generateRandomPosition()


func generateRandomPosition():
	var x = randi() % int(spawn_area_rect.size.x) + int(spawn_area_rect.position.x)
	var y = randi() % int(spawn_area_rect.size.y) + int(spawn_area_rect.position.y)
	return Vector2(x, y)


func _on_area_2d_body_entered(body):
	queue_free()
	get_tree().change_scene_to_file("res://main.tscn")
