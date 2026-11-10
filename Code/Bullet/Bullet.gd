extends ScreenWrapper
class_name Bullet

## TODO: [ ] Set this explicitly in the next version.
##       Curnently fixes the bullet crash.
var player

var speed: float = 600.0 # px / sec.
var lifespan: float = 2.0 # seconds til end.

func _process(delta: float) -> void:
	position.x += cos(rotation - PI / 2) * delta * speed
	position.y += sin(rotation - PI / 2) * delta * speed
	super._process(delta)
	
	# Countdown.
	lifespan -= delta
	if lifespan < 0.0:
		queue_free()
	
