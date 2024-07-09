extends Node
class_name HealthComponent

@export var max_health: float = 10
var current_health

signal died

func _ready():
    current_health = max_health

func take_damage(damage: float):
    current_health = max(current_health - damage, 0)
    Callable(check_death).call_deferred()

func check_death():
    if current_health <= 0:
        died.emit()
        owner.queue_free()
