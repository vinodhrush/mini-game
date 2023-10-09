extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity* 0.001* delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			rotate(-0.005)
		else :
			rotate(0.005)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
func add_item(type : String) -> void:
	if type == 'crash':
		$AnimatedSprite2D.modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.modulate = Color.WHITE
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.modulate = Color.WHITE
