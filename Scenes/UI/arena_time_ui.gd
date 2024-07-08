extends CanvasLayer

@export var arena_time_manager: Node
@onready var timeLabel = %Label

func _process(_delta):
    if arena_time_manager == null:
        return
    var time_elapsed = arena_time_manager.get_time_elapsed()
    timeLabel.text = format_time(time_elapsed)

func format_time(seconds: float):
    var minutes = int(seconds / 60)
    var disp_seconds = int(seconds) % 60
    var centiseconds = int((seconds - floor(seconds)) * 100)
    return str(minutes) + ":" + ("%02d" % disp_seconds) + "." + ("%02d" % centiseconds)
