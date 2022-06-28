extends Control

const JoypadNavigator = preload("res://scripts/GamepadNavigator.gd")
const OptionsDialog = preload("res://contexts/options/OptionsDialog.tscn")

var _joypad_navigator = JoypadNavigator.new()

func _ready():
	add_child(_joypad_navigator)
	
func _on_OptionsButton_pressed() -> void:
	var options_dialog = OptionsDialog.instance()
	add_child(options_dialog)
	options_dialog.popup()
