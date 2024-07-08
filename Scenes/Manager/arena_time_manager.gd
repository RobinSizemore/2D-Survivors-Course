extends Node

@onready var arenaTimer = $Timer

func get_time_elapsed():
    return arenaTimer.wait_time - arenaTimer.time_left
