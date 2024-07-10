extends Node

const SPAWN_RADIUS = 350
@export var basic_enemy_scene: PackedScene

func _ready():
    $Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
    var basic_enemy_instance = basic_enemy_scene.instantiate() as Node2D
    var player = get_tree().get_first_node_in_group("player") as Node2D
    if player == null:
        return
    var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
    var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
    
    var entities_layer = get_tree().get_first_node_in_group("entities_layer")
    if entities_layer == null:
        print("No entities layer found!")
        return

    entities_layer.add_child(basic_enemy_instance)
    basic_enemy_instance.global_position = spawn_position
