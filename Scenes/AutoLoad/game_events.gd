extends Node

signal exp_vial_collected(number: float)
signal ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)

func emit_exp_vial_collected(number: float):
    exp_vial_collected.emit(number)

func emit_ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
    ability_upgrades_added.emit(upgrade, current_upgrades)
