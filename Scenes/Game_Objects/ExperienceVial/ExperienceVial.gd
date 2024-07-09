extends Node2D

var player_node: Node2D
var moving_to_player := false
var start_position: Vector2
var end_position: Vector2
var move_duration := 0.25
var elapsed_time := 0.0

func _ready():
    $Area2D.area_entered.connect(on_area_entered)
    player_node = get_tree().get_first_node_in_group("player") as Node2D

func _process(delta: float):
    if moving_to_player:
        elapsed_time += delta
        var t = min(elapsed_time / move_duration, 1.0)
        global_position = global_position.lerp(player_node.global_position, t)
        if global_position.distance_to(end_position) < 1.0 or elapsed_time > move_duration:
            GameEvents.exp_vial_collected.emit(1)
            queue_free()

func on_area_entered(_other_area: Area2D):
    if player_node == null:
        return
    $AnimationPlayer.play("picked_up")
    start_position = position
    end_position = player_node.position
    moving_to_player = true
