class_name SaveData
extends Resource

const _SAVE_FILE_NAME = "user://save%s.tres"

# Implement: put your save fields here, as export variables. They can be native
# types, or resources (for easy recursive saving).
@export var game_time_seconds:int = 0

func save_data(save_slot:String) -> void:
	var save_file = _SAVE_FILE_NAME % save_slot
	var result = ResourceSaver.save(self, save_file)
	if result != OK:
		push_error("Failed to save data to %s! Result was: %s" % [save_slot, result])
	
static func load_data(save_slot:String) -> Resource:
	var save_file = _SAVE_FILE_NAME % save_slot
	
	if ResourceLoader.exists(save_file):
		return load(save_file)
	
	return null
