extends PanelContainer
class_name PauseMenu

@onready var play_button: Button = $VBox/PlayButton
@onready var play_again_button: Button = $VBox/PlayAgainButton
@onready var continue_button: Button = $VBox/ContinueButton
@onready var quit_button: Button = $VBox/QuitButton

var main: Main = null

func _ready() -> void:
	play_button.pressed.connect(on_play_pressed)
	play_again_button.pressed.connect(on_play_again_pressed)
	continue_button.pressed.connect(on_continue_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	main = get_parent()
	play_button.show()
	play_again_button.hide()
	continue_button.hide()
	quit_button.show()
	show()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			play_button.hide()
			play_again_button.hide()
			continue_button.show()
			quit_button.show()
			show()
		else:
			hide()

# Callbacks.
func on_play_pressed():
	main.spawn_rocks()
	main.spawn_player()
	hide()

func on_play_again_pressed():
	get_tree().reload_current_scene()

func on_continue_pressed():
	get_tree().paused = false
	hide()

func on_quit_pressed():
	get_tree().quit()
