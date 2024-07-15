extends PanelContainer

signal ability_upgrade_selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel

func _ready():
	gui_input.connect(on_gui_input)

func set_ability_upgrade(ability_upgrade: AbilityUpgrade):
	if name_label == null or description_label == null:
		print("Name or Description label not found!")
		return
	name_label.text = ability_upgrade.name
	description_label.text = ability_upgrade.description

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		print("Clicked on card!")
		ability_upgrade_selected.emit()
