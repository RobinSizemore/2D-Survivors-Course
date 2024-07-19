extends Node

const DIFFICULTY_INTERVAL = 5

@export var end_screen_scene: PackedScene
@onready var arenaTimer = $Timer

signal arena_difficulty_increased(difficulty: int)

var arena_difficulty = 0
var previous_time = 0

func _ready():
    arenaTimer.timeout.connect(on_arena_timer_timeout)
    arenaTimer.start()
    previous_time = arenaTimer.wait_time

func _process(_delta):
    var wait_time_target = arenaTimer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)
    if arenaTimer.time_left < wait_time_target:
        arena_difficulty += 1
        arena_difficulty_increased.emit(arena_difficulty)

func get_time_elapsed():
    return arenaTimer.wait_time - arenaTimer.time_left

func on_arena_timer_timeout():
    var end_screen = end_screen_scene.instantiate()
    MetaProgression.save_save_file()
    get_tree().current_scene.add_child(end_screen)
    end_screen.set_victory()