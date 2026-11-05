extends ScreenWrapper
class_name Ship

const BULLET = preload("res://Bullet/Bull.tscn")

var player: PlayerUI

var turn_speed: float = 180 # degrees / sec.
var thrust_power: float = 10 # multipier. px / sec?
var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	# FIXME: Fire crashes for mysterious reasons.
	#if Input.is_action_just_pressed("fire"):
		#fire()
	
	if Input.is_action_pressed("turn_ccw"):
		rotation_degrees -= turn_speed * delta
	
	if Input.is_action_pressed("turn_cw"):
		rotation_degrees += turn_speed * delta
	
	if Input.is_action_pressed("thrust"):
		# Snake like movement.
		velocity.x += cos(rotation - PI / 2) * thrust_power
		velocity.y += sin(rotation - PI / 2) * thrust_power
	
	# TODO: Fix max velocity.
	#var c: float = 1000
	#velocity = velocity.clamp(Vector2(-c, c), Vector2(-c, c))
	position += velocity * delta
	super._process(delta)

func fire():
	print("Fire!")
	var bull = BULLET.instantiate()
	bull.player = player
	bull.position = position
	bull.rotation = rotation
	get_parent().add_child(bull)

func destroy():
	player.current_ship = null
	queue_free.call_deferred()
	player.check_game_over()
