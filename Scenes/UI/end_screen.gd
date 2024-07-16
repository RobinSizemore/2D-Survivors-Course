extends CanvasLayer

@onready var panel_container = $%PanelContainer

func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

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
