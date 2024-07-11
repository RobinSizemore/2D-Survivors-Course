extends Node

@export var axe_ability: PackedScene

var damage = 10
var base_wait_time

func _ready():
    base_wait_time = $Timer.wait_time
    $Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
    var player = get_tree().get_first_node_in_group("player") as Node2D
    if player == null:
        return
    var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
    if foreground_layer == null:
        print("No foreground layer found!")
        return
    var axe_instance = axe_ability.instantiate() as Node2D
    axe_instance.global_position = player.global_position
    foreground_layer.add_child(axe_instance)
    axe_instance.global_position = player.global_position
    axe_instance.hitbox_component.damage = damage
