extends CanvasLayer

const Options = preload("res://contexts/options/Options.gd")

const AMBIENCE_BUS_NAME = "BGSE"
const SFX_BUS_NAME = "SFX"

onready var _window_dialog = $WindowDialog

onready var _bgse_volume = $WindowDialog/MarginContainer/VBoxContainer/BgseVolume
onready var _sfx_volume = $WindowDialog/MarginContainer/VBoxContainer/SfxVolume

onready var _ambience_slider = $WindowDialog/MarginContainer/VBoxContainer/AmbienceVolumeSlider
onready var _sfx_slider = $WindowDialog/MarginContainer/VBoxContainer/SoundEffectsVolumeSlider

onready var _invincible_toggle = $WindowDialog/MarginContainer/VBoxContainer/InvincibilityCheck
onready var _screen_shake_toggle = $WindowDialog/MarginContainer/VBoxContainer/ScreenShakeCheck

signal close()

var _options:Options = Options.load_data()

func _ready():
	# Update UIs to match persisted options
	_update_bus_volumes_and_uis()
	
	_ambience_slider.value = _options.ambience_volume
	_sfx_slider.value = _options.sfx_volume
	
	_invincible_toggle.pressed = _options.invincible
	_screen_shake_toggle.pressed = _options.screen_shake

func popup():
	_window_dialog.popup_centered()
	_invincible_toggle.pressed = _options.invincible
	_screen_shake_toggle.pressed = _options.screen_shake
	
	# Pause game on open
	get_tree().paused = true

func _on_InvincibilityCheck_toggled(button_pressed:bool):
	_options.invincible = button_pressed
	_options.save_data()

func _on_ScreenShakeCheck_toggled(button_pressed:bool):
	_options.screen_shake = button_pressed
	_options.save_data()
	
func _on_WindowDialog_popup_hide():
	emit_signal("close")
	# resume game
	get_tree().paused = false

# Close on ESC
func _input(event:InputEvent):
	if event is InputEventKey and event.pressed:
		var key_event:InputEventKey = event as InputEventKey
		if key_event.is_action_pressed("ui_cancel"):
			_window_dialog.hide()

func _on_AmbienceVolumeSlider_value_changed(value):
	_options.ambience_volume = value
	_update_volume_uis()
	update_audio_volume(AMBIENCE_BUS_NAME, value)
	_options.save_data()

func _on_SoundEffectsVolumeSlider_value_changed(value):
	_options.sfx_volume = value
	_update_volume_uis()
	update_audio_volume(SFX_BUS_NAME, value)
	_options.save_data()

func _update_bus_volumes_and_uis():
	# Update the audio buses
	update_audio_volume(AMBIENCE_BUS_NAME, _options.ambience_volume)
	update_audio_volume(SFX_BUS_NAME, _options.sfx_volume)
	_update_volume_uis()

func _update_volume_uis():
	# Show the correct values
	_bgse_volume.text = "Background Ambience Volume (%s%%)" % [int(_options.ambience_volume * 100)]
	_sfx_volume.text = "Sound Effects Volume (%s%%)" % [int(_options.sfx_volume * 100)]
	
func update_audio_volume(bus_name:String, value:float):
	var decibels = linear2db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), decibels)
