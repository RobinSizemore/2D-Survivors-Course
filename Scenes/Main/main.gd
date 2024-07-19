extends Node

@export var end_screen_scene: PackedScene
var pause_menu_screen = preload("res://Scenes/UI/pause_menu.tscn")

func _ready():
	$%Player.health_component.died.connect(on_player_died)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var pause_menu = pause_menu_screen.instantiate()
		get_tree().root.set_input_as_handled()
		get_tree().current_scene.add_child(pause_menu)

func on_player_died():
	var end_screen = end_screen_scene.instantiate()
	MetaProgression.save_save_file()
	get_tree().current_scene.add_child(end_screen)
	end_screen.set_defeat()
	
