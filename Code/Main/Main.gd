extends Node
class_name Main

const UfO = preload("res://UFO/UFO.tscn")
const ROCK = preload("res://Rock/Rock.tscn")
const PLAYER_UI = preload("res://PlayerUI/PlayerUI.tscn")

@onready var pause_menu: PauseMenu = $PauseMenu
@onready var ufo_timer: Timer = $UfoTimer

var players: Array[PlayerUI]
var rock_count: int = 1
var rocks: Array[Rock]

func _ready() -> void:
	ufo_timer.timeout.connect(on_ufo_spawned)
	#spawn_rocks(6)
	#spawn_player()


# TODO: implement multi-player.
func just_score(delta_score, player):
	players[0].update_score(delta_score)


# TODO: Setup for multi-player.
func spawn_player():
	var player = PLAYER_UI.instantiate()
	player.main = self
	add_child(player)
	players.append(player)

## Spawn a number of Rocks from the corners.
func spawn_rocks():
	for r in rock_count:
		var rock = ROCK.instantiate()
		rock.main = self
		add_child.call_deferred(rock)
		rocks.append(rock)

## Callback for UFO timer.
func on_ufo_spawned():
	var ufo: UFO = UfO.instantiate()
	if randi() % 2:
		ufo.position.x = 0
	else:
		ufo.position.x = get_viewport().size.x
	
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)


func next_round():
	rock_count += 1
	spawn_rocks()

func check_round_over():
	if rocks.size() <= 0:
		next_round()
