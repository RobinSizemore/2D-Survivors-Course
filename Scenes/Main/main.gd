extends Node

@export var end_screen_scene: PackedScene

func _ready():
	$%Player.health_component.died.connect(on_player_died)

func on_player_died():
	var end_screen = end_screen_scene.instantiate()
	get_tree().current_scene.add_child(end_screen)
	end_screen.set_defeat()
	
