extends PanelContainer

signal ability_upgrade_selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel

var disabled = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	
func play_in(delay: float = 0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")
	
func play_discard():
	$AnimationPlayer.play("discard")

func set_ability_upgrade(ability_upgrade: AbilityUpgrade):
	if name_label == null or description_label == null:
		print("Name or Description label not found!")
		return
	name_label.text = ability_upgrade.name
	description_label.text = ability_upgrade.description

func select_card():
	disabled = true
	$AnimationPlayer.play("selected")
	$ClickStreamPlayer.play_random()
	
	for other_card in get_tree().get_nodes_in_group("upgrade_cards"):
		if other_card == self:
			continue
		other_card.disabled = true
		other_card.play_discard()
	
	await $AnimationPlayer.animation_finished
	ability_upgrade_selected.emit()

func on_gui_input(event: InputEvent):
	if disabled:
		return
	if event.is_action_pressed("left_click"):
		select_card()

func on_mouse_entered():
	if disabled:
		return
	$RolloverStreamPlayer.play_random()
	$HoverAnimationPlayer.play("hover")
