"""
Automagically adds functionality so that you can navigate UI controls with the gamepad.
For it to work, mark all UI buttons/controls with the group "GamepadSelectable".
Then, add an instance of this node to your scene tree, and you're good to go.

TIP: add keyboard navigation work first (including default-focused controls),
and make scenes independent (not nested/popups). Stateless scenes are much easier
to add gamepad support for. 
"""
extends Node

# Set this to true to get a print statement whenever focus changes
const _DEBUG_FOCUS:bool = false

const _DEADZONE_VALUE = 0.2 # Matches Godot's deadzone
const _SELECTABLE_CONTROLS_GROUP_NAME:String = "GamepadSelectable"

var _selected_button_index:int = -1
var _controls:Array = []
var _last_focused = null
# Select first item on init?
var _select_first:bool = true 

func _init(select_first:bool = true):
	_select_first = select_first

func _ready():
	if _DEBUG_FOCUS:
		get_viewport().connect("gui_focus_changed", Callable(self, "_on_focus_changed"))
		
	_controls.clear()
	_selected_button_index = -1
	
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
		
		me.focus_next = next.get_path()
		me.focus_previous = previous.get_path()
			
		# If the player used .grab_focus on something, like (say) the Continue
		# button, take a note yaar.
		if me.has_focus():
			_selected_button_index = i

	_select_default_control()

func _on_focus_changed(newly_focused:Control) -> void:
	if newly_focused != _last_focused:
		_last_focused = newly_focused
		print("Focus: %s, next=%s, prev=%s" % [newly_focused, newly_focused.focus_next, newly_focused.focus_previous])

func _get_all_descendents_of_parent_in_group(tree_root:Node) -> void:
	for node in tree_root.get_children():
		if node.get_child_count() > 0:
			_get_all_descendents_of_parent_in_group(node)
		
		if node.is_in_group(_SELECTABLE_CONTROLS_GROUP_NAME):
			_controls.append(node)

func _unhandled_key_input(event):
	if len(_controls) == 0:
		return

	if event.pressed:
		_select_default_control()

func _select_default_control():
	# Default: if nothing is selected, select the first control.
	if _select_first and _selected_button_index == -1:
		for index in range(len(_controls)):
			var control = _controls[index]
			if control.visible:
				_selected_button_index = index
				_controls[index].grab_focus()
				return
