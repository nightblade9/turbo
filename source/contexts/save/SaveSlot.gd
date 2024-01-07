extends TextureRect

signal load_game(data)

const SaveData = preload("res://contexts/save/SaveData.gd")

const _GAME_TIME_LABEL:String = "%s hour(s), %s minute(s)"

@onready var _slot_label = $MarginContainer/VBoxContainer/HBoxContainer/SlotLabel
@onready var _main_label = $MarginContainer/VBoxContainer/CenterContainer/MainLabel
@onready var _time_label = $MarginContainer/VBoxContainer/TimeLabel
@onready var _load_button = $MarginContainer/VBoxContainer/HBoxContainer/LoadButton 

var _save_data:SaveData

# Called after _ready
func initialize(save_slot:String, save_data:SaveData) -> void:
	_save_data = save_data
	_slot_label.text = "Slot %s" % str(save_slot)
	
	if save_data != null:
		var minutes = save_data.game_time_seconds / 60
		var hours = minutes / 60
		minutes = minutes % 60
		
		_time_label.text = _GAME_TIME_LABEL % [hours, minutes]
		_main_label.text = "Actual save data"
	else:
		_main_label.text = "Empty"
		_time_label.visible = false
		_load_button.visible = false

func _on_load_button_pressed():
	load_game.emit(_save_data)
