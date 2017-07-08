extends Node

const PLOT_WIDTH = 3
const PLOT_HEIGHT = 3
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	print(get_node("Sprite").get_texture().get_width())

func _input(ev):
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