extends Node

const PLANT_CLASS = preload("Plant.gd")

onready var plant = preload("res://scenes/objects/Plant.tscn")

const PLOT_WIDTH = 3
const PLOT_HEIGHT = 3

var plot_width_per
var plot_height_per

var plot = []

func _ready():
	set_process_input(true)
	
	# calculate plot grid dimensions
	var sprite_node = get_node("Sprite")
	var sprite_texture = sprite_node.get_texture()
	var sprite_width = sprite_texture.get_width() * sprite_node.get_scale().x
	var sprite_height = sprite_texture.get_height() * sprite_node.get_scale().y
	plot_width_per = sprite_width / PLOT_WIDTH
	plot_height_per = sprite_height / PLOT_HEIGHT
	get_node("../Camera2D").set_pos(Vector2(250,325))
	get_node("../Ambiance").set_volume(1.5)
	get_node("../BGM").set_volume(0.7)
	
	get_tree().get_root().get_node("GardenJam").set_cursor_passive()
	
	# init plot array/grid
	for x in range(PLOT_WIDTH):
		plot.append([])
		for y in range(PLOT_HEIGHT):
			plot[x].append(null)
	

func _input(var ev):
	_decide_mouse_cursor(ev)
	if (ev.type == InputEvent.MOUSE_BUTTON && ev.pressed):
		# calculate coordinate of click
		var plot_click_x = ev.pos.x - get_pos().x
		var plot_click_y = ev.pos.y - get_pos().y
		plot_click_x = floor(plot_click_x / plot_width_per)
		plot_click_y = floor(plot_click_y / plot_height_per)
		
		if (plot_click_x < PLOT_WIDTH && plot_click_y < PLOT_HEIGHT 
			&& plot_click_x >= 0 && plot_click_y >= 0):
			_poke_plot(plot_click_x, plot_click_y)
		
		if (ev.button_index == 2): #right click
			get_tree().get_root().get_node("GardenJam").set_selection(null)

func _poke_plot(var x, var y):
	if (plot[x][y] == null):
		var selection = get_tree().get_root().get_node("GardenJam").get_selection()
		if (selection == null || !selection extends PLANT_CLASS):
			return
		plot[x][y] = plant.instance().init_plant(selection.get_plant_name(), selection.get_plant_seedbag(), selection.get_plant_frames())
		plot[x][y].set_scale(selection.get_scale())
		var centered_position = Vector2(
			(x+0.5)*plot_width_per, 
			(y+0.5)*plot_height_per)
		plot[x][y].set_pos(centered_position)
		add_child(plot[x][y])
		get_node("../SamplePlayer").play("sfx_doink_2")
		#print(str(x)+", "+str(y))
	else:
		if (plot[x][y].is_grown()):
			#print("rip")
			plot[x][y].queue_free()
			plot[x][y] = null
			get_node("../SamplePlayer").play("sfx_veggierip_2")
		else:
			plot[x][y].grow()

func _decide_mouse_cursor(var ev):
	if (ev.type == InputEvent.MOUSE_BUTTON && ev.pressed):
		get_tree().get_root().get_node("GardenJam").set_cursor_active()
	else:
		get_tree().get_root().get_node("GardenJam").set_cursor_passive()

