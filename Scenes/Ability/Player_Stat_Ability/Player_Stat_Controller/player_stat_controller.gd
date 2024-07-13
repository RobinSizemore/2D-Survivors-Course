extends Node

@export var health_component: HealthComponent
var player: CharacterBody2D

func _ready():
    player = get_tree().get_first_node_in_group("player") as CharacterBody2D
    GameEvents.ability_upgrades_added.connect(on_ability_upgrades_added)

func on_ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
    if upgrade.id == "health":
        health_component.increase_max_health((current_upgrades["health"]["quantity"] * 10))
        print("Health upgrade applied! New health: ", health_component.max_health)
    elif upgrade.id == "health_regen":
        health_component.health_regen = health_component.health_regen + (current_upgrades["health_regen"]["quantity"] * 0.5)
        print("Health regen upgrade applied! New regen: ", health_component.health_regen)
    elif upgrade.id == "speed":
        player.speed = player.BASE_SPEED + (current_upgrades["speed"]["quantity"] * 10)
        print("Speed upgrade applied! New speed: ", player.speed)
