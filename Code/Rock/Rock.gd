extends ScreenWrapper
class_name Rock

var speed: float = 100 # px / sec
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

func _process(delta: float) -> void:
	velocity = direction * speed * delta
	position += velocity
	super._process(delta)
