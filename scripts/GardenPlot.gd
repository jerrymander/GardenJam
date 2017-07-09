extends Node

const PLOT_WIDTH = 3
const PLOT_HEIGHT = 3

onready var cursor_passive = preload("res://asset/naraessets/glovecursor passive.png")
onready var cursor_active = preload("res://asset/naraessets/glovecursor active.png")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var plot = []

func _ready():
	set_process_input(true)
	#var resized_passive = cursor_passive.get_data().resized(50,50)
	#cursor_passive.create_from_image(resized_passive)
	#var resized_active = cursor_active.get_data().resized(50,50)
	#cursor_active.create_from_image(resized_active)
	Input.set_custom_mouse_cursor(cursor_passive)

func _input(ev):
	_decide_mouse_cursor(ev)
	if (ev.type == InputEvent.MOUSE_BUTTON && ev.pressed):
		var sprite_texture = get_node("Sprite").get_texture()
		var sprite_width = sprite_texture.get_width()
		var sprite_height = sprite_texture.get_height()
		var plot_width_per = sprite_width / PLOT_WIDTH
		var plot_height_per = sprite_height / PLOT_HEIGHT
		
		var plot_click_x = floor(ev.pos.x / plot_width_per)
		var plot_click_y = floor(ev.pos.y / plot_height_per)
		
		if (plot_click_x < PLOT_WIDTH && plot_click_y < PLOT_HEIGHT):
			print(str(plot_click_x)+", "+str(plot_click_y))

func _decide_mouse_cursor(ev):
	if (ev.type == InputEvent.MOUSE_BUTTON && ev.pressed):
		Input.set_custom_mouse_cursor(cursor_active)
	else:
		Input.set_custom_mouse_cursor(cursor_passive)