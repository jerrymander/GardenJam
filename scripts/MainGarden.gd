extends Control

const PLANT_CLASS = preload("Plant.gd")

onready var plant_data = get_node("/root/PlantData")

var cursor_passive = preload("res://asset/naraessets/Prototypes/glovecursor passive.png")
var cursor_active = preload("res://asset/naraessets/Prototypes/glovecursor active.png")

var audio_library = preload("res://scenes/AudioLibrary.tscn")
var audio_node
var current_selection

var selected_seed_packet

func _ready():
	set_process_input(true)
	get_node("Camera2D").set_pos(Vector2(750,325))
	audio_node = audio_library.instance()
	add_child(audio_node)
	audio_node.get_node("Songs/Ambiance").play()
	audio_node.play_song("Songs/PeacefulGarden")
	_init_seed_packet()
	_init_item_chest()

	
func _init_seed_packet():
	var packet = preload("res://scenes/objects/SeedPacket.tscn").instance()
	packet.set_pos(Vector2(0,550))
	add_child(packet)	

func _init_item_chest():
	var item_chest = preload("res://scenes/objects/ItemChest.tscn").instance()
	item_chest.set_pos(Vector2(225, 550))
	add_child(item_chest)

func _on_ToHouse_pressed():
	print("[MainGarden.gd] clicked")
	get_node("TransitionAnim").play("Camera Slide")
	audio_node.get_node("SFXLibrary").play("sfx_doink_1")
	audio_node.get_node("SFXLibrary").play("sfx_noisesweep_1")

func _on_ToPlot_pressed():
	print("[MainGarden.gd] clicked")
	get_node("TransitionAnim").play_backwards("Camera Slide")
	audio_node.get_node("SFXLibrary").play("sfx_noisesweep_1")

func _on_EnterHouse_pressed():
	print ("[MainGarden.gd] let's go inside...!")
	get_node("TransitionAnim").play("To House")
	audio_node.get_node("SFXLibrary").play("sfx_pluckypings_4")
	audio_node.song_transition_to("Songs/TurnipHouse")

func _on_ExitHouse_pressed():
	print ("[MainGarden.gd] let's go outside...!")
	get_node("TransitionAnim").play_backwards("To House")
	audio_node.get_node("SFXLibrary").play("sfx_pluckypings_8")
	audio_node.song_transition_to("Songs/PeacefulGarden")

func unset_selection():
	selected_seed_packet = null
	set_cursor_passive()
	
#func set_selection(var selection):
#	current_selection = selection
#	if (_nothing_is_selected()):
#		set_cursor_passive()

func _nothing_is_selected():
	return selected_seed_packet == null

func set_selected_seed_packet(var selection):
	selected_seed_packet = selection
	print("[MainGarden.gd] "+selection)
	Input.set_custom_mouse_cursor(plant_data.get_seed_packet_texture(selection))

func get_selected_seed_packet():
	return selected_seed_packet

func get_selection():
	return current_selection

func set_cursor_passive():
	# change cursor
	#var resized_passive = cursor_passive.get_data().resized(50,50)
	#cursor_passive.create_from_image(resized_passive)
	#var resized_active = cursor_active.get_data().resized(50,50)
	#cursor_active.create_from_image(resized_active)
	if (_nothing_is_selected()):
		Input.set_custom_mouse_cursor(cursor_passive)
	
func set_cursor_active():
	if (_nothing_is_selected()):
		Input.set_custom_mouse_cursor(cursor_active)

