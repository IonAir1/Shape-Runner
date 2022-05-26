extends Node

var sound_bus = AudioServer.get_bus_index("Sounds")
var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	yield(get_tree().create_timer(2.5), "timeout")
	play_music(0)

func _process(delta):
	if Global.sounds: #muting and unmuing sound and music buses
		AudioServer.set_bus_mute(sound_bus, false)
	else:
		AudioServer.set_bus_mute(sound_bus, true)
	if Global.music:
		AudioServer.set_bus_mute(music_bus, false)
	else:
		AudioServer.set_bus_mute(music_bus, true)

func _on_a_bit_of_hope_finished():
	play_music(1)

func _on_retro_platforming_finished():
	play_music(2)

func play_music(music):
	randomize() #play the other music when one finishes
	if music == 1:
		$"retro platforming".play()
	elif music == 2:
		$"a bit of hope".play()
	else: #play a random music when the game starts
		if randi()%2 > 0:
			$"a bit of hope".play()
		else:
			$"retro platforming".play()
