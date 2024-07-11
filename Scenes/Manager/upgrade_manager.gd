extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)

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
	if chosen_upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[chosen_upgrade.id].quantity
		if current_quantity >= chosen_upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func(upgrade): return upgrade.id != chosen_upgrade.id)

	GameEvents.emit_ability_upgrades_added(chosen_upgrade, current_upgrades)

func pick_upgrades():
	var filtered_upgrades = upgrade_pool.duplicate()
	var upgrade_options: Array[AbilityUpgrade] = []
	var chosen_ids = [] # This will hold the IDs of chosen upgrades

	while upgrade_options.size() < 3 and filtered_upgrades.size() > 0:
		# Filter out upgrades that have already been chosen as an option
		filtered_upgrades = filtered_upgrades.filter(func(upgrade): return not upgrade.id in chosen_ids)

		if filtered_upgrades.size() == 0:
			break # Exit if there are no more upgrades to choose from

		var random_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		if random_upgrade != null and not random_upgrade.id in chosen_ids:
			upgrade_options.append(random_upgrade as AbilityUpgrade)
			chosen_ids.append(random_upgrade.id) # Keep track of chosen IDs

	return upgrade_options

func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)

func on_level_up(_new_level: int):
	print("LEVEL UP! Pick an upgrade")
	var upgrade_options = pick_upgrades()
	if upgrade_options.size() == 0:
		print("No upgrades available")
		return
	print("Upgrade options: ", upgrade_options)
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades(upgrade_options as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
