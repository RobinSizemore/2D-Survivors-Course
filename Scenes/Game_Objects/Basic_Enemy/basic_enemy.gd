extends CharacterBody2D

const MAX_SPEED = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var movement_vector = get_direction_to_player()
	velocity = movement_vector * MAX_SPEED
	move_and_slide()

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()

func on_area_entered(other_area):
	var ability_layer = 4 # The sword ability is on layer 3, which is 1**2, so 4.
	if other_area.collision_layer == ability_layer:
		queue_free() # Destroy the enemy when the sword ability hits it.
