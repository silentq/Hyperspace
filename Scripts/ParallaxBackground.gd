extends ParallaxBackground

var scrolling_speed = 60

func _process(delta):
	scroll_offset.y += scrolling_speed * delta
