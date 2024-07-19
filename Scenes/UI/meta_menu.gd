extends CanvasLayer

signal back_pressed

@export var upgrades: Array[MetaUpgrade] = []

var meta_upgrade_card_scene = preload ("res://Scenes/Components/meta_upgrade_card.tscn")
@onready var grid_container = $%GridContainer

func _ready():
    $%BackButton.pressed.connect(on_back_button_pressed)
    for upgrade in upgrades:
        var meta_upgrade_card_instance = meta_upgrade_card_scene.instantiate()
        grid_container.add_child(meta_upgrade_card_instance)
        meta_upgrade_card_instance.set_meta_upgrade(upgrade)

func on_back_button_pressed():
    back_pressed.emit()
