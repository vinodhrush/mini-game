extends ParallaxLayer

@export var cloud_speed = -95
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.motion_offset.y += cloud_speed * delta
