extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 20

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var movement_vector = get_movement_vector()
    var target_velocity = movement_vector * MAX_SPEED
    velocity = velocity.lerp(target_velocity, 1.0 - exp( - delta * ACCELERATION_SMOOTHING))
    move_and_slide()

func get_movement_vector():
    var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    return Vector2(x_movement, y_movement).normalized()