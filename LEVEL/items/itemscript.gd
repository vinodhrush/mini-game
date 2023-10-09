extends Area2D


var rotation_speed : int = 4
var ammo_health = ['ammo','ammo','ammo','health','health','health','health']
var type = ammo_health[randi()%len(ammo_health)]

func _ready():
	if type == 'ammo':
		$Sprite2D.modulate = Color(0.3,0.2, 0.8)
	if type == 'health':
		$Sprite2D.modulate = Color(0.1,0.8, 0.1)
		
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	if body.name == "Character":
		body.add_item(type)
		if type == 'health':
			Globals.health += 10
		queue_free()
