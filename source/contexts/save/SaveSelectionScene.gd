extends Control

const CloseOnEscape = preload("res://scripts/CloseOnEscape.gd")
const GamepadNavigator = preload("res://scripts/GamepadNavigator.gd")
const SaveSlot = preload("res://contexts/save/SaveSlot.tscn")
var TitleScene = load("res://contexts/pregame/scenes/TitleScene.tscn")

const _NUM_SAVE_SLOTS:int = 3

@onready var _save_slot_container = $MarginContainer/ScrollContainer/VBoxContainer

func _ready():
	for i in range(_NUM_SAVE_SLOTS):
		var slot:String = str(i)
		var save_slot = SaveSlot.instantiate()
		_save_slot_container.add_child(save_slot)

		var game_data:SaveData = SaveData.load_data(slot)
		save_slot.initialize(slot, game_data)
		save_slot.load_game.connect(_on_load_game)
	
	add_child(GamepadNavigator.new())
		
func _on_back_to_title_button_pressed():
	FancyFade.cross_fade(TitleScene.instantiate())

func _input(event):
	CloseOnEscape.on_input(event, _on_back_to_title_button_pressed)

func _on_load_game(save_data:SaveData) -> void:
	# Implement: load the game!
	pass
