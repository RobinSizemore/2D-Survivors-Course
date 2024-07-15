extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = $%CardContainer

func _ready():
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	var i = 0
	for upgrade in upgrades:
		var card = upgrade_card_scene.instantiate()
		card_container.add_child(card)
		card.set_ability_upgrade(upgrade)
		card.play_in(0.25 * float(i))
		card.ability_upgrade_selected.connect(on_ability_upgrade_selected.bind(upgrade))
		i = i + 1

func on_ability_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()
