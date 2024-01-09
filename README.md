# ⚡ Turbo

"Batteries-included" template Godot project for 2D pixel-art web (and desktop) Godot games. Includes:

- Fancy cross-fades between scenes
- Persistent options with pre-baked settings (volumes, screen shake, invincibility)
- Save scene with save slots
- A game loading bar
- Gamepad and keyboard support
- A splash screen
- Initialize scenes and pass data to them pre-`_ready` when changing scenes
- Default one-handed controls (WASD)

Current project template is for Godot v4.x!

# 📖 Usage

The intended workflow is to use Turbo to quickly prototype your game, publish to HTML5, market it, and iterate. This is why it includes all the fixings to make a "full-fledged" game, including title screen, saving support, etc.

Look for the `# Implement` comments, and fill in the required functionality (e.g. instantiate a new-game scene in `TitleScene.gd`).

In general, you want to clone the project, and use that as your starting-point, customizing scenes to your liking. You should not plan to upgrade to a newer version of Turbo during your project (it's not easy to do so without overriding and losing your changes).

## Scene Transitions

- To change scenes via a fancy cross-fade, Call `SceneManager.change_scene_to(packed_scene:PackedScene, fade_image:String)` with `packed_scene` being either `load(...)` or `preload(...)`
- For the fade image, pick any of the filenames out of `addons/transitions/images` and specify the filename, e.g. `swirl`. For more options, including custom images, see the [Godot Fancy Scene Changes repo](https://github.com/nightblade9/godot-fancy-scene-changes)
- If you want to execute some logic before the `_ready` function on the new scene is called, add an `func initialize(params:Dictionary = {})` method to it, and call `SceneManager.change_scene_to(packed_scene, {... params go here ...})`, passing in the dictionary of parameters.

# ⚠️ Limitations

## Display ##

- The template window size is 720p; this allows for relatively safe deployment to HTML5 (in terms of user resolution). To better support desktop and console platforms, you can update it to 1080p or 540p (with scaling) at any time. 
- To make the resolution change as seamless as possible, use `anchor` properties and `Control` nodes to position HUD elements

# 🔧 Contributing

Contributions welcome! Please open an issue to discuss what kind of changes you have in mind, and/or open a PR with things working! Our goal is to make this as "batteries-included" as possible, while not becoming over-bloated or full of genre-specific or game-specific features.
