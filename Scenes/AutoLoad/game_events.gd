extends Node

signal exp_vial_collected(number: float)
signal ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged

func emit_exp_vial_collected(number: float):
    exp_vial_collected.emit(number)

func emit_ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
    ability_upgrades_added.emit(upgrade, current_upgrades)

func emit_player_damaged():
    player_damaged.emit()