extends Node2D

@export var health_component: Node
@export var sprite: Sprite2D

func _ready():
	health_component.died.connect(on_died)
	$GPUParticles2D.texture = sprite.texture

func on_died():
	if owner == null or not owner is Node2D:
		return
	var died_position = owner.global_position
	var tree = get_tree()
	var entities = tree.get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities.add_child(self)
	self.global_position = died_position
	$AnimationPlayer.play("default")
	$HitAudioPlayer.play_random()
