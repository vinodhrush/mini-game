extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://Scene1/level_1.tscn")
	
