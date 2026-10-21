extends Node
class_name Main

const UfO = preload("res://UFO/UFO.tscn")
@onready var ufo_timer: Timer = $UfoTimer

func _ready() -> void:
	ufo_timer.timeout.connect(on_ufo_spawned)

func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
 	# FIXME: Not pausing, testing with quit().
		#get_tree().paused = true
		get_tree().quit()

func on_ufo_spawned():
	var ufo: UFO = UfO.instantiate()
	if randi() % 2:
		ufo.position.x = 0
	else:
		ufo.position.x = get_viewport().size.x
	
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)
