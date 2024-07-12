extends Node

const SWORD_SPAWN_RANGE = 4
@export var max_range: float = 100
@export var sword_ability: PackedScene

var damage = 5
var base_wait_time

func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrades_added.connect(on_ability_upgrades_added)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < 1: # No enemies in range,
		print("No enemies found.")
		return
	
	enemies = enemies.filter(func(enemy: Node2D):
		# Checking squared distance is mathematically faster than just distance (for some reason)
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	if enemies.size() < 1: # No enemies in range,
		print("No enemies in range.")
		return
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)
	)
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * SWORD_SPAWN_RANGE
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		print("No foreground layer found!")
		return
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage

	var enemy_direction = (enemies[0].global_position - sword_instance.global_position).normalized()
	sword_instance.rotation = enemy_direction.angle()

func on_ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "sword_rate":
		var percent_reduction = pow(0.9, current_upgrades["sword_rate"]["quantity"])
		print("Sword rate upgrade applied! New rate: ", percent_reduction * 100, "%. New wait time: ", base_wait_time * percent_reduction, "s")
		$Timer.wait_time = base_wait_time * percent_reduction
		$Timer.start()
