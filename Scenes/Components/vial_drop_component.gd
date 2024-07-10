extends Node
class_name VialDropComponent

@export_range(0, 1) var drop_percent: float = 0.25
@export var vial_scene: PackedScene
@export var health_component_node: Node

func _ready():
    (health_component_node as HealthComponent).died.connect(on_died)

func on_died():
    if vial_scene == null:
        return
    if not owner is Node2D:
        return
    if randf() > drop_percent:
        var vial = vial_scene.instantiate() as Node2D
        vial.global_position = (owner as Node2D).global_position
        var entities_layer = get_tree().get_first_node_in_group("entities_layer")
        if entities_layer == null:
            print("No entities layer found!")
            return
        entities_layer.add_child(vial)
