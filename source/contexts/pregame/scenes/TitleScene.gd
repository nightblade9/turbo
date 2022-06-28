extends Control

const JoypadNavigator = preload("res://scripts/JoypadNavigator.gd")
const OptionsDialog = preload("res://contexts/options/OptionsDialog.tscn")

onready var _buttons = $MarginContainer/VBoxContainer/Buttons.get_children()
var _joypad_navigator = JoypadNavigator.new()

# Used for joypad input; link buttons with up/down
func _ready():
	_joypad_navigator.initialize(_buttons)
	add_child(_joypad_navigator)
	
func _on_OptionsButton_pressed() -> void:
	var options_dialog = OptionsDialog.instance()
	add_child(options_dialog)
	options_dialog.popup()
