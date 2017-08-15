extends Control

const PLANT_CLASS = preload("Plant.gd")

onready var plant_data = get_node("/root/PlantData")
onready var decor_data = get_node("/root/DecorData")
onready var animations = get_node("TransitionAnim")

var cursor_passive = preload("res://asset/naraessets/Prototypes/cursor prototype_passive.png")
var cursor_active = preload("res://asset/naraessets/Prototypes/cursor prototype_active.png")

var audio_library = preload("res://scenes/AudioLibrary.tscn")
var audio_node
var seed_packet = preload("res://scenes/objects/SeedPacket.tscn")
var current_selection
var screen_transition_black = preload("res://scenes/objects/BlackScreenTransition.tscn")
var black_screen
var inventory = preload("res://scenes/Inventory.tscn")
var inventory_screen

var selected_seed_packet

func _ready():
	set_process_input(true)
	get_node("Camera2D").set_pos(Vector2(810,480))
	audio_node = audio_library.instance()
	add_child(audio_node)
	audio_node.get_node("Songs/Ambiance").play()
	audio_node.play_song("Songs/PeacefulGarden")
	var packet = seed_packet.instance()
	packet.set_pos(Vector2(0,750))
	add_child(packet)
	
	black_screen = screen_transition_black.instance()
	black_screen.set_pos(Vector2(0,0))
	add_child(black_screen)
	
	inventory_screen = inventory.instance()
	inventory_screen.set_name("Inventory")
	inventory_screen.set("visibility/visible", false)
	inventory_screen.set("focus/stop_mouse", false)
	inventory_screen.set("focus/ignore_mouse", true)
	add_child(inventory_screen)
	randomize()

func _on_ToHouse_pressed():
	print("[MainGarden.gd] Swipe right.")
	get_node("TransitionAnim").play("Camera Slide")
	audio_node.get_node("SFXLibrary").play("sfx_doink_1")
	audio_node.get_node("SFXLibrary").play("sfx_noisesweep_1")

func _on_ToPlot_pressed():
	print("[MainGarden.gd] Swipe left.")
	get_node("TransitionAnim").play_backwards("Camera Slide")
	audio_node.get_node("SFXLibrary").play("sfx_noisesweep_1")

func _on_EnterHouse_pressed():
	print ("[MainGarden.gd] let's go inside...!")
	get_node("TransitionAnim").play("To House")
	black_screen.get_child(0).play("Fade_Black")
	audio_node.get_node("SFXLibrary").play("sfx_pluckypings_4")
	audio_node.song_transition_to("Songs/TurnipHouse")

func _on_ExitHouse_pressed():
	print ("[MainGarden.gd] let's go outside...!")
	get_node("TransitionAnim").play_backwards("To House")
	black_screen.get_child(0).play("Fade_Black")
	audio_node.get_node("SFXLibrary").play("sfx_pluckypings_8")
	audio_node.song_transition_to("Songs/PeacefulGarden")

func _on_ChestButton_pressed():
	print ("Opening Chest...")
	toggle_inventory()

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

func toggle_inventory():
	inventory_screen.set_pos(Vector2(1087,24))
	inventory_screen.set("visibility/visible", !inventory_screen.get("visibility/visible"))
	inventory_screen.set("focus/stop_mouse", !inventory_screen.get("focus/stop_mouse"))
	inventory_screen.set("focus/ignore_mouse", !inventory_screen.get("focus/ignore_mouse"))
