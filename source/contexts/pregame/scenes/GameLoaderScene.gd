extends Control

onready var _progress_bar = $MarginContainer/VBoxContainer/ProgressBar

func _ready():
	var loader = ResourceLoader.load_interactive("res://contexts/pregame/scenes/SplashScene.tscn")
	
	while true:
		var error = loader.poll()
		if error == ERR_FILE_EOF:
			# loading complete
			_progress_bar.value = 100
			yield(get_tree(), "idle_frame")
			var packed_scene = loader.get_resource()
			get_tree().change_scene_to(packed_scene)
		elif error == OK:
			# Still loading ...
			var progress_percent = 100 * loader.get_stage() / loader.get_stage_count()
			_progress_bar.value = progress_percent
			yield(get_tree(), "idle_frame")
