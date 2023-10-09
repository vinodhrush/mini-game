extends Area2D

signal body_colided

@onready var explosion : AnimatedSprite2D = $AnimatedSprite2D

@export var speed : float = -460.0
var current_speed = 0.0
var type = "crash"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta



func _on_body_entered(body):
	body.add_item(type)
	Globals.health -= 10
	explosion.play("explode")
	await get_tree().create_timer(0.3).timeout
	queue_free()
	
