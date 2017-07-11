extends Control

const PLANT_CLASS = preload("Plant.gd")

onready var turnip_house = preload("res://scenes/InsideTurnip.tscn")
var cursor_passive = preload("res://asset/naraessets/glovecursor passive.png")
var cursor_active = preload("res://asset/naraessets/glovecursor active.png")

var seed_packet = preload("res://scenes/objects/SeedPacket.tscn")
var current_selection

func _ready():
	set_process_input(true)
	var packet = seed_packet.instance()
	packet.set_pos(Vector2(0,550))
	add_child(packet)

func _on_ToHouse_pressed():
	print("clicked")
	get_node("TransitionAnim").play("Camera Slide")
	get_node("SamplePlayer").play("sfx_noisesweep_1")


func _on_ToPlot_pressed():
	get_node("TransitionAnim").play_backwards("Camera Slide")
	get_node("SamplePlayer").play("sfx_noisesweep_1")


func _on_EnterHouse_pressed():
	print ("to the house...!")

func set_selection(var selection):
	current_selection = selection
	if (current_selection == null):
		set_cursor_passive()
	elif (current_selection extends PLANT_CLASS):
		print("[MainGarden.gd] "+selection.get_plant_name())
		Input.set_custom_mouse_cursor(selection.get_plant_seedbag())

func get_selection():
	return current_selection

func set_cursor_passive():
	# change cursor
	#var resized_passive = cursor_passive.get_data().resized(50,50)
	#cursor_passive.create_from_image(resized_passive)
	#var resized_active = cursor_active.get_data().resized(50,50)
	#cursor_active.create_from_image(resized_active)
	if (current_selection == null):
		Input.set_custom_mouse_cursor(cursor_passive)
	
func set_cursor_active():
	if (current_selection == null):
		Input.set_custom_mouse_cursor(cursor_active)