extends Node

# Close on ESC
static func on_input(event:InputEvent, close_function:Callable):
	if event is InputEventKey and event.pressed:
		var key_event:InputEventKey = event as InputEventKey
		if key_event.is_action_pressed("ui_cancel"):
			close_function.call()
