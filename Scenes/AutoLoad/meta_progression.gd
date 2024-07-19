extends Node

const SAVE_FILE_PATH = "user://save_data.json"

var save_data: Dictionary = {}
# This is a dictionary of meta upgrades, indexed by their id.
# Sample: 
# {
# 	"upgrade_currency": 0,
#	"meta_upgrades": {
#		"experience_gain": {
#	 		"quantity": 0,
#           "other_info_as_needed": "other_value"
#	 		}
#	}
#
# }

func _ready():
	GameEvents.exp_vial_collected.connect(on_experience_vial_connected)
	print("loading save file.")
	load_save_file()

func load_save_file():
	if !FileAccess.file_exists(SAVE_FILE_PATH):
		print("Save file not found.")
		return
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()
	print(save_data)

func save_save_file(): # Yes, I know the name is ridiculous.
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	print("Saving save file.")
	file.store_var(save_data)
	file.close()

func add_meta_upgrade(upgrade: MetaUpgrade):
	if !save_data.has("meta_upgrades"):
		save_data["meta_upgrades"] = {}
	if !save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	save_save_file()

func on_experience_vial_connected(number: float):
	if !save_data.has("meta_upgrade_currency"):
		save_data["meta_upgrade_currency"] = 0
	save_data["meta_upgrade_currency"] += number
