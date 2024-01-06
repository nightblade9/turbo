extends Resource

const _OPTIONS_FILE_NAME = "user://options.tres"

# Sane defaults for when the user hasn't saved these yet
@export var bgm_volume:float = 1.0
@export var ambience_volume:float = 1.0
@export var sfx_volume:float = 1.0
@export var invincible:bool = false
@export var screen_shake:bool = true

func save_data():
	var result = ResourceSaver.save(self, _OPTIONS_FILE_NAME)
	if result != OK:
		push_error("Failed to save data! Result was: %s" % result)
	
static func load_data() -> Resource:
	if ResourceLoader.exists(_OPTIONS_FILE_NAME):
		return load(_OPTIONS_FILE_NAME)
	
	return null
