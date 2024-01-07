extends Control

const GamepadNavigator = preload("res://scripts/GamepadNavigator.gd")
const OptionsDialog = preload("res://contexts/options/OptionsDialog.tscn")
const SaveSelectionScene = preload("res://contexts/save/SaveSelectionScene.tscn")

var _gamepad_navigator = GamepadNavigator.new()

func _ready():
	add_child(_gamepad_navigator)
	
func _on_OptionsButton_pressed() -> void:
	var options_dialog = OptionsDialog.instantiate()
	add_child(options_dialog)
	options_dialog.popup()

func _on_NewGameButton_pressed():
	#FancyFade.wipe_conical(NewGameScene.instantiate())
	pass
	
func _on_ContinueButton_pressed():
	FancyFade.cross_fade(SaveSelectionScene.instantiate())
