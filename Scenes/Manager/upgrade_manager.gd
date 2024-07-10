extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)

func on_level_up(_new_level: int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

func apply_upgrade(chosen_upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	if not has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
		print("Level up! Chose new upgrade: ", chosen_upgrade.name)
	else:
		current_upgrades[chosen_upgrade.id].quantity += 1
		print("Level up! Chose upgrade: ", chosen_upgrade.name, " (", current_upgrades[chosen_upgrade.id].quantity, ")")

func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
