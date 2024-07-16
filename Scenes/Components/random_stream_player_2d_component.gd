extends AudioStreamPlayer2D

@export var streams: Array[AudioStream]

func play_random():
	if streams == null || streams.size() == 0:
		return
	var chosen_stream = streams.pick_random()
	stream = chosen_stream
	play()