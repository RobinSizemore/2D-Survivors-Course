extends Node

@export var axe_ability: PackedScene

var base_damage = 10.0
var base_wait_time
var damage: float

func _ready():
    damage = base_damage
    base_wait_time = $Timer.wait_time
    $Timer.timeout.connect(on_timer_timeout)
    GameEvents.ability_upgrades_added.connect(on_ability_upgrades_added)

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

func on_ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
    if upgrade.id == "axe_damage":
        damage = base_damage * (1 + (0.10 * current_upgrades["axe_damage"]["quantity"]))
        print("Axe damage upgrade applied! New damage: ", damage)
