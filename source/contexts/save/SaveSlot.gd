extends NinePatchRect

const SaveData = preload("res://contexts/save/SaveData.gd")

const _GAME_TIME_LABEL:String = "%s hour(s), %s minute(s)"

onready var _slot_label = $MarginContainer/VBoxContainer/SlotLabel
onready var _main_label = $MarginContainer/VBoxContainer/CenterContainer/MainLabel
onready var _time_label = $MarginContainer/VBoxContainer/TimeLabel

# Called after _ready
func initialize(save_slot:String, save_data:SaveData) -> void:
	_slot_label.text = "Slot %s" % str(save_slot)
	
	if save_data != null:
		var minutes = save_data.game_time_seconds / 60
		var hours = minutes / 60
		minutes = minutes % 60
		
		_time_label.text = _GAME_TIME_LABEL % [hours, minutes] # TODO: hours, minutes from game
		_main_label.text = "Actual save data"
	else:
		_main_label.text = "Empty"
		_time_label.visible = false
