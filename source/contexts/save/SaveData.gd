class_name SaveData
extends Resource

const _SAVE_FILE_NAME = "user://save%s.tres"

# Implement: put your save fields here, as export variables. They can be native
# types, or resources (for easy recursive saving).
@export var game_time_seconds:int = 0

var loaded_on:float

func save_data(save_slot:String) -> void:
	var elapsed_seconds = (Time.get_ticks_msec() - loaded_on) / 1000
	game_time_seconds += elapsed_seconds
	# Save again before quitting? Record just the elapsed diff.
	loaded_on = Time.get_ticks_msec()
	
	var save_file = _SAVE_FILE_NAME % save_slot
	var result = ResourceSaver.save(self, save_file)
	if result != OK:
		push_error("Failed to save data to %s! Result was: %s" % [save_slot, result])
	
static func load_data(save_slot:String) -> Resource:
	var save_file = _SAVE_FILE_NAME % save_slot
	
	if ResourceLoader.exists(save_file):
		var data:SaveData = load(save_file)
		data.loaded_on = Time.get_ticks_msec()
		return data
	
	return null
