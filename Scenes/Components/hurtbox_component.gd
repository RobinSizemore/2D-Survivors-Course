extends Area2D
class_name HurtboxComponent

@export var health_component: Node
var floating_text_scene = preload ("res://Scenes/UI/floating_text.tscn")

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(other_area):
	if not other_area is HitboxComponent:
		return
	if other_area == null:
		return

	var hitbox_component = other_area as HitboxComponent
	health_component.take_damage(hitbox_component.damage)

	var float_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(float_text)
	float_text.global_position = global_position + (Vector2.UP * 8)
	float_text.start(str(hitbox_component.damage))
