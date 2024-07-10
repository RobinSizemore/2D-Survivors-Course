extends CharacterBody2D

const MAX_SPEED = 75

@onready var health_component: HealthComponent = $HealthComponent

func _process(_delta):
	var movement_vector = get_direction_to_player()
	if movement_vector == null:
		return
	velocity = movement_vector * MAX_SPEED
	move_and_slide()

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
