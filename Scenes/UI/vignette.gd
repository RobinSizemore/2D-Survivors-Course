extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.player_damaged.connect(on_player_damaged)

func on_player_damaged():
	$AnimationPlayer.play("hit")