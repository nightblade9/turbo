extends Node

var _selected_button_index:int = -1
var _buttons:Array

func initialize(buttons:Array):
	_buttons = buttons
	
	for i in range(len(_buttons)):
		var me:Button = _buttons[i]
		var next:Button = _buttons[i + 1] if i < len(_buttons) - 1 else _buttons[0]
		var previous:Button = _buttons[i - 1] if i > 0 else _buttons[len(_buttons) - 1]
		
		me.focus_neighbour_bottom = next.get_path()
		me.focus_neighbour_top = previous.get_path()

func _unhandled_input(event):
	if _selected_button_index == -1 and \
		(
			(event is InputEventJoypadMotion or event is InputEventJoypadButton) or \
			(event is InputEventKey)
		):
		_selected_button_index = 0
		var current_button:Button = _buttons[_selected_button_index]
		current_button.grab_focus()
