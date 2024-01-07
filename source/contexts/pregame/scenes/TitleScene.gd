extends Control

const GamepadNavigator = preload("res://scripts/GamepadNavigator.gd")
const OptionsDialog = preload("res://contexts/options/OptionsDialog.tscn")

var _gamepad_navigator = GamepadNavigator.new()

func _ready():
	add_child(_gamepad_navigator)
	
func _on_OptionsButton_pressed() -> void:
	var options_dialog = OptionsDialog.instantiate()
	add_child(options_dialog)
	options_dialog.popup()

func _on_NewGameButton_pressed():
#	SceneManager.change_scene_to(load("res://contexts/core/CoreGameScene.tscn"), "circle")
	pass # Replace with function body.

func _on_ContinueButton_pressed():
	pass # Replace with function body.
