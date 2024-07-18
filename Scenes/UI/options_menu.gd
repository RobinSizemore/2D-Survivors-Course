extends CanvasLayer

@onready var window_button: Button = $%WindowButton
@onready var music_slider: HSlider = $%MusicVolumeSlider
@onready var sfx_slider: HSlider = $%SFXVolumeSlider

signal back_pressed

var music_volume_percent: float = 0.0
var sfx_volume_percent: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()
	window_button.pressed.connect(on_window_button_pressed)
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind("SFX"))
	music_slider.value_changed.connect(on_audio_slider_changed.bind("Music"))
	$%BackButton.pressed.connect(on_back_button_pressed)
	
func update_display():
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Windowed"
	else:
		window_button.text = "Full Screen"
	sfx_slider.value = get_bus_volume_percent("SFX")
	music_slider.value = get_bus_volume_percent("Music")

func get_bus_volume_percent(bus_name: String) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name)))


func on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()

func on_audio_slider_changed(value: float, bus_name: String):
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume_db)
	update_display()

func on_back_button_pressed():
	back_pressed.emit()