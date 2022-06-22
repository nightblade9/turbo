# Turbo

Batteries-included template for 2D pixel-art web and desktop Godot games.

Current project template is for Godot v3.4.4.

# Usage

## Scene Transitions

- To change scenes via a fancy cross-fade, Call `SceneManager.change_scene_to(packed_scene:PackedScene)` with `packed_scene` being either `load(...)` or `preload(...)`
- If you want to execute some logic before the `_ready` function on the new scene is called, add an `func initialize(params:Dictionary = {})` method to it, and call `SceneManager.change_scene_to(packed_scene, {... params go here ...})`, passing in the dictionary of parameters.

# Limitations

## Display ##

- The template window size is 720p; this allows for relatively safe deployment to HTML5 (in terms of user resolution). You can update it to 1080p at any time.
