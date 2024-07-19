extends PanelContainer

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel
@onready var progress_bar: ProgressBar = $%ProgressBar
@onready var progress_label: Label = $%ProgressLabel
@onready var purchase_button: Button = $%PurchaseButton

var upgrade: MetaUpgrade

func _ready():
	purchase_button.pressed.connect(on_purchase_button_pressed)
	
func set_meta_upgrade(meta_upgrade: MetaUpgrade):
	self.upgrade = meta_upgrade
	if name_label == null or description_label == null:
		print("Name or Description label not found!")
		return
	name_label.text = meta_upgrade.title
	description_label.text = meta_upgrade.description
	update_progress_bar()

func select_card():
	$AnimationPlayer.play("selected")
	$ClickStreamPlayer.play_random()
	
	await $AnimationPlayer.animation_finished

func update_progress_bar():
	if MetaProgression.save_data.has("meta_upgrade_currency") == false:
		MetaProgression.save_data["meta_upgrade_currency"] = 0
		MetaProgression.save_save_file()
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = min(currency / upgrade.experience_cost, 1)
	progress_bar.value = percent
	if percent < 1:
		purchase_button.disabled = true
		purchase_button.text = "Not enough XP"
	else:
		purchase_button.disabled = false
		purchase_button.text = "Purchase"
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)

func on_purchase_button_pressed():
	if (upgrade == null):
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save_save_file()
	get_tree().call_group("meta_upgrade_cards", "update_progress_bar")
	$AnimationPlayer.play("selected")