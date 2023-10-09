extends CharacterBody2D

signal dead_count

@onready var animated_wolf : AnimatedSprite2D = $AnimatedSprite2D
var player
const SPEED = 200.0
const JUMP_VELOCITY = -700.0
var chase = false
var health = 5
var hit_lock : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func _physics_process(delta):
	
	if health == 0:
		animated_wolf.play("death")
		await get_tree().create_timer(1.0).timeout
		queue_free()
		dead_count.emit()
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if chase == true:
		player = get_node("../Character")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * SPEED
	
#	if hit_lock:
#		Globals.health -= 20
#		hit_lock = false
#		$Timer.start()
	move_and_slide()


#func _on_area_2d_body_entered(body):
#	if is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#
#func _on_player_detector_body_entered(body):
#	animated_wolf.play("Attack")
#	hit_lock = true
#
#
#
#func _on_player_detector_body_exited(body):
#	animated_wolf.play("Walk")
#	hit_lock = false
#
#
#
#
#func _on_area_2d_2_area_entered(area):
#	if area.name == "Bullet":
#		health -= 1
#		$ProgressBar.value -= 2
#
#func _on_timer_timeout():
#	pass


func _on_area_2d_3_body_entered(body):
	if body.name == ("Character"):
		chase = true
