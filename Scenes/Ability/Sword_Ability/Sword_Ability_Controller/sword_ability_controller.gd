extends Node

@export var max_range: float = 100
@export var sword_ability: PackedScene

func _ready():
    $Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
    var player = get_tree().get_first_node_in_group("player") as Node2D
    if player == null:
        return
    var enemies = get_tree().get_nodes_in_group("enemies")
    enemies = enemies.filter(func(enemy: Node2D):
        # Checking squared distance is mathematically faster than just distance (for some reason)
        return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
    )
    if enemies.size() < 1: # No enemies in range,
        return
    enemies.sort_custom(func(a: Node2D, b: Node2D):
        return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)
    )
    
    var sword_instance = sword_ability.instantiate() as Node2D
    player.get_parent().add_child(sword_instance)
    sword_instance.global_position = enemies[0].global_position
