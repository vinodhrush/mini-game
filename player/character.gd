extends CharacterBody2D

signal shot(pos,direction)
signal update_status

@export var speed : float = 600.0
@export var jumpVelocity : float = -500.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var side : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var can_shoot : bool = true


func _ready():
	pass

func _physics_process(delta):
	
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true

	else:
		if was_in_air:
			jumpEnd()
		was_in_air = false
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jumpStart()

	# Handle shooting.
	if Input.is_action_pressed("shoot") && not animation_locked :
		shooting()
	elif Input.is_action_just_released("shoot"):
		animated_sprite.play("idle")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right","jump","crouch")
	# Always play the running animation when the player is moving, even if they are shooting.
	if direction.x != 0 :
		animated_sprite.play("running")
	elif Input.is_action_pressed("shoot") :
		shooting()
	else:
		animated_sprite.play("idle")

	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_face_direction()

func update_face_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
		side = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		side = true

		

func jumpStart():
	velocity.y = jumpVelocity
	print(animation_locked)
	animated_sprite.play("jump_start")
	animation_locked = true

func jumpEnd():
		animated_sprite.play("jump_end")
		animation_locked = true

func shooting():
	
	if can_shoot && Globals.ammo_amount > 0:
		print(Globals.ammo_amount)
		Globals.ammo_amount -= 1
		if side:
			var slectedMarker = $Marker2
			var player_direction = Vector2.LEFT
			shot.emit(slectedMarker.global_position, player_direction)
		else:
			var slectedMarker = $Marker1
			var player_direction = Vector2.RIGHT
			shot.emit(slectedMarker.global_position, player_direction)
			
		can_shoot = false
		animated_sprite.play("shoot")
		$Timer.start()
	
func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "jump_end"):
		animation_locked =false
	
func _on_timer_timeout():
	can_shoot = true

func add_item(type : String) -> void:
	if type == 'ammo':
		Globals.ammo_amount += 100
	update_status.emit()
