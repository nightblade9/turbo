extends CanvasLayer

const Options = preload("res://contexts/options/Options.gd")

onready var _window_dialog = $WindowDialog

onready var _music_volume = $WindowDialog/MarginContainer/VBoxContainer/MusicVolume
onready var _bgse_volume = $WindowDialog/MarginContainer/VBoxContainer/BgseVolume
onready var _sfx_volume = $WindowDialog/MarginContainer/VBoxContainer/SfxVolume

onready var _music_slider = $WindowDialog/MarginContainer/VBoxContainer/MusicVolumeSlider
onready var _ambience_slider = $WindowDialog/MarginContainer/VBoxContainer/AmbienceVolumeSlider
onready var _sfx_slider = $WindowDialog/MarginContainer/VBoxContainer/SoundEffectsVolumeSlider

onready var _invincible_toggle = $WindowDialog/MarginContainer/VBoxContainer/InvincibilityCheck
onready var _screen_shake_toggle = $WindowDialog/MarginContainer/VBoxContainer/ScreenShakeCheck

onready var _in_game_options_separator = $WindowDialog/MarginContainer/VBoxContainer/HSeparator2
onready var _restart_button = $WindowDialog/MarginContainer/VBoxContainer/RestartButton
onready var _shop_button = $WindowDialog/MarginContainer/VBoxContainer/SkillShopButton

signal close()

var _options:Options = Options.new()

func _ready():
	# Update UIs to match persisted options
	_update_volume_uis()
	
	_ambience_slider.value = _options.data["ambience_volume"]
	_sfx_slider.value = _options.data["sfx_volume"]
	
	_invincible_toggle.pressed = _options.data["invincible"]
	_screen_shake_toggle.pressed = _options.data["screen_shake"]

func popup():
	_window_dialog.popup_centered()
	_invincible_toggle.pressed = _options.data["invincible"]
	_screen_shake_toggle.pressed = _options.data["screen_shake"]
	
	# Pause game on open
	get_tree().paused = true

func hide_in_game_options():
	# Hide things that shouldn't show up when accessed from title
	_restart_button.queue_free()
	_in_game_options_separator.queue_free()
	_shop_button.queue_free()

func _on_InvincibilityCheck_toggled(button_pressed:bool):
	_options.data["invincible"] = button_pressed
	_options.save_to_disk()

func _on_ScreenShakeCheck_toggled(button_pressed:bool):
	_options.data["screen_shake"] = button_pressed
	_options.save_to_disk()
	
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
	_options.data["ambience_volume"] = value
	_update_volume_uis()
	_options.update_audio_volume(_options.AMBIENCE_BUS_NAME, value)
	_options.save_to_disk()

func _on_SoundEffectsVolumeSlider_value_changed(value):
	_options.data["sfx_volume"] = value
	_update_volume_uis()
	_options.update_audio_volume(_options.SFX_BUS_NAME, value)
	_options.save_to_disk()

# Meh. One method for all three. IDK, splitting seems wasteful?
func _update_volume_uis():
	_bgse_volume.text = "Background Ambience Volume (%s%%)" % [int(_options.data["ambience_volume"] * 100)]
	_sfx_volume.text = "Sound Effects Volume (%s%%)" % [int(_options.data["sfx_volume"] * 100)]
	
