extends Node2D
class_name AxeAbility

@onready var hitbox_component: HitboxComponent = $HitboxComponent
var base_rotation

const MAX_RADIUS = 100

func _ready():
    var tween = create_tween()
    tween.tween_method(tween_method, 0.0, 2.0, 3) # Moves between 0 and 2 rotations in 2 seconds.
    tween.tween_callback(queue_free)
    base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))

# This function is called by the tween every frame.
func tween_method(rotations: float):
    var percent_complete = (rotations / 2)
    var current_radius = percent_complete * MAX_RADIUS
    var current_direction = base_rotation.rotated(rotations * TAU)

    var player = get_tree().get_first_node_in_group("player") as Node2D
    if player == null:
        return
    
    global_position = player.global_position + (current_direction * current_radius)
