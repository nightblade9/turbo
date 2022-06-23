extends Control

onready var _percent_label = $MarginContainer/VBoxContainer/PercentLabel

const _LOADING_MESSAGE:String = "Loading ... %s%%"

func _ready():
	var loader = ResourceLoader.load_interactive("res://contexts/pregame/scenes/SplashScene.tscn")
	
	while true:
		var error = loader.poll()
		if error == ERR_FILE_EOF:
			# loading complete
			_percent_label.text = _LOADING_MESSAGE % str(100)
			yield(get_tree(), "idle_frame")
			var packed_scene = loader.get_resource()
			get_tree().change_scene_to(packed_scene)
		elif error == OK:
			# Still loading ...
			var progress_percent = 100 * loader.get_stage() / loader.get_stage_count()
			_percent_label.text = _LOADING_MESSAGE % progress_percent
			yield(get_tree(), "idle_frame")
