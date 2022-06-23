# Turbo

"Batteries-included" template Godot project for 2D pixel-art web (and desktop) Godot games. Includes:

- Fancy cross-fades between scenes
- Persistent options with pre-baked settings (volumes, screen shake, invincibility)
- Save scene with save slots
- A game loading bar
- Gamepad support
- Splash screen
- Initialize scenes and pass data to them pre-`_ready` when changing scenes
- Default one-handed controls (WASD)

Current project template is for Godot v3.4.4.

# Usage

In general, you want to clone the project, and use that as your starting-point, customizing scenes to your liking. You should not plan to upgrade to a newer version of Turbo during your project (it's not easy to do so without overriding and losing your changes).

## Scene Transitions

- To change scenes via a fancy cross-fade, Call `SceneManager.change_scene_to(packed_scene:PackedScene)` with `packed_scene` being either `load(...)` or `preload(...)`
- If you want to execute some logic before the `_ready` function on the new scene is called, add an `func initialize(params:Dictionary = {})` method to it, and call `SceneManager.change_scene_to(packed_scene, {... params go here ...})`, passing in the dictionary of parameters.

# Limitations

## Display ##

- The template window size is 720p; this allows for relatively safe deployment to HTML5 (in terms of user resolution). To better support desktop and console platforms, you can update it to 1080p at any time. 
- To make the resolution change as seamless as possible, use `anchor` properties and `Control` nodes to position HUD elements
