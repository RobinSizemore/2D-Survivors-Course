extends CanvasLayer

func _ready():
	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)

func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You were killed!"

func set_victory():
	$%TitleLabel.text = "Victory"
	$%DescriptionLabel.text = "You won!"

func on_restart_button_pressed():
	var tree = get_tree()
	get_tree().paused = false
	if tree:
		get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
	else:
		print("Error: Tree is null.")

func on_quit_button_pressed():
	get_tree().quit()
