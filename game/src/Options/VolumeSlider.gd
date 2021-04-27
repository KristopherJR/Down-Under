extends HSlider

export var audio_track_name := "Master"

onready var _track := AudioServer.get_bus_index(audio_track_name)


func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(_track))


func _on_VolumeSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_track, linear2db(value))

