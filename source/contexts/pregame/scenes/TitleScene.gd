extends Control

const GamepadNavigator = preload("res://scripts/GamepadNavigator.gd")
const OptionsDialog = preload("res://contexts/options/OptionsDialog.tscn")
const SaveSelectionScene = preload("res://contexts/save/SaveSelectionScene.tscn")

func _ready():
	add_child(GamepadNavigator.new())
	
func _on_OptionsButton_pressed() -> void:
	var options_dialog = OptionsDialog.instantiate()
	add_child(options_dialog)
	options_dialog.popup()

func _on_NewGameButton_pressed():
	# Implement: start a new game!
	# FancyFade.wipe_conical(NewGameScene.instantiate())
	pass
	
func _on_ContinueButton_pressed():
	FancyFade.cross_fade(SaveSelectionScene.instantiate())


func _on_exit_button_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(0, 0, 0, 1), 1)
	tween.finished.connect(_on_exit)

func _on_exit():
	var tree = get_tree()
	tree.root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST) # tell nodes we're quitting
	tree.quit()
