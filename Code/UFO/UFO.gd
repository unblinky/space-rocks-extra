extends Area2D
class_name UFO

const BULLET = preload("res://Bullet/Bullet.tscn")
@onready var timer: Timer = $Timer
@onready var fire_timer: Timer = $FireTimer

var speed: float = 100.0 # px /sec.
var velocity_y: float = 0.0

func _ready() -> void:
	timer.timeout.connect(on_timeout)
	fire_timer.timeout.connect(on_fired)
	
	var viewport = get_viewport().size
	if position.x > viewport.x - viewport.x / 2:
		speed *= -1

func _process(delta: float) -> void:
	position.x += speed * delta
	position.y += velocity_y * delta
	
	var height = get_viewport().size.y
	if position.y < 0:
		position.y = height
	if position.y > height:
		position.y = 0

func on_fired():
	var bullet: Bullet = BULLET.instantiate()
	bullet.position = position
	bullet.rotation_degrees = randf_range(0.0, 360.0)
	get_parent().add_child(bullet)

func on_timeout():
	if velocity_y != 0.0:
		velocity_y = 0.0
	else:
		var rando = randi_range(0, 1)
		if rando:
			velocity_y = -speed
		else:
			velocity_y = speed
	print("It's going!")
