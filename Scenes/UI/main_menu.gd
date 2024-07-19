extends CanvasLayer

var options_scene = preload ("res://Scenes/UI/options_menu.tscn")
var upgrades_scene = preload ("res://Scenes/UI/meta_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("web"):
		$%QuitButton.hide()
	else:
		$%QuitButton.pressed.connect(on_quit_pressed)
	$%PlayButton.pressed.connect(on_play_pressed)
	$%UpgradeButton.pressed.connect(on_upgrade_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)

func on_play_pressed():
	SceneTransition.transition()
	await SceneTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")

func on_options_pressed():
	var options_instance = options_scene.instantiate()
	get_parent().add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))

func on_upgrade_pressed():
	var upgrades_instance = upgrades_scene.instantiate()
	get_parent().add_child(upgrades_instance)
	upgrades_instance.back_pressed.connect(on_upgrades_closed.bind(upgrades_instance))

func on_options_closed(options_instance: Node):
	options_instance.queue_free()

func on_upgrades_closed(upgrades_instance: Node):
	upgrades_instance.queue_free()

func on_quit_pressed():
	get_tree().quit()
