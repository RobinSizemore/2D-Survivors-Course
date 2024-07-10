extends Node

const TERRAIN_PHYSICS_LAYER = 1
const SPAWN_RADIUS = 350
@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var enemy_timer = $Timer
var base_spawn_time

func _ready():
    base_spawn_time = enemy_timer.wait_time
    enemy_timer.timeout.connect(on_timer_timeout)
    arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)

func get_spawn_position():
    var player = get_tree().get_first_node_in_group("player") as Node2D
    if player == null:
        return Vector2.ZERO
    var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
    var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
    
    for i in range(4):
        # Is there a wall between the player and the spawn position of the enemy?
        var query_params = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, TERRAIN_PHYSICS_LAYER)
        var collision_result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_params)
    
        if collision_result.is_empty(): # If not, spawn the enemy.
            break
        else: # If so, rotate and try again.
            random_direction = random_direction.rotated(TAU / 4)
            spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
        
    return spawn_position

func on_timer_timeout():
    var basic_enemy_instance = basic_enemy_scene.instantiate() as Node2D
    var player = get_tree().get_first_node_in_group("player") as Node2D
    if player == null:
        return
    var entities_layer = get_tree().get_first_node_in_group("entities_layer")
    if entities_layer == null:
        print("No entities layer found!")
        return
    basic_enemy_instance.global_position = get_spawn_position()
    entities_layer.add_child(basic_enemy_instance)
    enemy_timer.start()

func on_arena_difficulty_increased(difficulty: int):
    var time_decrease = (0.1 / 12) * difficulty
    enemy_timer.wait_time = max(base_spawn_time - time_decrease, .3)
    print("Enemy speed up! New spawn time: ", enemy_timer.wait_time)
