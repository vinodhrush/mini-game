extends ParallaxBackground

var scrolSpeed = 1000
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.y -= scrolSpeed * delta
