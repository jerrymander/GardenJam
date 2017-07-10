extends Control

onready var turnip_house = preload("res://scenes/InsideTurnip.tscn")

func _ready():
	set_process_input(true)


func _on_ToHouse_pressed():
	print("clicked")
	get_node("TransitionAnim").play("Camera Slide")
	get_node("SamplePlayer").play("sfx_noisesweep_1")


func _on_ToPlot_pressed():
	get_node("TransitionAnim").play_backwards("Camera Slide")
	get_node("SamplePlayer").play("sfx_noisesweep_1")


func _on_EnterHouse_pressed():
	print ("to the house...!")
