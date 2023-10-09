extends Area2D

@export var speed : float = 960.0
var direction : Vector2 = Vector2.UP
var current_speed = 0.0

func _ready():
	add_to_group("bullet")
	
func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	queue_free()
