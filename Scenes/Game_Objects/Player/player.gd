extends CharacterBody2D

const MAX_SPEED = 200
const BASE_SPEED = 100
const ACCELERATION_SMOOTHING = 20
const DAMAGE_RATE = 1 # Seconds per damage 'tick'

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals

var number_colliding_bodies = 0
var speed: float
var last_health: int = 0

func _ready():
	speed = BASE_SPEED
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	health_component.health_changed.connect(on_health_changed)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	GameEvents.ability_upgrades_added.connect(on_ability_upgrades_added)
	on_health_changed()

func _process(delta):
	var movement_vector = get_movement_vector()
	var target_velocity = movement_vector * speed
	velocity = velocity.lerp(target_velocity, 1.0 - exp( - delta * ACCELERATION_SMOOTHING))
	move_and_slide()
	if movement_vector != Vector2.ZERO:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
	
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement).normalized()

func check_deal_damage():
	if number_colliding_bodies <= 0||!damage_interval_timer.is_stopped(): # No bodies dealing damage or already damaging
		return ;
	health_component.take_damage(1)
	print(health_component.current_health)
	damage_interval_timer.start()

func update_health():
	health_bar.value = health_component.get_health_percent()

func on_body_entered(_other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(_other_body: Node2D):
	number_colliding_bodies -= 1

func on_damage_interval_timer_timeout():
	check_deal_damage()

func on_health_changed():
	if health_component.current_health < last_health:
		$RandomStreamPlayer2D_component.play_random()
		GameEvents.emit_player_damaged()
	last_health = health_component.current_health
	update_health()

func on_ability_upgrades_added(upgrade: AbilityUpgrade, _upgrades: Dictionary):
	# This is an upgrade to an existing ability. Let abilities handle it.
	if not upgrade is Ability:
		return
	abilities.add_child(upgrade.ability_controller_scene.instantiate())
