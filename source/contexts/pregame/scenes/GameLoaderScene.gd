extends Control

# Via: https://www.gotut.net/loading-screen-in-godot-4/

const target_scene_path:String = "res://contexts/pregame/scenes/SplashScene.tscn"

var _loading_status : int
var _progress : Array[float]

@onready var _progress_bar:ProgressBar = %ProgressBar

func _ready() -> void:
	# Request to load the target scene:
	ResourceLoader.load_threaded_request(target_scene_path)
	
func _process(_delta: float) -> void:
	# Update the status:
	_loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, _progress)
	
	# Check the loading status:
	match _loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			_progress_bar.value = _progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happend:
			print("Error. Could not load Resource")
