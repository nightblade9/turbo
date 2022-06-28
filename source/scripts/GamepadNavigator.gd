"""
Automagically adds functionality so that you can navigate UI controls with the gamepad.
For it to work, mark all UI buttons/controls with the group "GamepadSelectable"
"""
extends Node

const SELECTABLE_CONTROLS_GROUP_NAME:String = "GamepadSelectable"

var _selected_button_index:int = -1
var _controls:Array

func _ready():
	_controls = get_tree().get_nodes_in_group(SELECTABLE_CONTROLS_GROUP_NAME)
	
	for i in range(len(_controls)):
		var me:Control = _controls[i]
		var next:Control = _controls[i + 1] if i < len(_controls) - 1 else _controls[0]
		var previous:Control = _controls[i - 1] if i > 0 else _controls[len(_controls) - 1]
		
		me.focus_neighbour_bottom = next.get_path()
		me.focus_neighbour_top = previous.get_path()

func _unhandled_input(event):
	if _selected_button_index == -1 and \
		(
			(event is InputEventJoypadMotion or event is InputEventJoypadButton) or \
			(event is InputEventKey)
		):
		_selected_button_index = 0
		var current_button:Control = _controls[_selected_button_index]
		current_button.grab_focus()
