extends Node

const _OPTIONS_FILE_NAME = "user://options.dat"

const AMBIENCE_BUS_NAME = "BGSE"
const SFX_BUS_NAME = "SFX"

# DEFAULTS go in here.
var DEFAULTS = {
	"bgm_volume": 1,
	"ambience_volume": 1,
	"sfx_volume": 1,
	"invincible": false,
	"screen_shake": true
}

var data = {}

func save_to_disk() -> void:
	var json_blob = to_json(self.data)

	var options_file = File.new()
	options_file.open(_OPTIONS_FILE_NAME, File.WRITE)
	options_file.store_string(json_blob)
	options_file.close()

func _init() -> void:
	data = DEFAULTS # Prevent crash on first run
	_load_from_disk()

	# Update volume levels
	update_audio_volume(AMBIENCE_BUS_NAME, data["ambience_volume"])
	update_audio_volume(SFX_BUS_NAME, data["sfx_volume"])

# Value is a float from 0..1
func update_audio_volume(bus_name:String, value:float):
	var decibels = linear2db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), decibels)

func _load_from_disk() -> void:
	var options_file = File.new()
	if options_file.file_exists(_OPTIONS_FILE_NAME):
		options_file.open(_OPTIONS_FILE_NAME, File.READ)	
		var json_blob = options_file.get_as_text()
		options_file.close()
		
		var result = JSON.parse(json_blob)
		if result.error:
			push_error("Error reading options data: %s (line %s)" % [result.error_string, result.error_line])
		else:
			var loaded_data = result.result
			# Apply loaded_data on top of Options.data, so that any keys that are missing
			# from our options file, will get the defaults instead.
			for key in loaded_data.keys():
				self.data[key] = loaded_data[key]
