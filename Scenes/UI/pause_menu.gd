extends CanvasLayer

@onready var panel_container = $%PanelContainer
var options_scene = preload("res://Scenes/UI/options_menu.tscn")
var main_menu_scene = preload("res://Scenes/UI/main_menu.tscn")
var is_closing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2
	$%ResumeButton.pressed.connect(on_resume_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)

	$AnimationPlayer.play("default")
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_tree().root.set_input_as_handled()


func close_pause():
	if is_closing:
		print("already closing")
		return
	is_closing = true
	print("starting animations")
	$AnimationPlayer.play_backwards("default")
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	await get_tree().create_timer(0.3).timeout

	print("animations finished")
	get_tree().paused = false
	queue_free()

func on_resume_pressed():
	close_pause()

func on_quit_pressed():
	close_pause()
	queue_free()

func on_options_pressed():
	var options_instance = options_scene.instantiate()
	get_parent().add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))	

func on_options_closed(options_instance: Node):
	options_instance.queue_free()
