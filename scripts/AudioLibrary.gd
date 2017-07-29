extends Node

var current_song
var out_song
var fade_out
var fade_in

var transitioning = false

func _ready():
	pass

func play_song(var song_name):
	if (current_song == null):
		current_song = get_node(song_name)
		current_song.play()
	else:
		current_song.play(false)
		current_song = get_node(song_name)
		current_song.play()

func stop_song():
	current_song.play(false)
	current_song = null

func song_transition_to(var next_song):
	if (current_song != null):
		fade_out()
		current_song = get_node(next_song)
	fade_in(next_song)

func fade_out():
	out_song = current_song
	fade_out = Tween.new()
	add_child(fade_out)
	fade_out.interpolate_method(
		self,
		"tween_fadeout",
		out_song.get_volume(),
		0,
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
		)
	fade_out.connect("tween_complete", self, "_on_fade_out_tween_complete")
	fade_out.start()

func fade_in(song):
	current_song = get_node(song)
	fade_in = Tween.new()
	add_child(fade_in)
	fade_in.interpolate_method(
		self,
		"tween_fadein",
		0,
		1,
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN,
		1
		)
	current_song.set_volume(0)
	current_song.play()
	fade_in.start()

func tween_fadeout(value):
	out_song.set_volume(value)

func tween_fadein(value):
	current_song.set_volume(value)

func play_sfx(var sfx_name):
	get_node("SFXLibrary").play(sfx_name)

func _on_PlayTurnipHouse_pressed():
	song_transition_to("Songs/TurnipHouse")

func _on_fade_out_tween_complete():
	out_song.play(false)

func _on_PlayPeacefulGarden_pressed():
	song_transition_to("Songs/PeacefulGarden")

func _on_CurrentSong_pressed():
	if (current_song != null):
		print(current_song.get_name())
	else:
		print("No song is playing.")
