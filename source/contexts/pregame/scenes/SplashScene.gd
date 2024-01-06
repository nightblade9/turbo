extends Control

const _FADE_SECONDS:float = 1.0
const _WAIT_SECONDS:float = 3.3

@onready var _logo = $TextureRect

func _ready():
	if OS.has_feature("debug"):
		call_deferred("_on_fade_out_done")
		return
		
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(_logo, "self_modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), _FADE_SECONDS)
	tween.connect("tween_all_completed", Callable(self, "_on_fade_in_done"))
	tween.start()
	
func _on_fade_in_done():
	await get_tree().create_timer(_WAIT_SECONDS).timeout
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(_logo, "self_modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), _FADE_SECONDS)
	tween.connect("tween_all_completed", Callable(self, "_on_fade_out_done"))
	tween.start()

func _on_fade_out_done():
	get_tree().change_scene_to_file("res://contexts/pregame/scenes/TitleScene.tscn")
