extends Control

@onready var _label = $Label

func _unhandled_input(event):
	if event is InputEventJoypadButton and event.is_pressed():
		_label.text = "Pressed: %s" % event.as_text()
	elif event is InputEventJoypadMotion and event.is_pressed():
		var motion = event as InputEventJoypadMotion
		_label.text = "Move: %s" % motion.as_text()
