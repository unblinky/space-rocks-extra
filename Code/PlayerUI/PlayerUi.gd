extends PanelContainer
class_name PlayerUI

const LIFE = preload("res://PlayerUI/assets/life.tscn")
const SHIP = preload("res://Ship/Ship.tscn")

@onready var score_ui: Label = $VBox/ScoreUI
@onready var lives_ui: HBoxContainer = $VBox/LivesUI

var main: Main

var current_ship: Ship = null
var score: int = 0
var lives: int = 0

func _ready() -> void:
	update_score(1)
	update_lives(2) # 6

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("launch_ship"):
		spawn_ship()
		

func update_score(delta_score):
	score += delta_score
	score_ui.text = str(score)

func update_lives(delta_lives):
	lives += delta_lives # 6
	clear_lives()
	build_lives()

func clear_lives():
	for child in lives_ui.get_children():
		child.queue_free()

func build_lives():
	for l in lives:
		var life = LIFE.instantiate()
		lives_ui.add_child(life)

func spawn_ship():
	if current_ship == null:
		var ship = SHIP.instantiate()
		ship.player = self
		ship.position = get_viewport().size / 2
		get_parent().add_child(ship)
		current_ship = ship
		update_lives(-1)

func check_game_over():
	if lives <= 0 and current_ship == null:
		main.pause_menu.play_button.hide()
		main.pause_menu.play_again_button.show()
		main.pause_menu.continue_button.hide()
		main.pause_menu.show()
