extends CharacterBody2D

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var audio_component = $HitAudioPlayer

func _ready():
	$HurtboxComponent.hit.connect(on_hit)

func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()


func on_hit():
	audio_component.play_random()