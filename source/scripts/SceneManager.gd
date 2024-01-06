extends Node

func change_scene_to_packed(packed_scene:PackedScene,
	fade_filename:String = "",
	fade_time:float = 1.0,
	params = {}
) -> void:
	
	var instance = packed_scene.instantiate()
	
	if instance.has_method("initialize"):
		instance.initialize(params)
	
	# TODO: pause both scenes, and unpause the new scene after the fade's done
	FancyFade.custom_fade(instance, fade_time, load("res://addons/transitions/images/%s.png" % fade_filename))
