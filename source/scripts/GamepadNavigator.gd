"""
Automagically adds functionality so that you can navigate UI controls with the gamepad.
For it to work, mark all UI buttons/controls with the group "GamepadSelectable".
Then, add an instance of this node to your scene tree, and you're good to go.
"""
extends Node

const _SELECTABLE_CONTROLS_GROUP_NAME:String = "GamepadSelectable"

var _selected_button_index:int = -1
var _controls:Array = []

func _ready():
	# Make sure we only get descendents of our parent node; can't use get_tree().get_nodes_in_group,
	# that fails with nested scenes (e.g. options from title menu).
	# Populates _controls.
	_get_all_descendents_of_parent_in_group(get_parent())
	
	if len(_controls) == 0:
		push_error("Gamepad Navigator found no controls in the %s group!" % _SELECTABLE_CONTROLS_GROUP_NAME)
	
	for i in range(len(_controls)):
		var me:Control = _controls[i]
		var next:Control = _controls[i + 1] if i < len(_controls) - 1 else _controls[0]
		var previous:Control = _controls[i - 1] if i > 0 else _controls[len(_controls) - 1]
		
		me.focus_neighbour_bottom = next.get_path()
		me.focus_neighbour_top = previous.get_path()

func _unhandled_input(event):
	# On first joypad keypress/motion or first keyboard keypress, if we haven't
	# yet given focus to a control (e.g. a menu button), grab focus on the first
	# marked control (e.g. first button in the title menu).
	if _selected_button_index == -1 and \
		(
			event is InputEventJoypadMotion or \
			event is InputEventJoypadButton or \
			event is InputEventKey
		):
		_selected_button_index = 0
		var current_button:Control = _controls[_selected_button_index]
		current_button.grab_focus()

func _get_all_descendents_of_parent_in_group(tree_root:Node) -> void:
	for node in tree_root.get_children():
		if node.get_child_count() > 0:
			_get_all_descendents_of_parent_in_group(node)
		elif node.is_in_group(_SELECTABLE_CONTROLS_GROUP_NAME):
			_controls.append(node)
