extends Control

const OptionsDialog = preload("res://contexts/options/OptionsDialog.tscn")

func _on_OptionsButton_pressed() -> void:
	var options_dialog = OptionsDialog.instance()
	add_child(options_dialog)
	options_dialog.popup()
