extends Node

@export var end_screen_scene: PackedScene
@onready var arenaTimer = $Timer

func _ready():
    arenaTimer.timeout.connect(on_arena_timer_timeout)
    arenaTimer.start()

func get_time_elapsed():
    return arenaTimer.wait_time - arenaTimer.time_left

func on_arena_timer_timeout():
    var end_screen = end_screen_scene.instantiate()
    end_screen.set_victory()
    get_tree().current_scene.add_child(end_screen)