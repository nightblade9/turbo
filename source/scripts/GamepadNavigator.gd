"""
Automagically adds functionality so that you can navigate UI controls with the gamepad.
For it to work, mark all UI buttons/controls with the group "GamepadSelectable".
Then, add an instance of this node to your scene tree, and you're good to go.

TIP: add keyboard navigation work first (including default-focused controls),
and make scenes independent (not nested/popups). Stateless scenes are much easier
to add gamepad support for. 
"""
extends Node

const _DEADZONE_VALUE = 0.2
const _SELECTABLE_CONTROLS_GROUP_NAME:String = "GamepadSelectable"

var _selected_button_index:int = -1
var _controls:Array = []
var _orient_vertically:bool = true

func _init(orient_vertically:bool = true):
	_orient_vertically = orient_vertically

func _ready():
	_controls.clear()
	_selected_button_index = -1
	
	# Make sure we only get descendents of our parent node; can't use get_tree().get_nodes_in_group,
	# that fails with nested scenes (e.g. options from title menu).
	# Populates _controls.
	_get_all_descendents_of_parent_in_group(get_parent())
	
	if len(_controls) == 0:
		push_error("Gamepad Navigator found no controls in the %s group!" % _SELECTABLE_CONTROLS_GROUP_NAME)
	
	# Assumes vertical orientation of buttons, uhhhhh ....
	for i in range(len(_controls)):
		var me:Control = _controls[i]
		var next:Control = _controls[i + 1] if i < len(_controls) - 1 else _controls[0]
		var previous:Control = _controls[i - 1] if i > 0 else _controls[len(_controls) - 1]
		
		if _orient_vertically:
			me.focus_neighbour_bottom = next.get_path()
			me.focus_neighbour_top = previous.get_path()
		else:
			me.focus_neighbour_right = next.get_path()
			me.focus_neighbour_left = previous.get_path()
			
		# If the player used .grab_focus on something, like (say) the Continue
		# button, take a note yaar.
		if me.has_focus():
			_selected_button_index = i

	# Default: if nothing is selected, select the first control.
	if _selected_button_index == -1:
		_selected_button_index = 0
		_controls[0].grab_focus()
		print("focusin' on %s" % _controls[0])
		
func _get_all_descendents_of_parent_in_group(tree_root:Node) -> void:
	for node in tree_root.get_children():
		if node.get_child_count() > 0:
			_get_all_descendents_of_parent_in_group(node)
		
		if node.is_in_group(_SELECTABLE_CONTROLS_GROUP_NAME):
			_controls.append(node)
