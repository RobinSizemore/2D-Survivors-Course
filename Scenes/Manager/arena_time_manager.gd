extends Node

@export var victory_screen_scene: PackedScene
@onready var arenaTimer = $Timer

func _ready():
    arenaTimer.timeout.connect(on_arena_timer_timeout)
    arenaTimer.start()

func get_time_elapsed():
    return arenaTimer.wait_time - arenaTimer.time_left

func on_arena_timer_timeout():
    var victory_screen = victory_screen_scene.instantiate()
    get_tree().current_scene.add_child(victory_screen)