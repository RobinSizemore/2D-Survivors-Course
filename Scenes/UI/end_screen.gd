extends CanvasLayer

@onready var panel_container = $%PanelContainer
var upgrades_scene = preload ("res://Scenes/UI/meta_menu.tscn")

func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3) \
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)
	$%UpgradesButton.pressed.connect(on_upgrades_button_pressed)

func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You were killed!"
	play_jingle(true)

func set_victory():
	$%TitleLabel.text = "Victory"
	$%DescriptionLabel.text = "You won!"
	play_jingle(false)

func play_jingle(defeat: bool=false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()

func on_upgrades_button_pressed():
	var upgrades_instance = upgrades_scene.instantiate()
	get_parent().add_child(upgrades_instance)
	upgrades_instance.back_pressed.connect(on_upgrades_closed.bind(upgrades_instance))

func on_restart_button_pressed():
	var tree = get_tree()
	get_tree().paused = false
	if tree:
		SceneTransition.transition()
		await SceneTransition.transitioned_halfway
		get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
	else:
		print("Error: Tree is null.")

func on_quit_button_pressed():
	get_tree().paused = false
	SceneTransition.transition()
	await SceneTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func on_upgrades_closed(upgrades_instance: Node):
	upgrades_instance.queue_free()