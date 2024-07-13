extends Node
class_name HealthComponent

@export var max_health: float = 10
var current_health
var base_max_health
var health_regen: float = 0

signal died
signal health_changed

func _ready():
    current_health = max_health
    base_max_health = max_health

func _process(delta):
    if health_regen > 0:
        current_health = min(current_health + (health_regen * delta), max_health)
        health_changed.emit()

func increase_max_health(amount: float):
    max_health += amount
    current_health += amount
    health_changed.emit()

func take_damage(damage: float):
    current_health = max(current_health - damage, 0)
    health_changed.emit()
    Callable(check_death).call_deferred()

func get_health_percent():
    if max_health <= 0:
        return 0
    return min(current_health / max_health, 1)

func check_death():
    if current_health <= 0:
        died.emit()
        owner.queue_free()
