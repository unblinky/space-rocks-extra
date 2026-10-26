extends Node
class_name Main

const UfO = preload("res://UFO/UFO.tscn")
const ROCK = preload("res://Rock/Rock.tscn")
const PLAYER_UI = preload("res://PlayerUI/PlayerUI.tscn")

@onready var ufo_timer: Timer = $UfoTimer

var players: Array[PlayerUI]

func _ready() -> void:
	ufo_timer.timeout.connect(on_ufo_spawned)
	spawn_rocks(6)
	spawn_player()

func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
 	# FIXME: Not pausing, testing with quit().
		#get_tree().paused = true
		get_tree().quit()

# TODO: implement multi-player.
func just_score(delta_score, player):
	players[0].update_score(delta_score)


# TODO: Setup for multi-player.
func spawn_player():
	var player = PLAYER_UI.instantiate()
	add_child(player)
	players.append(player)

## Spawn a number of Rocks from the corners.
func spawn_rocks(rock_count):
	for r in rock_count:
		var rock = ROCK.instantiate()
		rock.main = self
		add_child(rock)

## Callback for UFO timer.
func on_ufo_spawned():
	var ufo: UFO = UfO.instantiate()
	if randi() % 2:
		ufo.position.x = 0
	else:
		ufo.position.x = get_viewport().size.x
	
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)
